#include "lib.h"
/**
 * Compare and Swap
 * @param dest
 * @param new_value
 * @param old_value
 * @return success `1' or not `0'
 */
int CAS(long* dest, long new_value, long old_value) {
  int ret = 0;
  // TODO: write your code here
  long *temp=dest;
  long memLoaded=100;

  long scBit;
  retry:
  asm volatile (
        "lr.d %[mem], (%[dst]);"
        :[mem]"=r"(memLoaded)
        :[dst]"r"(dest)
      );
  print_d(memLoaded);
  if (memLoaded!=old_value){
    ret=0;
    return ret;
  }else{
    asm volatile (
        "sc.d %[scbit], %[new], (%[dst]);"
        :[scbit]"=r"(scBit)
        :[dst]"r"(dest),[new]"r"(new_value)
        :
      );
    if(scBit!=0){
      goto retry;
    }else{
      ret=1;
      return ret;
    }
  }

  
}

static long dst;

int main() {
  int res;

  dst = 1;

  for (int i = 0; i < 2; ++i) {
    res = CAS(&dst, 211, i);
    if (res)
      print_s("CAS SUCCESS\n");
    else
      print_s("CAS FAIL\n");
    print_d(res);
    print_c('\n');
    print_d(dst);
    print_c('\n');
  }

  exit_proc();
}