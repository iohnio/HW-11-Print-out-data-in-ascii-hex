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
    mov ah, al            ; save full byte in AH
    shr ah, 4             ; isolate high nibble
    cmp ah, 9
    jbe .high_digit
    add ah, 'A' - 10
    jmp .store_high
.high_digit:
    add ah, '0'
.store_high:
    mov [edi], ah
    inc edi

    ; Convert low nibble
    mov ah, al            ; get original byte again
    and ah, 0x0F          ; isolate low nibble
    cmp ah, 9
    jbe .low_digit
    add ah, 'A' - 10
    jmp .store_low
.low_digit:
    add ah, '0'
.store_low:
    mov [edi], ah
    inc edi

    ; Add space if more bytes remain
    dec ecx
    cmp ecx, 0
    je .after_loop
    mov byte [edi], ' '
    inc edi
    jmp .loop

.after_loop:
    ; Print outputBuf to stdout
    mov eax, 4        ; sys_write
    mov ebx, 1        ; stdout
    mov ecx, outputBuf
    mov edx, edi
    sub edx, outputBuf
    int 0x80

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80