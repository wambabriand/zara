    .syntax unified
    .global _start
    .global _main
    .thumb_func


_start:

	ldr sp , =_stack
  bl boot
  bl main
_end:
	b _end
