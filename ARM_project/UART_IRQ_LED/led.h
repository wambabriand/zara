#ifndef LED_H
#define LED_H



void led_init(void) ;
void led_g_on(void) ;
void led_g_off(void) ;

enum state { LED_OFF , LED_YELLOW , LED_BLUE  } ;

void led( enum state my_state );
#endif
