OBJS = test.o crt0.o led.o  init.o  irq.o buttons.o uart.o uart_irq_led.o matrix.o
CFLAGS = -g -O1
AS = arm-none-eabi-as
CC = arm-none-eabi-gcc
LDFLAGS = -nostdlib
TARGET_ARCH =  -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16
LDLIBS = -T ld_ram.lds
EXE = test
CPPFLAGS  = -I CMSIS/Device/ST/STM32L4xx/Include  -I CMSIS/Include
CPPFLAGS += -DSTM32L475xx


$(EXE): $(OBJS) clocks.o image.o
	$(LINK.o)  $(LDLIBS)  $^ -o $@


%.o : %.s
	arm-none-eabi-as -g ${TARGET_ARCH}  $^ -o $@


image.o: image.raw
	arm-none-eabi-objcopy -I binary -O elf32-littlearm -B arm $^ $@


.PHONY : jlink  clean  run


jlink:
	 JLinkGDBServer -device STM32L475VG -endian little -if SWD -speed auto -ir -LocalhostOnly


clean :
	rm -f ${OBJS} test
	rm -f *~
	rm -f *#

run :
	arm-none-eabi-gdb test


image.o :
	arm-none-eabi-objcopy -I binary -O elf32-littlearm -B arm image.raw image.o
