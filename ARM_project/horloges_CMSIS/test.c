#include "mylib.h"
#include "led.h"
#include "clocks.h"



int main()
{
    clocks_init();

    led_init();


    led_g_on();
    wait(1000000);
    led_g_off();
    wait(1000000);
    led_g_on();
    wait(1000000);
    led_g_off();
    wait(1000000);
    led_g_on();
    wait(1000000);
    led_g_off();


while (1) {
    led(LED_BLUE);
    wait(1000000);
    led(LED_BLUE);
    wait(1000000);
    led(LED_OFF);
    wait(1000000);
}

    return 0;
}
