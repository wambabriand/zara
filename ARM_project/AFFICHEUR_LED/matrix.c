#include "matrix.h"
#include "mylib.h"
#include "stm32l4xx.h"
#include "clocks.h"


typedef struct {
  uint8_t r;
  uint8_t g;
  uint8_t b;
} rgb_color;


void SB(int x){   //PC5
  if(x==0){
      SET_BIT(GPIOC->BSRR ,GPIO_BSRR_BR5);
  }
  else{
      SET_BIT(GPIOC->BSRR ,GPIO_BSRR_BS5);
  }
}

void LAT(int x){    // PC4
  if(x==0){
      SET_BIT(GPIOC->BSRR ,GPIO_BSRR_BR4);
  }
  else{
      SET_BIT(GPIOC->BSRR ,GPIO_BSRR_BS4);
  }
}

static void RST(int x){ // PC3
  if(x==0){
      SET_BIT(GPIOC->BSRR ,GPIO_BSRR_BR3);
  }
  else{
      SET_BIT(GPIOC->BSRR ,GPIO_BSRR_BS3);
  }
}

void SCK(int x){    // PB1
  if(x==0){
      SET_BIT(GPIOB->BSRR ,GPIO_BSRR_BR1);
  }
  else{
      SET_BIT(GPIOB->BSRR ,GPIO_BSRR_BS1);
  }
}

void SDA(int x){    // PA4
  if(x==0){
      SET_BIT(GPIOA->BSRR ,GPIO_BSRR_BR4);
  }
  else{
      SET_BIT(GPIOA->BSRR ,GPIO_BSRR_BS4);
  }
}

void ROW0(int x){    //PB2
  if(x==0){
      SET_BIT(GPIOB->BSRR ,GPIO_BSRR_BR2);
  }
  else{
      SET_BIT(GPIOB->BSRR ,GPIO_BSRR_BS2);
  }
}
void ROW1(int x){    //PA15
  if(x==0){
      SET_BIT(GPIOA->BSRR ,GPIO_BSRR_BR15);
  }
  else{
      SET_BIT(GPIOA->BSRR ,GPIO_BSRR_BS15);
  }
}
void ROW2(int x){     //PA2
  if(x==0){
      SET_BIT(GPIOA->BSRR ,GPIO_BSRR_BR2);
  }
  else{
      SET_BIT(GPIOA->BSRR ,GPIO_BSRR_BS2);
  }
}
void ROW3(int x){       //PA7
  if(x==0){
      SET_BIT(GPIOA->BSRR ,GPIO_BSRR_BR7);
  }
  else{
      SET_BIT(GPIOA->BSRR ,GPIO_BSRR_BS7);
  }
}
void ROW4(int x){        //PA6
  if(x==0){
      SET_BIT(GPIOA->BSRR ,GPIO_BSRR_BR6);
  }
  else{
      SET_BIT(GPIOA->BSRR ,GPIO_BSRR_BS6);
  }
}
void ROW5(int x){         //PA5
  if(x==0){
      SET_BIT(GPIOA->BSRR ,GPIO_BSRR_BR5);
  }
  else{
      SET_BIT(GPIOA->BSRR ,GPIO_BSRR_BS5);
  }
}
void ROW6(int x){         //PB0
  if(x==0){
      SET_BIT(GPIOB->BSRR ,GPIO_BSRR_BR0);
  }
  else{
      SET_BIT(GPIOB->BSRR ,GPIO_BSRR_BS0);
  }
}
void ROW7(int x){         //PA3
  if(x==0){
      SET_BIT(GPIOA->BSRR ,GPIO_BSRR_BR3);
  }
  else{
      SET_BIT(GPIOA->BSRR ,GPIO_BSRR_BS3);
  }
}



void pulse_SCK(){
  SCK(0);   wait(3);   SCK(1);   wait(3);  SCK(0);   wait(3);//  SCK(1);   wait(20) ;
}

void pulse_LAT(){
  LAT(1);   wait(3);   LAT(0);   wait(3);  LAT(1);   wait(3); //  LAT(0);  wait(20);
}

void deactivate_rows(){
  ROW0(0);  ROW1(0); ROW2(0); ROW3(0); ROW4(0); ROW5(0); ROW6(0); ROW7(0);
}

void activate_row(int row){

  switch( row ){
  case 0 : ROW0(1) ; break ;
  case 1 : ROW1(1) ; break ;
  case 2 : ROW2(1) ; break ;
  case 3 : ROW3(1) ; break ;
  case 4 : ROW4(1) ; break ;
  case 5 : ROW5(1) ; break ;
  case 6 : ROW6(1) ; break ;
  case 7 : ROW7(1) ; break ;
  default : break  ;
  }

}

