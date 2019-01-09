

MEMORY {

       flash(rx) : ORIGIN = 0x00000000, LENGTH = 1M
       sram1(!rx) : ORIGIN = 0x20000000, LENGTH = 96K
       sram2(!rx) : ORIGIN = 0x10000000, LENGTH = 32K
}



SECTIONS {

	 .text : {
	       *(.text*)
	 } > sram1
	 
	 .rodata :  {
	 	 *(.rodata*)
	 } > sram1
	 
	 .data : {
	       *(.data*)
	 } > sram1

	 .bss : {
	       _bstart = . ;
 	       *(.bss*) *(*COM*)
	       _bend = . ;
	 } > sram1
}  

ENTRY (_start)

