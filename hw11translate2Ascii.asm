section .data
    ; Input data to be translated from binary to ASCII hex
    inputData:   db  0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A
    inputLen:    equ $ - inputData
    newline:     db 0x0A

section .bss
    outputBuf:   resb 80

section .text
    global _start

_start:
    ;pointers to input and output buffers
    mov esi, inputData
    mov edi, outputBuf
    mov ecx, inputLen

convert_bytes:
    ; Load next byte and copy to handle both high and low
    mov al, [esi]
    mov ah, al

    ; convert leftmost 4 bits
    shr al, 4
    call toAsciiHex
    mov [edi], al
    inc edi

    ; convert rightmost 4 bits
    and ah, 0x0F
    mov al, ah
    call toAsciiHex  ; convert to ASCII hex character
    mov [edi], al
    inc edi

    ; add a space between each byte
    mov byte [edi], ' '
    inc edi

    inc esi
    loop convert_bytes  ; Repeat until all bytes are processed

    ; Overwrite the final space with a newlin
    dec edi
    mov byte [edi], 0x0A

    ; write outputBuf to STDOUT
    mov eax, 4
    mov ebx, 1
    mov ecx, outputBuf
    mov edx, edi
    sub edx, outputBuf
    int 0x80

    ;exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

;Extra Credit
toAsciiHex:
    cmp al, 9
    jbe .digit
    add al, 0x37  ; For values A-F
    ret

.digit:
    add al, 0x30  ; For values 0-9
    ret
