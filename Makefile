LD=ld
RUSTC=rustc
NASM=nasm
QEMU=qemu-system-x86_64

all: disk.img

.SUFFIXES: .o .rs

.PHONY: clean run

.rs.o:
	$(RUSTC) -O --crate-type lib -o $@ --emit obj $<

disk.img: pure64.sys kernel64.sys
	dd if=/dev/zero of=$@ bs=1M count=2 &>/dev/null
	cat pure64.sys kernel64.sys > software.sys
	dd if=bmfs_mbr.sys of=disk.img bs=512 conv=notrunc
	dd if=software.sys of=disk.img bs=512 seek=16 conv=notrunc

pure64.sys:
	cd Pure64; ./build.sh; cd ..

kernel64.sys: kernel64.o
	$(LD) -T app.ld -o kernel64.sys kernel64.o

run: disk.img
	$(QEMU) -hda $<

clean:
	rm -f *.bin *.o *.img *.sys
