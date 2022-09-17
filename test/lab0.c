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
  long scBit=211;
  long normal=1;
  long memLoaded=100;
  long *temp=&scBit;
  asm volatile(
        "retry:"
      );
  asm volatile (
      "lr.d %[mem], (%[target]);"
      :[mem]"=&r"(memLoaded)
      :[target]"r"(dest)
      );
  if (*(long int *)memLoaded!=old_value){
    ret=0;
    return ret;
  }else{
    asm volatile (
        "sc.d a5, %[new], (%[destination]);"//关键是nop
        "nop;"
        "nop;"
        "nop;"
        "nop;"
        "nop;"
        "nop;"
        "beq a5, zero, final;"
        "j retry"
        :
        :[new]"r"(new_value),[destination]"r"(dest)
        :"a5"
      );
    asm volatile(
      "final:"
    );
    ret=1;
    return ret;
  }
}

static long dst;

int main() {
  int res;

  dst = 1;

  for (int i = 0; i < 3; ++i) {
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