#include <stdint.h>
#include <stddef.h>

uint8_t uart_getchar();
void uart_init(int baudrate);
void uart_putchar(uint8_t c);
void uart_puts(const uint8_t *s);
void uart_gets(uint8_t *s, size_t size);
void checksum_test(uint8_t dim) ;
