section .data
    input db "HELLO",0
    length equ 5

section .bss
    stack resb 10
    output resb 10

section .text
    global _start

_start:

    mov ecx,length
    mov esi,input
    mov edi,stack

push_loop:
    mov al,[esi]
    mov [edi],al
    inc esi
    inc edi
    loop push_loop

    mov ecx,length
    dec edi
    mov ebx,output

pop_loop:
    mov al,[edi]
    mov [ebx],al
    inc ebx
    dec edi
    loop pop_loop

    mov eax,1
    int 0x80
