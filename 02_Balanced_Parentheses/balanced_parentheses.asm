section .data
    input db "((a+b)*c)",0
    balanced db "Balanced",0
    not_balanced db "Not Balanced",0

section .bss
    stack resb 100
    top resb 1

section .text
    global _start

_start:
    mov byte [top], -1
    mov esi, input

check_loop:
    mov al, [esi]
    cmp al, 0
    je end_check

    cmp al, '('
    je push_stack

    cmp al, ')'
    je pop_stack

    jmp next_char

push_stack:
    inc byte [top]
    mov bl, [top]
    mov [stack + ebx], al
    jmp next_char

pop_stack:
    cmp byte [top], -1
    je not_bal
    dec byte [top]
    jmp next_char

next_char:
    inc esi
    jmp check_loop

end_check:
    cmp byte [top], -1
    jne not_bal

bal:
    mov eax,4
    mov ebx,1
    mov ecx,balanced
    mov edx,8
    int 80h
    jmp exit

not_bal:
    mov eax,4
    mov ebx,1
    mov ecx,not_balanced
    mov edx,12
    int 80h

exit:
    mov eax,1
    xor ebx,ebx
    int 80h
