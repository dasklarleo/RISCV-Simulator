/*
 * Implementation of a simple cache simulator
 *
 * Created By He, Hao in 2019-04-27
 */

#include <cstdio>
#include <cstdlib>

#include "Cache.h"
//policy是这个cache策略，记录了怎么写怎么替换每个块的大小
Cache::Cache(MemoryManager *manager, Policy policy,bool exclusion, Cache *lowerCache,
             bool writeBack, bool writeAllocate) {
  this->referenceCounter = 0;//LRU
  this->memory = manager;//内存
  this->policy = policy;//cache的策略，包含了cache的大小、路数、block的大小、hit或者not hit的各自的延迟
  this->lowerCache = lowerCache;//下一级的cache
  if (!this->isPolicyValid()) {
    fprintf(stderr, "Policy invalid!\n");
    exit(-1);
  }
  this->initCache();
  this->statistics.numRead = 0;
  this->statistics.numWrite = 0;
  this->statistics.numHit = 0;
  this->statistics.numMiss = 0;
  this->statistics.totalCycles = 0;
  this->writeBack = writeBack;
  this->writeAllocate = writeAllocate;
  this->exclusion=exclusion;
}

bool Cache::inCache(uint32_t addr) {
  return getBlockId(addr) != -1 ? true : false;
}

uint32_t Cache::getBlockId(uint32_t addr) {//根据block的id以及tag判断地址是否被cache缓存
  uint32_t tag = this->getTag(addr);
  uint32_t id = this->getId(addr);
  // printf("0x%x 0x%x 0x%x\n", addr, tag, id);
  // iterate over the given set
  for (uint32_t i = id * policy.associativity;
       i < (id + 1) * policy.associativity; ++i) {
    if (this->blocks[i].id != id) {
      fprintf(stderr, "Inconsistent ID in block %d\n", i);
      exit(-1);
    }
    if (this->blocks[i].valid && this->blocks[i].tag == tag) {
      return i;
    }
  }
  return -1;
}

uint8_t Cache::getByte(uint32_t addr, uint32_t *cycles) {
  this->referenceCounter++;
  this->statistics.numRead++;
  // If in cache, return directly
  int blockId;
  if ((blockId = this->getBlockId(addr)) != -1) {//被缓存了
    
    uint32_t offset = this->getOffset(addr);//block块内的偏移
    this->statistics.numHit++;
    this->statistics.totalCycles += this->policy.hitLatency;//找到了因此只需要加一个命中的缓存
    this->blocks[blockId].lastReference = this->referenceCounter;
    if (cycles) *cycles = this->policy.hitLatency;
    return this->blocks[blockId].data[offset];
  }

  // Else, find the data in memory or other level of cache
  this->statistics.numMiss++;
  this->statistics.totalCycles += this->policy.missLatency;//没找到因此需要加一个未命中的缓存
  this->loadBlockFromLowerLevel(addr, cycles);//从下一级cache或memory找，这里存在着问题！！！！！！

  // The block is in top level cache now, return directly
  if ((blockId = this->getBlockId(addr)) != -1) {//和最上面的一模一样
    uint32_t offset = this->getOffset(addr);
    this->blocks[blockId].lastReference = this->referenceCounter;
    return this->blocks[blockId].data[offset];
  } else {
    fprintf(stderr, "Error: data not in top level cache!\n");
    exit(-1);
  }
}

void Cache::setByte(uint32_t addr, uint8_t val, uint32_t *cycles) {
  this->referenceCounter++;
  this->statistics.numWrite++;

  // If in cache, write to it directly
  int blockId;
  if ((blockId = this->getBlockId(addr)) != -1) {//在L1之中就可以修改
    uint32_t offset = this->getOffset(addr);
    this->statistics.numHit++;
    this->statistics.totalCycles += this->policy.hitLatency;//找到了,因此只需要加一个命中的缓存的时间
    this->blocks[blockId].modified = true;//修改标记位
    this->blocks[blockId].lastReference = this->referenceCounter;//LRU
    this->blocks[blockId].data[offset] = val;//偏移
    if (!this->writeBack) {//writeThrough，就直接写到这一级和下一级
      this->writeBlockToLowerLevel(this->blocks[blockId]);
      this->statistics.totalCycles += this->policy.missLatency;//访问了下一级，因此需要加一个未命中的缓存的时间
    }
    if (cycles) *cycles = this->policy.hitLatency;
    return;
  }

  // Else, load the data from cache
  // TODO: implement bypassing
  this->statistics.numMiss++;
  this->statistics.totalCycles += this->policy.missLatency;//需要加一个未命中的缓存的时间

  if (this->writeAllocate) {//写分配，因此需要读到cache之中
    this->loadBlockFromLowerLevel(addr, cycles);//读到cache之中

    if ((blockId = this->getBlockId(addr)) != -1) {
      uint32_t offset = this->getOffset(addr);
      this->blocks[blockId].modified = true;
      this->blocks[blockId].lastReference = this->referenceCounter;
      this->blocks[blockId].data[offset] = val;
      return;
    } else {
      fprintf(stderr, "Error: data not in top level cache!\n");
      exit(-1);
    }
  } else {//把任务分配到下一层的cache
    if (this->lowerCache == nullptr) {//下层只有memory了，只能用memory操作
      this->memory->setByteNoCache(addr, val);
    } else {
      this->lowerCache->setByte(addr, val);//下层cache
    }
  }
}

