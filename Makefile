ASM = nasm
RUSTC = cargo
OBJCOPY = objcopy
QEMU = qemu-system-x86_64

BOOT_BIN = bootloader/boot.bin
KERNEL_ELF = kernel/target/x86_64-blog_os/release/kernel
KERNEL_BIN = kernel.bin
OUTPUT = my_os.img

all: $(OUTPUT)

$(BOOT_BIN): bootloader/boot.asm
	$(ASM) -f bin -o $@ $<

$(KERNEL_ELF):
	cd kernel && $(RUSTC) +nightly build --release

$(KERNEL_BIN): $(KERNEL_ELF)
	$(OBJCOPY) -O binary $< $@

$(OUTPUT): $(BOOT_BIN) $(KERNEL_BIN)
	cat $(BOOT_BIN) $(KERNEL_BIN) > $@

run: $(OUTPUT)
	$(QEMU) -drive file=$(OUTPUT),format=raw -nographic

clean:
	rm -f $(BOOT_BIN) $(KERNEL_BIN) $(OUTPUT)
	cd kernel && $(RUSTC) clean
