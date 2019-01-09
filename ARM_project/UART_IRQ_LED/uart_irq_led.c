#include "uart_irq_led.h"
// CE fichier contient 3 fonctions et 3 variables global

// 1 Définissez un objet global qui contiendra la trame affichée. Il sera modifé par le handler
// 2 Écrivez la tâche de réception du port série (handler d'IRQ) qui traitera les octets reçus.
// 3 Écrivez la tâche d'affichage qui affiche en permanence la trame courante (normalement vous l'avez déjà écrite dans le TP…).



//1 Définissez un objet global qui contiendra la trame affichée. Il sera modifé par le handler
volatile rgb_color frame[64] ;
static int pixel = 0;
static int color = 0;


void active_interrupt_usart1(){
//  /USART1->CR1 |= USART_CR1_RXNEIE;
  SET_BIT (USART1->CR1 , USART_CR1_RXNEIE);
  NVIC_EnableIRQ(USART1_IRQn ) ;
}


// 2 Écrivez la tâche de réception du port série (handler d'IRQ) qui traitera les octets reçus.
void USART1_IRQHandler(){

      uint8_t c = uart_getchar() ;

      if (c != 0xFF && pixel < 64) {
        if (color == 0) {
          frame[pixel].r = c;
          color++;
        }
        else if (color == 1) {
          frame[pixel].g = c;
          color++;
        }
        else {
          frame[pixel].b = c;
          color = 0;
          pixel++;
        }
      }
      else {
          color = 0;
          pixel = 0;
      }

}

// 3 Écrivez la tâche d'affichage qui affiche en permanence la trame courante (normalement vous l'avez déjà écrite dans le TP…).

void affiche_trame(){

int line ;
  while (1) {
        for (line = 0; line < 8; line++) {
          mat_set_row(line,(const rgb_color *) &frame[line*8]) ;
    }
  }
}
