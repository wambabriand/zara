#ifndef MATRIX_H
#define MATRIX_H

#include <stdint.h>

#include "led.h"

void matrix_init();
void pulse_SCK();
void pulse_LAT();
void deactivate_rows() ;
void activate_row(int );
void test_pixels();
void test_image_static() ;

extern uint8_t _binary_image_raw_start ;
extern uint8_t _binary_image_raw_size ;
extern uint8_t _binary_image_raw_end ;


#endif