void Cache::printInfo(bool verbose) {
  printf("---------- Cache Info -----------\n");
  printf("Cache Size: %d bytes\n", this->policy.cacheSize);
  printf("Block Size: %d bytes\n", this->policy.blockSize);
  printf("Block Num: %d\n", this->policy.blockNum);
  printf("Associativiy: %d\n", this->policy.associativity);
  printf("Hit Latency: %d\n", this->policy.hitLatency);
  printf("Miss Latency: %d\n", this->policy.missLatency);

  if (verbose) {
    for (int j = 0; j < this->blocks.size(); ++j) {
      const Block &b = this->blocks[j];
      printf("Block %d: tag 0x%x id %d %s %s (last ref %d)\n", j, b.tag, b.id,
             b.valid ? "valid" : "invalid",
             b.modified ? "modified" : "unmodified", b.lastReference);
      // printf("Data: ");
      // for (uint8_t d : b.data)
      // printf("%d ", d);
      // printf("\n");
    }
  }
}

void Cache::printStatistics() {
  printf("-------- STATISTICS ----------\n");
  printf("Num Read: %d\n", this->statistics.numRead);
  printf("Num Write: %d\n", this->statistics.numWrite);
  printf("Num Hit: %d\n", this->statistics.numHit);
  printf("Num Miss: %d\n", this->statistics.numMiss);
  printf("Total Cycles: %llu\n", this->statistics.totalCycles);
  if (this->lowerCache != nullptr) {
    printf("---------- LOWER CACHE ----------\n");
    this->lowerCache->printStatistics();
  }
}

bool Cache::isPolicyValid() {
  if (!this->isPowerOfTwo(policy.cacheSize)) {
    fprintf(stderr, "Invalid Cache Size %d\n", policy.cacheSize);
    return false;
  }
  if (!this->isPowerOfTwo(policy.blockSize)) {
    fprintf(stderr, "Invalid Block Size %d\n", policy.blockSize);
    return false;
  }
  if (policy.cacheSize % policy.blockSize != 0) {
    fprintf(stderr, "cacheSize %% blockSize != 0\n");
    return false;
  }
  if (policy.blockNum * policy.blockSize != policy.cacheSize) {
    fprintf(stderr, "blockNum * blockSize != cacheSize\n");
    return false;
  }
  if (policy.blockNum % policy.associativity != 0) {
    fprintf(stderr, "blockNum %% associativity != 0\n");
    return false;
  }
  return true;
}

void Cache::initCache() {//初始化cache的大小
  this->blocks = std::vector<Block>(policy.blockNum);
  for (uint32_t i = 0; i < this->blocks.size(); ++i) {
    Block &b = this->blocks[i];//第b块cache
    b.valid = false;//是不是在cache之中
    b.modified = false;//有没有被修改
    b.size = policy.blockSize;//block的大小
    b.tag = 0;//tag位
    b.id = i / policy.associativity;//第几个set
    b.lastReference = 0;//LRU使用的位
    b.data = std::vector<uint8_t>(b.size);
  }
}

