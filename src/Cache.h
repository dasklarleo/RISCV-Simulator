/*
 * Basic cache simulator
 *
 * Created by He, Hao on 2019-4-27
 */

#ifndef CACHE_H
#define CACHE_H


# define  samplerPartialTagBits  16
# define  samplerPartialPCBits 16
# define  predictorTableNum 3
# define  predictorIndexBits  18
# define  samplerAssociavity  4

# define  predictorTableEntryNum  1 << predictorIndexBits
# define  counterWidth  2
# define  counter_max  (1 << counterWidth) - 1
# define  threshold  8

#include <cstdint>
#include <vector>
#include <assert.h>
#include "MemoryManager.h"


struct samplerEntry
{
    uint32_t lru, partialTag, partialPC, predictonDead;
    bool valid;
    samplerEntry(void){
        lru=0;
        partialTag=0;
        partialPC=0;
        valid=false;
        predictonDead=0;
    };
};

struct samplerSet {
    samplerEntry *blocks;// sampler的set里block起始地址
    samplerSet(void);
};


struct predictor{
    int **tables; //index*2 bits
    predictor(void);
    uint32_t getTableIndex(uint32_t partialPC, uint32_t tableNum);//根据PC，先将其通过hash映射到table长度。再在对应的tableNum之中找到映射后对应的index
    void updateTable(uint32_t partialPC, bool dead);////根据sampler命中与否，更新table
    bool getPrediction(uint32_t partialPC);//访问到了不在sampler之中的set的时候，返回预测的结果
};

struct sampler {
    samplerSet *sets;
    int nsamplerSets, samplerModulus;
    predictor *pred;
    sampler ();
    void access (uint32_t set, uint32_t tag, uint32_t PC);
};

unsigned int mix (uint32_t a, uint32_t b, uint32_t c);
unsigned int f1 (uint32_t x);
unsigned int f2 (uint32_t x);
unsigned int fi (uint32_t x, uint32_t i);
unsigned int make_trace ( uint64_t PC);

class MemoryManager;

class Cache {
public:
  struct Policy {
    // In bytes, must be power of 2
    uint32_t cacheSize;
    uint32_t blockSize;
    uint32_t blockNum;
    uint32_t associativity;
    uint32_t hitLatency;  // in cycles
    uint32_t missLatency; // in cycles
  };

  struct Block {
    bool valid;
    bool modified;
    uint32_t tag;
    uint32_t id;
    uint32_t size;
    uint32_t lastReference;
    std::vector<uint8_t> data;
    uint32_t trace;
    Block() {}
    Block(const Block &b)
        : valid(b.valid), modified(b.modified), tag(b.tag), id(b.id),
          size(b.size) {
      data = b.data;
    }
  };

  struct Statistics {
    uint32_t numRead;
    uint32_t numWrite;
    uint32_t numHit;
    uint32_t numMiss;
    uint64_t totalCycles;
  };

  Cache(MemoryManager *manager, Policy policy,bool exclusion, Cache *lowerCache = nullptr,bool writeBack = true, bool writeAllocate = true,sampler *s=nullptr,bool SDBP=false);

  bool inCache(uint32_t addr);
  uint32_t getBlockId(uint32_t addr);
  uint8_t getByte(uint32_t addr, uint32_t *cycles = nullptr);
  void setByte(uint32_t addr, uint8_t val, uint32_t *cycles = nullptr);
  uint32_t getIdForSampler(uint32_t addr);
  uint32_t getTagForSampler(uint32_t addr);
  void printInfo(bool verbose);
  void printStatistics();

  Statistics statistics;

private:
  uint32_t referenceCounter;
  sampler *s;// default nullptr
  bool writeBack;     // default true
  bool writeAllocate; // default true
  bool exclusion;     //default false
  bool samplerExist;//default false
  bool SDBP;
  MemoryManager *memory;
  Cache *lowerCache;
  Policy policy;
  std::vector<Block> blocks;

  void initCache();
  void loadBlockFromLowerLevel(uint32_t addr, uint32_t *cycles = nullptr);
  uint32_t getReplacementBlockId(uint32_t begin, uint32_t end);
  void writeBlockToLowerLevel(Block &b);

  // Utility Functions
  bool isPolicyValid();
  bool isPowerOfTwo(uint32_t n);
  uint32_t log2i(uint32_t val);
  uint32_t getTag(uint32_t addr);
  uint32_t getId(uint32_t addr);
  uint32_t getOffset(uint32_t addr);
  uint32_t getAddr(Block &b);
};


#endif