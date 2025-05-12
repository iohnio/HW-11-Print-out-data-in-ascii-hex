# HW#11 Print out data in ascii hex

## Files Included:
main.asm - the assembly source code for the version without the subroutine  
main_ec.asm - the assembly source code for the version with the subroutine (extra credit)  
makefile - automates the build process  
README.md - this documentation

## Description:
This program takes an array of bytes (inputBuf), converts each byte into its two-character ASCII 
hexadecimal representation, and stores the result into outputBuf. Each hex pair is separated by 
a space. At the end, the program prints the translated string to the screen followed by a newline.
main.asm directly processes each byte, converting the high and low nibbles of each byte to their 
ASCII hexadecimal equivalents and storing them in outputBuf, while main_ec.asm uses a subroutine 
to handle the conversion of each nibble to its ASCII representation.

For example, if the input is:
0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A

Then the output will be:
83 6A 88 DE 9A C3 54 9A

## Compilation & Execution:
To compile both versions of the program, run:
make

To execute the version without the subroutine, run:
./hw11translate2Ascii

To execute the version with the subroutine (extra credit), run:
./hw11translate2Ascii_ec

To remove the compiled object files, run: make clean
