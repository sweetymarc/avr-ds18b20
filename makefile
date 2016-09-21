# 	makefile - a part of avr-ds18b20 library
#
#	Copyright (C) 2016 Jacek Wieczorek
#
#	This software may be modified and distributed under the terms
#	of the MIT license.  See the LICENSE file for details.


F_CPU =
MCU =

CC = avr-gcc
CFLAGS = -Wall -DF_CPU=$(F_CPU) -mmcu=$(MCU) -Os

LD = avr-ld
LDFLAGS =

ifndef F_CPU
$(error F_CPU is not set!)
endif

ifndef MCU
$(error MCU is not set!)
endif

all: obj/ds18b20.o end

obj/ds18b20.o: force obj/onewire.o obj/tmp/ds18b20.o
	$(LD) $(LDFLAGS) -r obj/onewire.o obj/tmp/ds18b20.o -o obj/ds18b20.o

obj/onewire.o: src/onewire.c include/onewire.h
	$(CC) $(CFLAGS) -c src/onewire.c -o obj/onewire.o

obj/tmp/ds18b20.o: src/ds18b20.c include/ds18b20.h
	$(CC) $(CFLAGS) -c src/ds18b20.c -o obj/tmp/ds18b20.o

force:
	-mkdir obj
	-mkdir obj/tmp

clean:
	rm -rf obj

end:
	avr-size -C --mcu=$(MCU) obj/ds18b20.o
