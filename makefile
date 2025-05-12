all: hw11translate2Ascii hw11translate2Ascii_ec

hw11translate2Ascii: main.asm
	nasm -f elf main.asm -o main.o
	ld -m elf_i386 -s -o hw11translate2Ascii main.o

hw11translate2Ascii_ec: main_ec.asm
	nasm -f elf main_ec.asm -o main_ec.o
	ld -m elf_i386 -s -o hw11translate2Ascii_ec main_ec.o

clean:
	rm -f *.o hw11translate2Ascii hw11translate2Ascii_ec