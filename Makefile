ARCH = armv7-a
MCPU = cortex-a8

CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OC = arm-none-eabi-objcopy

LINKER_SCRIPT = ./EOS.ld

ASM_SRCS = $(wildcard boot/*.S)
ASM_OBJS = $(patsubst boot/%.S, build/%.o, $(ASM_SRCS))

eos = build/eos.axf
eos_bin = build/eos.bin

.PHONY: all clean run debug gdb

all: $(eos)

clean:
	@rm -fr build

run: $(eos)
	qemu-system-arm -M realview-pb-a8 -kernel $(eos)

debug: $(eos)
	qemu-system-arm -M realview-pb-a8 -kernel $(eos) -S -gdb tcp::1234,ipv4

gdb:
	gdb-multiarch

$(eos): $(ASM_OBJS) $(LINKER_SCRIPT)
	$(LD) -n -T $(LINKER_SCRIPT) -o $(eos) $(ASM_OBJS)
	$(OC) -O binary $(eos) $(eos_bin)

build/%.o: boot/%.S
	mkdir -p $(shell dirname $@)
	$(AS) -march=$(ARCH) -mcpu=$(MCPU) -g -o $@ $<
