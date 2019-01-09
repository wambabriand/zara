#include "mylib.h"
#include "led.h"
#include "clocks.h"
#include "irq.h"


int main()
{

    clocks_init();

    led_init();

    irq_init( ) ;

    button_init();

    while(1);

    return 0;
}
