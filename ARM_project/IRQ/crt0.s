    .syntax unified
    .global _start

_start:
	ldr sp , =_stack
	bl _init
_end:
	b _end
