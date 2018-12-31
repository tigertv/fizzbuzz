BITS 32
global _start

section .data

fizz db "Fizz"
fizz_len equ $-fizz

buzz db "Buzz"
buzz_len equ $-buzz

fizzbuzz_len equ $-fizz

separator db 0x20
newline db 0xa

section .text
_start:
	mov eax, 100; natural integer number
	call fizzbuzz

	;exit
	mov eax, 1
	xor ebx, ebx
	int 0x80

fizzbuzz:
	push ebp
	mov ebp, eax
	mov esi, 1 
	push 0

	fb_loop:

	mov [esp], byte 0
	mov eax, esi
	mov ebx, 3
	xor edx, edx
	div ebx
	test edx, edx
	jnz next_1
	mov [esp], byte 1

	mov ecx, fizz
	mov edx, fizz_len
	call print_string

	next_1:

	mov eax, esi

	mov ebx, 5
	xor edx, edx
	div ebx
	test edx, edx
	jnz next_2
	mov [esp], byte 1

	mov ecx, buzz
	mov edx, buzz_len
	call print_string

	next_2:

	mov eax, [esp]
	test eax, eax
	jnz next_3

	mov eax, esi
	call print_number

	next_3:

	mov ecx, separator 
	call print_symbol

	inc esi
	cmp esi, ebp
	jng fb_loop
	
	mov ecx, newline
	call print_symbol

	pop eax

	pop ebp
	ret

print_symbol:
	mov edx, 1    ; length of the string
print_string:
	mov eax, 4    ; system call number (sys_write)
	mov ebx, 1    ; file descriptor (stdout)
	int 0x80
	ret

print_number:
	mov ecx, esp
	sub esp, 12   ; reserve space for the number string, for base-2 it takes 33 bytes with new line, aligned by 4 bytes it takes 36 bytes.

	mov edi, 0
	mov ebx, 10   ; base-10

	print_loop:

	xor edx, edx
	div ebx
	add dl, '0'
	dec ecx
	inc edi
	mov [ecx],dl
	test eax, eax
	jnz print_loop

	mov edx, edi  ; length of the string
	call print_string

	add esp, 12   ; release space for the number string
	ret
