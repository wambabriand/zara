#ifndef MATRIX_H
#define MATRIX_H

#include <stdint.h>

#include "led.h"

typedef struct {
  uint8_t r;
  uint8_t g;
  uint8_t b;
} rgb_color;



void matrix_init();
void pulse_SCK();
void pulse_LAT();
void deactivate_rows() ;
void activate_row(int );
void test_pixels();
void test_image_static() ;

void mat_set_row(int row, const rgb_color *val);


extern uint8_t _binary_image_raw_start ;
extern uint8_t _binary_image_raw_size ;
extern uint8_t _binary_image_raw_end ;


#endif