void send_byte(uint8_t val, int bank){

  int i=0;

  // Positionnement du numéro de bank
  SB(bank);

  // Envoi des octets, poids fort en premier
  for( i=0 ; i<8 ;i++) {
    SDA(val & (1 << (7-i) ));
    pulse_SCK();
  }

}





void mat_set_row(int row, const rgb_color *val){

  int i=7;
  for(i=7 ; i >= 0 ; i--){
    send_byte( val[i].b ,1 );
    send_byte( val[i].g ,1 );
    send_byte( val[i].r ,1 );
  }
  activate_row( row );
  pulse_LAT();

}


void init_bank0(){
  int i=0;

  for(i=0; i < 18 ; i++ ){
    send_byte(255,0);
  }
  pulse_LAT();
}


void test_image_static(){

  rgb_color v[8][8];
  uint8_t i=0 ,j=0 , *p = &_binary_image_raw_start , *e= &_binary_image_raw_end ;

  // cette condition d'arret avec desactive_row() m'ont permis de faire un debug

  for(i= 0 ; ( e != p ) && i < 8 ; i ++){

    for( j = 0 ; j < 8 ; j++){
      v[i][j].r = *p;   p++;
      v[i][j].g = *p;   p++;
      v[i][j].b = *p;   p++;
    }

  }

    while(1)
    {
      for( i=0;i<8;i++){
        deactivate_rows();
        mat_set_row(i,v[i]);
        wait(9000);
      }
    }

  return ;
}


void test_pixels(){

      rgb_color v[8];
      uint8_t i=1;

      for( i=0 ; i< 8 ; i++ ){
	       v[i].r=122;	v[i].b=255;	v[i].g=88;
      }

      while( 1 ){
	       i = i % 8 ;
	       deactivate_rows();
      	 mat_set_row(i,v);
	       wait(50000);
	       i++;
      }

      return ;
}


void matrix_init(){

  // mettre en marche les orloges abc    p:251 rcc_ahb2enr

  SET_BIT(RCC->AHB2ENR , RCC_AHB2ENR_GPIOAEN);
  SET_BIT(RCC->AHB2ENR , RCC_AHB2ENR_GPIOBEN);
  SET_BIT(RCC->AHB2ENR , RCC_AHB2ENR_GPIOCEN);

  // configuration des pin relié au driver en output
  // a ( 2  3  4  5  6  7  15)
  MODIFY_REG(GPIOA->MODER, GPIO_MODER_MODE2_Msk , GPIO_MODER_MODE2_0 );
  MODIFY_REG(GPIOA->MODER, GPIO_MODER_MODE3_Msk , GPIO_MODER_MODE3_0 );
  MODIFY_REG(GPIOA->MODER, GPIO_MODER_MODE4_Msk , GPIO_MODER_MODE4_0 );
  MODIFY_REG(GPIOA->MODER, GPIO_MODER_MODE5_Msk , GPIO_MODER_MODE5_0 );
  MODIFY_REG(GPIOA->MODER, GPIO_MODER_MODE6_Msk , GPIO_MODER_MODE6_0 );
  MODIFY_REG(GPIOA->MODER, GPIO_MODER_MODE7_Msk , GPIO_MODER_MODE7_0 );
  MODIFY_REG(GPIOA->MODER, GPIO_MODER_MODE15_Msk , GPIO_MODER_MODE15_0 );
  // b ( 0  1  2  )
  MODIFY_REG(GPIOB->MODER, GPIO_MODER_MODE0_Msk , GPIO_MODER_MODE0_0 );
  MODIFY_REG(GPIOB->MODER, GPIO_MODER_MODE1_Msk , GPIO_MODER_MODE1_0 );
  MODIFY_REG(GPIOB->MODER, GPIO_MODER_MODE2_Msk , GPIO_MODER_MODE2_0 );
  // c ( 3  4  5 )
  MODIFY_REG(GPIOC->MODER, GPIO_MODER_MODE3_Msk , GPIO_MODER_MODE3_0 );
  MODIFY_REG(GPIOC->MODER, GPIO_MODER_MODE4_Msk , GPIO_MODER_MODE4_0 );
  MODIFY_REG(GPIOC->MODER, GPIO_MODER_MODE5_Msk , GPIO_MODER_MODE5_0 );
  // rest   lat    sb    sck    sda
  RST(0);     LAT(1);      SB(1);        SCK(0);     SDA(0);
  // c0 - c7 = 0
  ROW0(0);    ROW1(0);     ROW2(0);      ROW3(0);
  ROW4(0);    ROW5(0);     ROW6(0);      ROW7(0);

  wait(5000000);

  RST(1);

  wait(20000);

  init_bank0();


  return ;
}
