OBJS = test.o crt0.o init.o led.o clocks.o uart.o matrix.o
CFLAGS = -g -O1
CC = arm-none-eabi-gcc
LDFLAGS = -nostdlib  
TARGET_ARCH =  -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16
LDLIBS = -T ld_ram.lds
EXE = test
CPPFLAGS  = -I CMSIS/Device/ST/STM32L4xx/Include  -I CMSIS/Include
CPPFLAGS += -DSTM32L475xx 

$(EXE): $(OBJS)
	$(LINK.o)  $(LDLIBS)  $^ -o $@


%.o : %.c %.h

%.o : %.s
	 arm-none-eabi-as -g ${TARGET_ARCH} $^ -o $@


.PHONY : jlink

jlink: 
	 JLinkGDBServer -device STM32L475VG -endian little -if SWD -speed auto -ir -LocalhostOnly



.PHONY : clean  run hello

clean :
	rm -f *.o test

run :
	 arm-none-eabi-gdb test 

hello :
	arm-none-eabi-gdb hello 