void Cache::loadBlockFromLowerLevel(uint32_t addr, uint32_t *cycles) {//一下load一个块
  uint32_t blockSize = this->policy.blockSize;

  // Initialize new block b from memory
  Block b;
  uint32_t blockID;

  b.valid = true;
  b.modified = false;
  b.tag = this->getTag(addr);
  b.id = this->getId(addr);
  b.size = blockSize;
  b.data = std::vector<uint8_t>(b.size);
  uint32_t bits = this->log2i(blockSize);//blocksize占地址位的个数
  uint32_t mask = ~((1 << bits) - 1);//这个是根据address找到块的起始地址
  uint32_t blockAddrBegin = addr & mask;//这个是根据address找到块的起始地址
  for (uint32_t i = blockAddrBegin; i < blockAddrBegin + blockSize; ++i) {//根据address块的起始地址，读取一个块
    if (this->lowerCache == nullptr) {//底层cache，直接读内存（一个字节一个字节地读）
      b.data[i - blockAddrBegin] = this->memory->getByteNoCache(i);
      if (cycles) *cycles = 100;
    } else 
      b.data[i - blockAddrBegin] = this->lowerCache->getByte(i, cycles);//非底层cache，根据下一层cache来读，如果是exclusive可以直接把底层的valid变成false
  }
  if(this->exclusion){//消除L2还有L3 cache的这个block
      //std::cout<<"CACHE EXCLUSIVE"<<std::endl;
        if(this->lowerCache!=nullptr){
          blockID=this->lowerCache->getBlockId(addr);
          if (blockID!=-1){
            this->lowerCache->blocks[blockID].valid=false;
          }
          if(this->lowerCache->lowerCache!=nullptr){
            blockID=this->lowerCache->lowerCache->getBlockId(addr);
            if (blockID!=-1){
              this->lowerCache->lowerCache->blocks[blockID].valid=false;
            }
          }  
        }
      }else{
      //std::cout<<"CACHE INCLUSIVE"<<std::endl;
      }
  // 最后这个b就是要读的块
  // Find replace block,为什么不先判断一下L1 cache是不是满的呢
  uint32_t id = this->getId(addr);
  uint32_t blockIdBegin = id * this->policy.associativity;
  uint32_t blockIdEnd = (id + 1) * this->policy.associativity;
  uint32_t replaceId = this->getReplacementBlockId(blockIdBegin, blockIdEnd);//最高层的可替换的cache block
  Block replaceBlock = this->blocks[replaceId];//找到了要替换的block
  if(this->exclusion &&replaceBlock.valid==true){//exclusion的话直接写到下一级
    this->writeBlockToLowerLevel(replaceBlock);
    this->statistics.totalCycles += this->policy.missLatency;
  }else{
  if (this->writeBack && replaceBlock.valid &&
      replaceBlock.modified) { // write back to memory
      this->writeBlockToLowerLevel(replaceBlock);
      this->statistics.totalCycles += this->policy.missLatency;
    }
  }
  

  this->blocks[replaceId] = b;
}

uint32_t Cache::getReplacementBlockId(uint32_t begin, uint32_t end) {
  // Find invalid block first
  for (uint32_t i = begin; i < end; ++i) {
    if (!this->blocks[i].valid)
      return i;
  }

  // Otherwise use LRU
  uint32_t resultId = begin;
  uint32_t min = this->blocks[begin].lastReference;
  for (uint32_t i = begin; i < end; ++i) {
    if (this->blocks[i].lastReference < min) {
      resultId = i;
      min = this->blocks[i].lastReference;
    }
  }
  return resultId;
}

void Cache::writeBlockToLowerLevel(Cache::Block &b) {
  uint32_t addrBegin = this->getAddr(b);
  if (this->lowerCache == nullptr) {
    for (uint32_t i = 0; i < b.size; ++i) {
      this->memory->setByteNoCache(addrBegin + i, b.data[i]);
    }
  } else {
    for (uint32_t i = 0; i < b.size; ++i) {
      this->lowerCache->setByte(addrBegin + i, b.data[i]);
    }
  }
}

bool Cache::isPowerOfTwo(uint32_t n) { return n > 0 && (n & (n - 1)) == 0; }

uint32_t Cache::log2i(uint32_t val) {
  if (val == 0)
    return uint32_t(-1);
  if (val == 1)
    return 0;
  uint32_t ret = 0;
  while (val > 1) {
    val >>= 1;
    ret++;
  }
  return ret;
}

uint32_t Cache::getTag(uint32_t addr) {
  uint32_t offsetBits = log2i(policy.blockSize);
  uint32_t idBits = log2i(policy.blockNum / policy.associativity);
  uint32_t mask = (1 << (32 - offsetBits - idBits)) - 1;
  return (addr >> (offsetBits + idBits)) & mask;
}

uint32_t Cache::getId(uint32_t addr) {
  uint32_t offsetBits = log2i(policy.blockSize);
  uint32_t idBits = log2i(policy.blockNum / policy.associativity);
  uint32_t mask = (1 << idBits) - 1;
  return (addr >> offsetBits) & mask;
}

uint32_t Cache::getOffset(uint32_t addr) {
  uint32_t bits = log2i(policy.blockSize);
  uint32_t mask = (1 << bits) - 1;
  return addr & mask;
}

uint32_t Cache::getAddr(Cache::Block &b) {
  uint32_t offsetBits = log2i(policy.blockSize);
  uint32_t idBits = log2i(policy.blockNum / policy.associativity);
  return (b.tag << (offsetBits + idBits)) | (b.id << offsetBits);
}