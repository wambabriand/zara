OBJS = test.o led.o crt0.o init.o
CFLAGS = -g -O1
CC = arm-none-eabi-gcc
LDFLAGS = -nostdlib
TARGET_ARCH =  -mcpu=cortex-m4 -mthumb
LDLIBS = -T ld_ram.lds
EXE = test

$(EXE): $(OBJS)
	$(LINK.o)  $(LDLIBS)  $^ -o $@


%.o : %.c %.h

%.o : %.s
	 arm-none-eabi-as -g -mcpu=cortex-m4 -mthumb $^ -o $@


.PHONY : jlink

jlink:
	 JLinkGDBServer -device STM32L475VG -endian little -if SWD -speed auto -ir -LocalhostOnly



.PHONY : clean

clean :
	rm -f *.o test
