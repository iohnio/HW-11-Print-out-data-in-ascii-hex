; Author: John Jo, 
; Class: 313, Prof Kidd

section .data
inputBuf db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A
inputLen equ 8
newline db 0xA

section .bss
outputBuf resb 80

section .text
global _start

_start:
    mov esi, inputBuf     ; source pointer
    mov edi, outputBuf    ; destination pointer
    mov ecx, inputLen     ; number of bytes to process

.loop:
    lodsb                 ; load byte into AL, increment ESI

    ; Convert high nibble
    mov ah, al
    shr ah, 4
    mov al, ah
    call nibble_to_ascii
    stosb                 ; store ASCII char into [edi], increment EDI

    ; Convert low nibble
    mov al, byte [esi - 1]
    and al, 0x0F
    call nibble_to_ascii
    stosb

    ; Add a space if more bytes remain
    dec ecx
    cmp ecx, 0
    jl .after_loop
    mov al, ' '
    stosb
    jmp .loop

.after_loop:
    ; Append newline
    mov al, 0xA
    stosb

    ; Write outputBuf to stdout
    mov eax, 4        ; sys_write
    mov ebx, 1        ; stdout
    mov ecx, outputBuf
    mov edx, edi
    sub edx, outputBuf
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

; Subroutine: Convert nibble (0-15) in AL to ASCII
; Returns ASCII character in AL
nibble_to_ascii:
    cmp al, 9
    jbe .digit
    add al, 'A' - 10
    ret
.digit:
    add al, '0'
    ret