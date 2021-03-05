ARCH = armv7-a
MCPU = cortex-a8

TARGET = realviewPB
ARM_ARCH = cortexAR

CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-gcc
OC = arm-none-eabi-objcopy

LINKER_SCRIPT = ./EOS.ld
MAP_FILE = build/eos.map

ASM_SRCS = $(wildcard boot/*.S)
ASM_OBJS = $(patsubst boot/%.S, build/%.os, $(ASM_SRCS))

VPATH = boot \
				hal/$(TARGET) \
				lib		\
				kernel
				
C_SRCS = $(notdir $(wildcard ./boot/*.c))
C_SRCS += $(notdir $(wildcard ./hal/$(TARGET)/*.c))
C_SRCS += $(notdir $(wildcard ./lib/*.c))
C_SRCS += $(notdir $(wildcard ./kernel/*.c))
C_OBJS = $(patsubst %.c, build/%.o, $(C_SRCS))

INC_DIRS = -I boot		\
					 -I include	\
					 -I hal		\
					 -I hal/$(TARGET)	\
					 -I lib		\
					 -I kernel

CFLAGS = -c -g

LDFLAGS = -nostartfiles -nostdlib -nodefaultlibs -static -lgcc

eos = build/eos.axf
eos_bin = build/eos.bin

.PHONY: all clean run debug gdb

all: $(eos)

clean:
	@rm -rf build

run: $(eos)
	qemu-system-arm -M realview-pb-a8 -kernel $(eos) -nographic

debug: $(eos)
	qemu-system-arm -M realview-pb-a8 -kernel $(eos) -S -gdb tcp::1234,ipv4

gdb:
	gdb-multiarch

$(eos): $(ASM_OBJS) $(C_OBJS) $(LINKER_SCRIPT)
	$(LD) -n -T $(LINKER_SCRIPT) -o $(eos) $(ASM_OBJS) $(C_OBJS) -Wl,-Map=$(MAP_FILE) $(LDFLAGS)
	$(OC) -O binary $(eos) $(eos_bin)

build/%.os: %.S
	mkdir -p $(shell dirname $@)
	$(CC) -mcpu=$(MCPU) $(INC_DIRS) $(CFLAGS) -o  $@ $<

build/%.o: %.c
	mkdir -p $(shell dirname $@)
	$(CC) -mcpu=$(MCPU) $(INC_DIRS) $(CFLAGS) -o $@ $<
