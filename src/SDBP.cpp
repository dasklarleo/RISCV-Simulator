#include <stdlib.h>
#include <math.h>
#include <cstring>
#include "SDBP.h"
#include <assert.h>
uint32_t samplerPartialTagBits = 16;
uint32_t predictorTableNum = 3;
uint32_t predictorIndexBits = 12;
uint32_t samplerAssociavity = 12;
uint32_t samplerPartialPCBits = 16;
uint32_t predictorTableEntryNum = 1 << predictorIndexBits;//4096
uint32_t counterWidth = 2;
uint32_t counter_max = (1 << counterWidth) - 1;
uint32_t threshold = 8;//dead standard

samplerSet::samplerSet (void) {
    blocks = new samplerEntry[samplerAssociavity];
    // initialize LRU replacement algorithm
    for (uint32_t i=0; i<samplerAssociavity; i++) blocks[i].lru = i; // 0 means latest used
}

sampler::sampler(int nsets, int associativaty) {
    pred = new predictor(); // make a new predictor
    sets = new samplerSet[32];//32
}

void sampler::access(int set, int tag, int PC) {//访问set
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
        //先从non-valid里面找一个
        for (i=0; i<samplerAssociavity; i++) if(blocks[i].valid == false) break;
        // 再从prediction dead里面找一个
        if(i==samplerAssociavity) {
            
            for(i=0; i<samplerAssociavity; i++) if(blocks[i].predictonDead) break;//prediction表示这个块被预测位dead块
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
    blocks[i].partialPC = make_trace( pred, PC);//trace就是partial PC
    // 更新block对应的predictor table，无论击中或者没有击中
    blocks[i].predictonDead = pred->getPrediction( blocks[i].partialTag, -1);//更新这个block的prediction
    // 修改LRU
    uint32_t position = blocks[i].lru;
    for(int way=0; way<samplerAssociavity; way++) {
        if(blocks[way].lru < position) blocks[way].lru++;
    }
    blocks[i].lru = 0;
    //sampler的替换起始没有替，只有换。是将sampler cache set里的block直接换出去，将新的换进来
}

predictor::predictor(void) {
    tables = new int* [predictorTableNum]; // 为了减少hash冲突，我们有三个predictor table
    for(int i=0; i<predictorTableNum; i++) {// 初始化每一个predictor table里的每一项
        tables[i] = new int[predictorTableEntryNum];
        memset(tables[i], 0, sizeof(int)*predictorTableEntryNum);
    }
}

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
            if (*c > 0) (*c)--; 
        }
    }
}

bool predictor::getPrediction (uint32_t partialPC, uint32_t set) {//从三个table之中qu
    int confidence = 0;
    for (int i=0; i<predictorTableNum; i++) {
        int val = tables[i][getTableIndex(partialPC, i)];
        confidence += val;
    }
    return confidence >= threshold;
}

uint32_t mix (uint32_t a, uint32_t b, uint32_t c) {
    a=a-b; a=a-c; a=a^(c >> 13);
    b=b-c; b=b-a; b=b^(a >> 8);
    c=b-a; c=c-b; c=c^(b >> 13);
    return c;
};

uint32_t f1 (uint32_t x) {
    return mix (0xfeedface, 0xdeadb10c, x);
};

uint32_t f2 (uint32_t x) {
    return mix (0xc001d00d, 0xfade2b1c, x);
};

uint32_t fi (uint32_t x, int i) {
    return f1(x) + (f2(x) >> i);
};

uint32_t make_trace (predictor *pred, int PC) {
    return PC & ((1<<samplerPartialPCBits)-1);
};