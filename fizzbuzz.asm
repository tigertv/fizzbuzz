BITS 32
global _start

section .data

fizz     db "Fizz"
fizz_len equ $-fizz

buzz     db "Buzz"
buzz_len equ $-buzz

fizzbuzz_len equ $-fizz

separator db 0x20
newline   db 0xa

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
	push 0

	fb_loop:

		mov eax, [esp]
		inc eax
		mov [esp], eax
		xor ebx, ebx 
		cmp eax, 3
		jnz next_1

		xor eax, eax
		mov [esp], eax
		
		mov ecx, fizz
		mov edx, fizz_len
		call print_string
		mov ebx, 1

		next_1:

		mov eax, [esp+4]
		inc eax
		mov [esp+4], eax
		cmp eax, 5
		jnz next_2

		xor eax, eax
		mov [esp+4], eax

		mov ecx, buzz
		mov edx, buzz_len
		call print_string
		mov ebx, 1

		next_2:
		test ebx,ebx
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
	sub esp, 12   ; reserve space for the number string

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
