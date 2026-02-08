PROGRAM=barestm32
OBJECTS=main.o startup_stm32f103rb.o
COMPILER=arm-none-eabi-gcc

TARGET_FLAGS=\
		--specs=nosys.specs\
		-mcpu=cortex-m3\
		-mthumb\
		-mlittle-endian\
		-mfpu=fpv4-sp-d16\
		-mfloat-abi=hard\
		-mthumb-interwork\

CFLAGS =\
		-g -Wall -Wextra -Werror\
		$(TARGET_FLAGS)\

LDFLAGS =\
		$(TARGET_FLAGS)\
		-Wl,-T stm32f103rb.ld\
		-nostdlib\

%.o: %.s
	$(COMPILER) $(CFLAGS) -c -o $@ $<

%.o: %.c
	$(COMPILER) $(CFLAGS) -c -o $@ $<



$(PROGRAM): $(OBJECTS)
	 $(COMPILER) $(LDFLAGS) -o $@ $(OBJECTS)

clean:
	rm *.o

flash:
	openocd -f openocd.cfg -c "program $(PROGRAM) verify reset exit"

gdb: 
		 arm-none-eabi-gdb -q $(PROGRAM) -x gdb.cfg

.PHONY: clean flash gdb 
