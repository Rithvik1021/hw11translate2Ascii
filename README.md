hw11translate2Ascii:

This program takes a fixed set of bytes and converts each one into its ASCII hexadecimal representation. The results are stored in an output buffer and printed to the screen.
How to Compile and Run:

Use the following commands in Linux

nasm -f elf32 hw11translate2Ascii.asm -o hw11translate2Ascii.o
ld -m elf_i386 hw11translate2Ascii.o -o hw11translate2Ascii
./hw11translate2Ascii

Expexcted Ouput:
83 6A 88 DE 9A C3 54 9A

