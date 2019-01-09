#include "mylib.h"
#include "led.h"
#include "uart.h"
#include "clocks.h"
#include "uart_irq_led.h"
#include "irq.h"

int main()
{

    clocks_init();

    led_init();
    irq_init();
    uart_init(38400);

    button_init();

    affiche_trame();

    while(1);

    return 0;
}
