
MEMORY {

       flash(rx) : ORIGIN = 0x00000000, LENGTH = 1M
       sram1(!rx) : ORIGIN = 0x20000000, LENGTH = 96K
       sram2(!rx) : ORIGIN = 0x10000000, LENGTH = 32K
}

_stack = ORIGIN(sram2) + LENGTH(sram2);

_lma_data =  LOADADDR (.data);
_lma_text =  LOADADDR (.text);
_lma_vector = LOADADDR (.vector);


SECTIONS {

  .vector : {
    _bvector = . ;
      *(.vector)
    _evector = . ;
  } > sram1 AT > flash

  .bootloader : {
    init.o(.text)
    crt0.o(.text)
  } > flash

   .text : {
        _btext = . ;
	       *(.text*)
        _etext = . ;
	 } > sram1 AT > flash

	 .rodata :  {
     _brodata = . ;
	 	 *(.rodata*)
     _erodata = . ;
	 } > flash

	 .data : {
        _bdata = . ;
	       *(.data*)
        _edata = . ;
	 } > sram1 AT > flash

	 .bss : {
	       _bstart = . ;
 	       *(.bss*) *(*COM*)
	       _bend = . ;
	 } > sram1
}

ENTRY (_start)
