#ifndef SDBP_H
#define SDBP_H
#include<cstdlib>
#include<stdint.h>
#endif


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
    bool getPrediction(uint32_t partialPC, uint32_t set);//访问到了不在sampler之中的set的时候，返回预测的结果
};

struct sampler {
    samplerSet *sets;
    int nsamplerSets, samplerModulus;
    predictor *pred;
    sampler ();
    void access (int set, int tag, int PC);
};



unsigned int make_trace ( predictor *pred, int PC);

/*


class SamplerEntry
{
private:
    uint32_t lru, partialTag, partialPC, predictonDead;
    bool valid;
public:
     SamplerEntry(void){
        lru=0;
        partialTag=0;
        partialPC=0;
        valid=false;
        predictonDead=0;
    };
    ~SamplerEntry();
};

class SamplerSet
{
private:
    SamplerEntry *blocks;
public:
    SamplerSet();
    ~SamplerSet();
};


class Predictor
{
private:
    int **tables;
public:
    Predictor(void);
    ~Predictor();
};

uint32_t Predictor:: getTableIndex(uint32_t partialPC, uint32_t tableNum);//根据PC，先将其通过hash映射到table长度。再在对应的tableNum之中找到映射后对应的index
void Predictor::(uint32_t partialPC, bool dead);////根据sampler命中与否，更新table    
bool Predictor::(uint32_t partialPC, uint32_t set);//访问到了不在sampler之中的set的时候，返回预测的结果

    
class Sampler
{
private:
    samplerSet *sets;
    int nsamplerSets, samplerModulus;
    predictor *pred;
public:
    Sampler(int nsets, int assoc);
    void access (int set, int tag, int PC);
    ~sampler();
};
*/