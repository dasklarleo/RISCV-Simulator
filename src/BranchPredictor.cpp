/*
 * Created by He, Hao on 2019-3-25
 */

#include "BranchPredictor.h"
#include "Debug.h"
#include <iostream>
BranchPredictor::BranchPredictor() {
  for (int i = 0; i < PRED_BUF_SIZE; ++i) {
    this->predbuf[i] = WEAK_TAKEN;
  }
    this->historyRegister[0]=(1);//0 is always 1
    for(int i=0; i<29; i++){
      for(int j=0;j<35;j++){
        this->weightArray[i][j]=1;//weights are initialized with 0
        this->historyRegister[j]=0;
      }
    }
    for(int i=0;i<35;i++)
      this->historyRegister[i]=1;
    this->threshold=79;
}

BranchPredictor::~BranchPredictor() {}

bool BranchPredictor::predict(uint32_t pc, uint32_t insttype, int64_t op1,
                              int64_t op2, int64_t offset) {
  switch (this->strategy) {
  case NT:
    return false;
  case AT:
    return true;
  case BTFNT: {
    if (offset >= 0) {
      return false;
    } else {
      return true;
    }
  }
  break;
  case BPB: {
    PredictorState state = this->predbuf[pc % PRED_BUF_SIZE];
    if (state == STRONG_TAKEN || state == WEAK_TAKEN) {
      return true;
    } else if (state == STRONG_NOT_TAKEN || state == WEAK_NOT_TAKEN) {
      return false;
    } else {
      dbgprintf("Strange Prediction Buffer!\n");
    }   
  }
  break;
  case PERCEPTRON:{
    //TO BE DONE
    //1. calculate the product of weights and the historyRegister this->innerProduct
    int innerProductValue=this->innerProduct(pc);
    //2. give the prediction if(product<0)... if (product>0)...
    if(innerProductValue>0) return true;
    else return false;
  }
  default:
    dbgprintf("Unknown Branch Perdiction Strategy!\n");
    break;
  }
  return false;
}

int32_t BranchPredictor::innerProduct(uint32_t pc){//calculate the inner product
  int innerProductvalue=0;//return value
  uint32_t index=pc%29;
  for(int i=0;i<35;i++){
    innerProductvalue=innerProductvalue+((this->weightArray[index][i])*(this->historyRegister[i]));
  }
  return innerProductvalue;
}

void BranchPredictor::update(uint32_t pc, bool branch,bool predictedBranch) {
  int id = pc % PRED_BUF_SIZE;
  PredictorState state = this->predbuf[id];
  uint32_t index=pc%29;
  int t=0;
  int i=0;
  switch (this->strategy)
  {
  case BPB:
    if (branch) {
      if (state == STRONG_NOT_TAKEN) {
        this->predbuf[id] = WEAK_NOT_TAKEN;
      } else if (state == WEAK_NOT_TAKEN) {
        this->predbuf[id] = WEAK_TAKEN;
      } else if (state == WEAK_TAKEN) {
        this->predbuf[id] = STRONG_TAKEN;
      } // do nothing if STRONG_TAKEN
    } else { // not branch
      if (state == STRONG_TAKEN) {
        this->predbuf[id] = WEAK_TAKEN;
      } else if (state == WEAK_TAKEN) {
        this->predbuf[id] = WEAK_NOT_TAKEN;
      } else if (state == WEAK_NOT_TAKEN) {
        this->predbuf[id] = STRONG_NOT_TAKEN;
      } // do noting if STRONG_NOT_TAKEN
  }
  break;
  case PERCEPTRON:
    //1. acquire the pc index (modify it by the 30)
    if((branch!=predictedBranch)||(innerProduct(pc)>(-this->threshold)&&innerProduct(pc)<(this->threshold))){
    //2. update the weight array wi=wi+xi(branch) wi=wi-xi(not branch)
      if (branch==true){//+
        t=1;
      }else{//-
        t=-1;
      }
      for(i=0;i<35;i++){
        if(this->weightArray[index][i]+t*historyRegister[i]>-128&&this->weightArray[index][i]+t*historyRegister[i]<127)
        this->weightArray[index][i]=this->weightArray[index][i]+t*historyRegister[i];
      }
    }
    //3.update the history register, history bit 0 is always 1
    for (i=34;i>0;i--){
      historyRegister[i]=historyRegister[i-1];//update
    }
    historyRegister[1]=t;
    break;
  default:
    break;
  }
  

}

std::string BranchPredictor::strategyName() {
  switch (this->strategy) {
  case NT:
    return "Always Not Taken";
  case AT:
    return "Always Taken";
  case BTFNT:
    return "Back Taken Forward Not Taken";
  case BPB:
    return "Branch Prediction Buffer";
  case PERCEPTRON:
    return "Dynamic Branch Prediction";
  default:
    dbgprintf("Unknown Branch Perdiction Strategy!\n");
    break;
  }
  return "error"; // should not go here
}