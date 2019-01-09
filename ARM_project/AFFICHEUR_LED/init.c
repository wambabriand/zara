#include "mylib.h" 


void init_bss(){

  uint8_t *dst = 0; // ou NULL

  for( dst = &_bstart ; dst < &_bend ; dst++  ){
    *dst = 0 ;
  }
  
  return ;
}

/* Cette fonction Inititalise tout ce qu il faut avant d'appeller le main
 probablement elle serà completé dans le futur */

int _init(){

  init_bss();
  
  return main() ;
}

