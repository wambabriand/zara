#ifndef MYLIB_H
#define MYLIB_H

#include <stdint.h>

extern uint8_t _bstart , _bend ;
extern uint8_t _bdata , _edata , _lma_data ;
extern uint8_t _btext , _etext , _lma_text ;
extern uint8_t _bvector , _evector , _lma_vector ;

void point2();
void point1();
void  boot();
void  init_bss();
void  recopie(uint8_t* src, uint8_t* dst, uint8_t* end) ;
int main() ;

#endif

// __attribute__ ((section (".bootloader")))
