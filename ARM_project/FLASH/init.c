#include "mylib.h"



void  boot(){
  init_bss();
  recopie(&_bdata , &_lma_data , &_edata );
  recopie(&_btext , &_lma_text , &_etext );
  recopie(&_bvector , &_lma_vector , &_evector );

  return ;
}


void   recopie(uint8_t* start, uint8_t* src, uint8_t* end) {

	uint8_t * dst;

  for( dst = start  ; dst < end ; src++ , dst++){
    *dst =  *src ;
  }
return ;
}


 void  init_bss(){
  uint8_t *dst = 0;

  for( dst = &_bstart ; dst < &_bend ; dst++  ){
    *dst = 0 ;
  }
  return ;
}
