/*
 * Implementation of a simple cache simulator
 *
 * Created By He, Hao in 2019-04-27
 */

#include <cstdio>
#include <cstdlib>
#include <assert.h>

#include "Cache.h"
//policy是这个cache策略，记录了怎么写怎么替换每个块的大小
Cache::Cache(MemoryManager *manager, Policy policy, bool exclusion, Cache *lowerCache,
             bool writeBack, bool writeAllocate, sampler* s,bool SDBP) {
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
  this->s=s;
  this->SDBP=SDBP;
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

uint8_t Cache::getByte(uint32_t addr, uint32_t *cycles) {//如果在L2 cahche之中被访问到，那么仅仅徐压迫更新sampler和predictor table。如果在LLC被调用，LLC就需要在替换的时候根据地址运行getPrediction函数判断这个块是不是dead 从而优先替换出dead block
  this->referenceCounter++;
  this->statistics.numRead++;
  // If in cache, return directly
  int blockId;
  if ((blockId = this->getBlockId(addr)) != -1) {//被缓存了
    uint32_t offset = this->getOffset(addr);//block块内的偏移
    this->statistics.numHit++;
    this->statistics.totalCycles += this->policy.hitLatency;//找到了因此只需要加一个命中的缓存
    this->blocks[blockId].lastReference = this->referenceCounter;
    if (cycles){*cycles = this->policy.hitLatency;} 
    if(this->SDBP){
      this->blocks[blockId].trace=make_trace(this->memory->pc);
    }
    if(this->SDBP){//模拟L3 cache有sampler
      uint32_t setID=getId(addr);
      uint32_t tag=getTag(addr);
      if ((setID%2==0)){//访问到sampler之中的set
        this->s->access(setID/2,tag,memory->pc);//update,setID是要除以32，tag也要变成partial tag，PC变成partial PC
      }
    }
    return this->blocks[blockId].data[offset];
  }
  // Else, find the data in memory or other level of cache or bypass
  this->statistics.numMiss++;
  this->statistics.totalCycles += this->policy.missLatency;//没找到因此需要加一个未命中的缓存
  this->loadBlockFromLowerLevel(addr, cycles);//从下一级cache或memory找
  

  // The block is in top level cache now, return directly
  if ((blockId = this->getBlockId(addr)) != -1) {//和最上面的一模一样
    if(this->SDBP){//模拟L3 cache有sampler
      uint32_t setID=getId(addr);
      uint32_t tag=getTag(addr);
      if ((setID%2==0)){//访问到sampler之中的set
        this->s->access(setID/2,tag,memory->pc);//update,setID是要除以32，tag也要变成partial tag，PC变成partial PC
      }
    }
    if(this->SDBP){
        this->blocks[blockId].trace=make_trace(this->memory->pc);
      }
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
    if(this->SDBP){//模拟L3 cache有sampler
      uint32_t setID=getId(addr);
      uint32_t tag=getTag(addr);
      if ((setID%2==0)){//访问到sampler之中的set
        this->s->access(setID/2,tag,memory->pc);//update,setID是要除以32，tag也要变成partial tag，PC变成partial PC
      }
    }
    if(this->SDBP){
      this->blocks[blockId].trace=make_trace(this->memory->pc);
    }
    this->blocks[blockId].modified = true;//修改标记位
    this->blocks[blockId].lastReference = this->referenceCounter;//LRU
    this->blocks[blockId].data[offset] = val;//偏移
    if (!this->writeBack) {//writeThrough，就直接写到这一级和下一级
      if(this->exclusion){
        this->memory->setMemory(addr,val);
        this->statistics.totalCycles += 100;//访问了memory
        return;
      }
      this->statistics.totalCycles += this->policy.missLatency;//访问了下一级，因此需要加一个未命中的缓存的时间
    }
    if (cycles) *cycles = this->policy.hitLatency;
    return;
  }

  // Else, load the data from cache
  // TODO: implement bypassing

  this->statistics.numMiss++;
  this->statistics.totalCycles += this->policy.missLatency;//没找到因此需要加一个未命中的缓存
  if(this->SDBP){//模拟L3 cache有sampler
      uint32_t setID=getId(addr);
      uint32_t tag=getTag(addr);
      if ((setID%2==0)){//访问到sampler之中的set
        this->s->access(setID/2,tag,memory->pc);//update,setID是要除以32，tag也要变成partial tag，PC变成partial PC
      }
  }
  if (this->writeAllocate) {//写分配，因此需要读到cache之中
    this->loadBlockFromLowerLevel(addr, cycles);//读到cache之中

    if ((blockId = this->getBlockId(addr)) != -1) {
      uint32_t offset = this->getOffset(addr);
      this->blocks[blockId].modified = true;
      this->blocks[blockId].lastReference = this->referenceCounter;
      this->blocks[blockId].data[offset] = val;
      if(this->SDBP)
        this->blocks[blockId].trace=make_trace(this->memory->pc);
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
    b.trace=0;
  }
}

void Cache::loadBlockFromLowerLevel(uint32_t addr, uint32_t *cycles) {//load,LLC应该加一个
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
  if(this->SDBP)
    this->blocks[replaceId].trace=make_trace(this->memory->pc);
}

uint32_t Cache::getReplacementBlockId(uint32_t begin, uint32_t end) {
  // Find invalid block first
  for (uint32_t i = begin; i < end; ++i) {
    if (!this->blocks[i].valid)
      return i;
  }
  if(this->SDBP){
    for (uint32_t i = begin; i < end; ++i) {
      if (this->s->pred->getPrediction(this->blocks[i].trace)){
        printf("DEAD FOUND  ");
        return i;
      }
    }
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



//##################################################################//
uint32_t mix (uint32_t a, uint32_t b, uint32_t c) {
    a=a-b; a=a-c; a=a^(c >> 13);
    b=b-c; b=b-a; b=b^(a >> 8);
    c=b-a; c=c-b; c=c^(b >> 13);
    return c;
};

unsigned int f1 (uint32_t x) {
    return mix (0xfeedface, 0xdeadb10c, x);
};

unsigned int f2 (uint32_t x) {
    return mix (0xc001d00d, 0xfade2b1c, x);
};

unsigned int fi (uint32_t x, uint32_t i) {
    return f1(x) + (f2(x) >> i);
};

uint32_t predictor::getTableIndex( uint32_t partialPC, uint32_t tableNum) { //  partialPC 和 table number
    uint32_t x = fi (partialPC, tableNum);
    return x & ((1<<predictorIndexBits)-1);//mapping 到table上
}

void predictor::updateTable ( uint32_t partialPC, bool dead) {
    for (int i=0; i<predictorTableNum; i++) {//每一个table对应的表项都要加一或者减一
        int *c = &tables[i][getTableIndex(partialPC, i)]; // address of corres. entry in table
        if(dead) {//反向学习
            if(*c < counter_max) (*c)++;
        } else { // 正向学习
          if(i&1) (*c)>>=1;
          else
          if (*c > 0) (*c)--; 
        }
    }
}

bool predictor::getPrediction (uint32_t partialPC) {//从三个table之中qu
    int confidence = 0;
    for (int i=0; i<predictorTableNum; i++) {
      int val = tables[i][getTableIndex(partialPC, i)];
      confidence += val;
    }
    return confidence >= threshold;
}

uint32_t make_trace ( uint64_t PC) {
    return PC & ((1<<samplerPartialPCBits)-1);
};

samplerSet::samplerSet (void) {
    blocks = new samplerEntry[samplerAssociavity];
    // initialize LRU replacement algorithm
    for (uint32_t i=0; i<samplerAssociavity; i++) blocks[i].lru = i; // 0 means latest used
}

sampler::sampler() {
    pred = new predictor(); // make a new predictor
    sets = new samplerSet[4096];//32
}

void sampler::access(uint32_t set, uint32_t tag, uint32_t PC) {//访问set
    samplerEntry *blocks = &sets[set].blocks[0]; // set的第一个block
    uint32_t partialTag = tag & ((1<<samplerPartialTagBits)-1); // low-order15位的partial tag
    int i; // 对应位置上的block是我们要找的活着要替换的
    // search for matching tag
   
    for(i=0; i<samplerAssociavity; i++) {
        if(blocks[i].valid && (blocks[i].partialTag == partialTag)) {
            // we know this block is not dead; inform the predictor
            pred->updateTable( blocks[i].partialPC, false);//在predictor table之中声明这个不是dead block
        }
    }

    // 找不到的话就会有一个块dead，那么i就是要替换的block
    if(i == samplerAssociavity) {
        // 先从non-valid里面找一个
        for (i=0; i<samplerAssociavity; i++) if(blocks[i].valid == false) break;
        // 再从prediction dead里面找一个
        if(i==samplerAssociavity) {
            for(i=0; i<samplerAssociavity; i++) 
              if(blocks[i].predictonDead){
                break;
              } //prediction表示这个块被预测位dead块
        }
        // 最后LRU找一个
        if(i == samplerAssociavity) {
            int j;
            for(j=0; j<samplerAssociavity; j++) {
                if(blocks[j].lru == (uint32_t) (samplerAssociavity - 1)) break;
            }
            assert(j < samplerAssociavity);
            i = j;
        }

        // 告诉predictor，这个partial PC对应的block 可能是dead的
        pred->updateTable( blocks[i].partialPC, true);//通知predictor table这个块是dead block
        // 新的block替进来
        blocks[i].partialTag = partialTag;
        blocks[i].valid = true;
    }
    // 新的block替进来
    blocks[i].partialPC = make_trace( PC);//trace就是partial PC
    // 更新block对应的predictor table，无论击中或者没有击中
    blocks[i].predictonDead = pred->getPrediction( blocks[i].partialTag);//更新这个block的prediction
    // 修改LRU
    uint32_t position = blocks[i].lru;
    for(uint32_t way=0; way<samplerAssociavity; way++) {
        if(blocks[way].lru < position) blocks[way].lru++;
    }
    blocks[i].lru = 0;
    //sampler的替换起始没有替，只有换。是将sampler cache set里的block直接换出去，将新的换进来
}

predictor::predictor(void) {
    tables = new int* [predictorTableNum]; // 为了减少hash冲突，我们有三个predictor table
    for(uint32_t i=0; i<predictorTableNum; i++) {// 初始化每一个predictor table里的每一项
        tables[i] = new int[predictorTableEntryNum];
        memset(tables[i], 0, sizeof(int)*predictorTableEntryNum);
    }
}
