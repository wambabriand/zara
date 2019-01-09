
#include "led.h"
#include <stdint.h>
#include "stm32l4xx.h"

// GESTION DU PORT C
void led( enum state my_state ){

  switch ( my_state ){

 case  LED_OFF :
    MODIFY_REG(GPIOC->MODER , GPIO_MODER_MODE9_Msk , GPIO_MODER_MODE9_Msk );
    CLEAR_BIT(RCC->AHB2ENR , RCC_AHB2ENR_GPIOCEN_Pos);
    break ;

 case LED_YELLOW:
      SET_BIT(RCC->AHB2ENR, RCC_AHB2ENR_GPIOCEN_Msk);
      SET_BIT(GPIOC->BSRR , GPIO_BSRR_BS9_Msk);
      MODIFY_REG(GPIOC->MODER, GPIO_MODER_MODE9_Msk,GPIO_MODER_MODE9_0);
     break ;

 case LED_BLUE :
      SET_BIT(RCC->AHB2ENR, RCC_AHB2ENR_GPIOCEN_Msk);
      SET_BIT(GPIOC->BSRR , GPIO_BSRR_BR9_Msk);
      MODIFY_REG(GPIOC->MODER, GPIO_MODER_MODE9_Msk,GPIO_MODER_MODE9_0);
    break ;
  }

  return ;
}


// GESTION DU PORT GPIOB

void led_init(void) {
  SET_BIT(RCC->AHB2ENR, RCC_AHB2ENR_GPIOBEN_Msk);
  MODIFY_REG(GPIOB->MODER, GPIO_MODER_MODE14_Msk, GPIO_MODER_MODE14_0);
  return ;
}

void led_g_on(void){
  SET_BIT(GPIOB->BSRR , GPIO_BSRR_BS14_Msk);
}

void led_g_off(void) {
  SET_BIT(GPIOB->BSRR , GPIO_BSRR_BR14_Msk);
}

void wait(uint32_t time){
       while( time > 0 ){
	 time--;
	 asm volatile ("nop");
       }
}
