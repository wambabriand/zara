#include "mylib.h"
#include "led.h"



int main()
{
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
