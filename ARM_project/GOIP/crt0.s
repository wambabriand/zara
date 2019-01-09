    .syntax unified
    .global _start

_start:
	ldr sp , =0x10008000
	bl _init
_end:
	b _end
	
