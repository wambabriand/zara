
#ifndef MYLIB_H
#define MYLIB_H

#include <stdint.h>

extern uint8_t _bstart , _bend ;

void init_bss();

int main() ;

void wait(uint32_t time);

#endif
