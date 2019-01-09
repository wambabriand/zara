#include "led.h"

enum boolean { YES , NO } ;

// pour les adresses je lis le BASE ADRESS dans le datasheet
// et le manuele de ref l'offset precise du registre que je veux
// exemple : pour le RCC_AHB2ENR ( RCC dans datasheet p:81) et (l offset dans ref p:351 )


#define RCC_AHB2ENR (*(volatile uint32_t *) 0x4002104C )

#define GPIOB_MODER (*(volatile uint32_t *) 0x48000400 )
#define GPIOB_BSRR  (*(volatile uint32_t *) 0x48000418 )

#define GPIOC_MODER (*(volatile uint32_t *) 0x48000800 )
#define GPIOC_BSRR  (*(volatile uint32_t *) 0x48000818 )

static enum boolean on = NO;

// je crèe cette fonction pour éviter la duplication du code

void set (int p ){

 switch( on ){
 case YES :
     GPIOC_BSRR |=  ( 0x1 << p );
 break ;

 default :
    RCC_AHB2ENR |=    0x1 << 2 ;
    GPIOC_BSRR  |=  ( 0x1 << p );
    GPIOC_MODER  =  ( GPIOC_MODER & ~ 0x1 << 19 ) | ( 0x1 << 18 ) ;
    on = YES ;
 break ;
 }
  return ;
}


void led( enum state my_state ){

  switch ( my_state ){

  case  LED_OFF :
    GPIOC_MODER  =  GPIOC_MODER | ( (0x1 << 19) | (0x1 << 18) );
    RCC_AHB2ENR &=  ~(0x1 << 2)  ;
    on = NO ;
    break ;

  case LED_YELLOW:
    set(9);
    break ;

  case LED_BLUE :
    set(25);
    break ;
  }

  return ;
}


void led_init(void) {
  // J ACTIVE L ORLOGE DU GIOP  B : ref(page 351)
  RCC_AHB2ENR |= 0x1 << 1 ;

  // je le met en mode sortie le GIOP B :  ref(page 303)
  GPIOB_MODER  =  ( GPIOB_MODER & ~ 0x1 << 29 ) | ( 0x1 << 28 ) ;

  return ;
}


void led_g_on(void){
  GPIOB_BSRR |= (0x1<<14) ;    // ref page 306
}

void led_g_off(void) {
  GPIOB_BSRR |= (0x1<<30) ;
}

void wait(uint32_t time){
       while( time > 0 ){
	 time--;
	 asm volatile ("nop");
       }
}
