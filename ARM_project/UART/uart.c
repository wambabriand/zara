#include "uart.h"
#include "stm32l4xx.h"


void delay(){
  int i =100000;
  while(i>0){
    asm volatile ("nop");
    i--;
  }
}



void uart_init()
{
    // Enabling the GPIOB clock
  
    CLEAR_BIT( USART1->CR1 , USART_CR1_UE_Pos);
    SET_BIT(RCC->AHB2ENR, RCC_AHB2ENR_GPIOBEN_Msk);
    
     MODIFY_REG(GPIOB->MODER , GPIO_MODER_MODE7_Msk , GPIO_MODER_MODE7_1);
     MODIFY_REG(GPIOB->MODER , GPIO_MODER_MODE6_Msk , GPIO_MODER_MODE6_1);//prk ---
    
    // set the pins in AF7 mode:
     MODIFY_REG(GPIOB->AFR[0], GPIO_AFRL_AFSEL6_Msk, 7<< GPIO_AFRL_AFSEL6_Pos);
     MODIFY_REG(GPIOB->AFR[0], GPIO_AFRL_AFSEL7_Msk, 7<< GPIO_AFRL_AFSEL7_Pos);
   
    // enable the clock of USART1  # p et h rcc-> = 0;
     SET_BIT(RCC->APB2ENR, RCC_APB2ENR_USART1EN_Msk);
    
    // USART1 uses PCLK
     CLEAR_BIT(RCC->CCIPR, RCC_CCIPR_USART1SEL_Pos);
       
    // reset USART1
    // je pense qu il plutot faire un reset -> urst1rest=1 ??
    CLEAR_BIT( RCC->APB2RSTR,RCC_APB2RSTR_USART1RST_Pos);
    //  SET_BIT( RCC->APB2RSTR,RCC_APB2RSTR_USART1RST_Msk); 

    
    // serial baudrate
    USART1->BRR = 694; 

   
    //  8N stop 
     CLEAR_BIT(USART1->CR1  , USART_CR1_OVER8_Pos );
     MODIFY_REG(USART1->CR2 , USART_CR2_STOP_Msk , 0<<USART_CR2_STOP_Pos );
     CLEAR_BIT(USART1->CR1 , USART_CR1_M1_Pos);
     CLEAR_BIT(USART1->CR3 , USART_CR3_DMAT_Pos);
      
    // activation de  TE RE USART1    
    SET_BIT(USART1->CR1, USART_CR1_TE_Msk);
    SET_BIT(USART1->CR1, USART_CR1_RE_Msk);
    SET_BIT(USART1->CR1, USART_CR1_UE_Msk);
     
}


void uart_putchar(uint8_t c)
{
         delay();

	// tant que txe!=1
	while( READ_BIT( USART1->ISR ,USART_ISR_TXE) == 0 );
	
	USART1->TDR = c;

	// tant que  Tc!=1
	while( READ_BIT(USART1->ISR , USART_ISR_TC) == 0 );
}

void uart_puts(const uint8_t *s)
{
    while(*s)
    {
      uart_putchar(*s); //p1355
        s++;
    }
    uart_putchar('\n');
    uart_putchar('\r');
}



uint8_t uart_getchar(){
       
  // if farming ou overdum USART_ISR_ORE
  if( READ_BIT(USART1->ISR , USART_ISR_ORE) == 1 )
      while (1) uart_puts("overdung");

  if( READ_BIT(USART1->ISR , USART_ISR_FE) == 1 )
        while (1) uart_puts("framing");
   
  // tant que rxne == 0
  while( READ_BIT(USART1->ISR , USART_ISR_RXNE) == 0 );

  return (uint8_t) READ_REG(USART1->RDR);	
}



void uart_gets(uint8_t *s, size_t size){

     uint8_t *tmp = s ;
     size_t i = 0 ;

     for(i=0 ; i < size ; i++){
       *tmp = uart_getchar();
       tmp++;
     }
}

void checksum_test(uint8_t dim){
  
  uint8_t str[102];

  uart_puts("Nous sommes dans checksum");
	
  while(1){
	uart_gets(str,dim);
	uart_puts(str);
  }
  // quand la somme est exact je stampe  
}
