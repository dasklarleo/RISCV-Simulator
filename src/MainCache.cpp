/*
 * The main entry point of single level cache simulator
 * It takes a memory trace as input, and output CSV file containing miss rate
 * under various cache configurations
 *
 * Created by He, Hao at 2019-04-27
 */

#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "Cache.h"
#include "Debug.h"
#include "MemoryManager.h"

bool parseParameters(int argc, char **argv);
void printUsage();
void simulateCache(std::ofstream &csvFile, uint32_t cacheSize,
                   uint32_t blockSize, uint32_t associativity, bool writeBack,
                   bool writeAllocate);

bool verbose = false;
bool isSingleStep = false;
const char *traceFilePath="/home/leosher/tools/RISCV-Simulator/cache-trace/02-stream-gem5-xaa.trace";

int main(int argc, char **argv) {
  if (!parseParameters(argc, argv)) {
    std::cout<<"CACHE SIM"<<std::endl;
    return -1;
  }

  // Open CSV file and write header
  std::ofstream csvFile(std::string(traceFilePath) + ".csv");
  csvFile << "cacheSize,blockSize,associativity,writeBack,writeAllocate,"
             "missRate,totalCycles\n";

  // Cache Size: 32 Kb to 32 Mb
  /*
  for (uint32_t cacheSize = 32 * 1024; cacheSize <= 32 * 1024 * 1024;
       cacheSize *= 2) {
    // Block Size: 1 byte to 4096 byte
    // The maximum block size is imposed by VM page size
    for (uint32_t blockSize = 1; blockSize <= 4096; blockSize *= 2) {
      for (uint32_t associativity = 1; associativity <= 32;
           associativity *= 2) {
        uint32_t blockNum = cacheSize / blockSize;
        if (blockNum % associativity != 0)
          continue;

        simulateCache(csvFile, cacheSize, blockSize, associativity, true, true);
        simulateCache(csvFile, cacheSize, blockSize, associativity, true, false);
        simulateCache(csvFile, cacheSize, blockSize, associativity, false, true);
        simulateCache(csvFile, cacheSize, blockSize, associativity, false, false);
      }
    }
  }
  */
  simulateCache(csvFile, 1024*32 , 64, 8, true, true);
  printf("Result has been written to %s\n",
         (std::string(traceFilePath) + ".csv").c_str());
  csvFile.close();
  return 0;
}

bool parseParameters(int argc, char **argv) {
  // Read Parameters
  for (int i = 1; i < argc; ++i) {
    if (argv[i][0] == '-') {
      switch (argv[i][1]) {
      case 'v':
        verbose = 1;
        break;
      case 's':
        isSingleStep = 1;
        break;
      default:
        return false;
      }
    } else {
      if (traceFilePath == nullptr) {
        traceFilePath = argv[i];
      } else {
        return false;
      }
    }
  }
  if (traceFilePath == nullptr) {
    return false;
  }
  return true;
}

void printUsage() {
  printf("Usage: CacheSim trace-file [-s] [-v]\n");
  printf("Parameters: -s single step, -v verbose output\n");
}

void simulateCache(std::ofstream &csvFile, uint32_t cacheSize,
                   uint32_t blockSize, uint32_t associativity, bool writeBack,
                   bool writeAllocate) {
  blockSize=64;
  associativity=8;
  cacheSize=32*1024;
  Cache::Policy l1policy, l2policy,l3policy;
  l1policy.cacheSize =  1024;
  l1policy.blockSize = 16;
  l1policy.blockNum = 1024 / 16;
  l1policy.associativity = 2;
  l1policy.hitLatency = 2;
  l1policy.missLatency = 8;

  l2policy.cacheSize = 8 * 1024;
  l2policy.blockSize = 16;
  l2policy.blockNum = 8 * 1024 / 16;
  l2policy.associativity = 4;
  l2policy.hitLatency = 8;
  l2policy.missLatency = 100;

  l3policy.cacheSize =32 * 1024;
  l3policy.blockSize = 16;
  l3policy.blockNum = 32 * 1024 / 16;
  l3policy.associativity = 8;
  l3policy.hitLatency = 20;
  l3policy.missLatency = 100;
  sampler s;
  // Initialize memory and cache
  MemoryManager *memory = nullptr;//MemoryManager类的声明，MemoryManager类用于和CPU模拟器交互
  Cache * l1cache = nullptr;
  Cache * l2cache = nullptr;
  Cache * l3cache = nullptr;
  memory = new MemoryManager();
  writeBack=true;
  bool exclusion=true;
  l3cache = new Cache(memory,l3policy,exclusion, nullptr, writeBack, writeAllocate);//顺序反过来就错了
  l2cache = new Cache(memory,l2policy,exclusion, l3cache, writeBack, writeAllocate);
  l1cache = new Cache(memory,l1policy,exclusion, l2cache, writeBack, writeAllocate);
  memory->setCache(l1cache);

  l1cache->printInfo(false);

  // Read and execute trace in cache-trace/ folder
  std::ifstream trace(traceFilePath);
  if (!trace.is_open()) {
    printf("Unable to open file %s\n", traceFilePath);
    exit(-1);
  }

  char type; //'r' for read, 'w' for write
  uint32_t addr;
  //读取的这个文件及论的是地址以及写或者读，如果在主存的话就直接在cache之中操作，否则需要先去memory上加载
  while (trace >> type >> std::hex >> addr) {
    if (verbose)
      printf("%c %x\n", type, addr);
    if (!memory->isPageExist(addr))
      memory->addPage(addr);
    switch (type) {
    case 'r':
      l1cache->getByte(addr);
      break;
    case 'w':
      l1cache->setByte(addr, 0);
      break;
    default:
      dbgprintf("Illegal type %c\n", type);
      exit(-1);
    }

    if (verbose)
      l1cache->printInfo(true);

    if (isSingleStep) {
      printf("Press Enter to Continue...");
      getchar();
    }
  }

  // Output Simulation Results
  l1cache->printStatistics();
  float missRate = (float)l1cache->statistics.numMiss /
                   (l1cache->statistics.numHit + l1cache->statistics.numMiss);
  csvFile << cacheSize << "," << blockSize << "," << associativity << ","
          << writeBack << "," << writeAllocate << "," << missRate << ","
          << l1cache->statistics.totalCycles << std::endl;

  delete l1cache;
  delete l2cache;
  delete l3cache;
  delete memory;
}