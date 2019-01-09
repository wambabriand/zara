#include "mylib.h"
#include "led.h"
#include "clocks.h"
#include "uart.h"



int main()
{
    clocks_init();

    uart_init();
    uint8_t i = 3 ;

    uint8_t e[5];
    uint8_t str[]="ecris un message de 5 caractere!" ;

    uart_puts("BEGIN");

    while (i>0 ){
	       uart_puts(str);
	       uart_gets(e,5);
	       uart_puts(e);
	       i--;
    }

     uart_puts("END");

    return 0;
}
