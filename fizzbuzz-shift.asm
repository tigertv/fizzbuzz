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

	.loop:
		mov eax, esi

		mov ebx, 0xffff0000
		and ebx, eax
		shr ebx, 16
		and eax, 0x0000ffff
		add eax, ebx
		mov ebx, 0x00010000
		and ebx, eax
		shr ebx, 16
		and eax, 0x0000ffff
		add eax, ebx

		mov bx, 0xff00
		and ebx, eax
		shr ebx, 8
		and ax, 0x00ff
		add eax, ebx
		mov bx, 0x0100
		and ebx, eax
		shr ebx, 8
		and ax, 0x00ff
		add eax, ebx

		mov bx, 0x00f0
		and ebx, eax
		shr ebx, 4
		and ax, 0x000f
		add eax, ebx
		mov bx, 0x0010
		and ebx, eax
		shr ebx, 4
		and ax, 0x000f
		add eax, ebx

		cmp al, 0x0f 
		jne .next_2

		mov ecx, fizz
		mov edx, fizzbuzz_len
		call print_string
		jmp .next_another

		.next_2:

		mov edx, eax
		mov bx, 0x000c
		and ebx, eax
		shr ebx, 2
		and ax, 0x0003
		add eax, ebx
		mov ebx, 0x0004
		and ebx, eax
		shr ebx, 2
		and ax, 0x0003
		add eax, ebx

		cmp al, 3
		jnz .next_3

		mov ecx, fizz
		mov edx, fizz_len
		call print_string
		jmp .next_another

		.next_3:
		mov eax,edx

		mov bx, 0x000c
		and ebx, eax
		shr ebx, 2
		and eax, 0x0003

		cmp eax, ebx
		jne .next_4

		mov ecx, buzz
		mov edx, buzz_len
		call print_string
		jmp .next_another

		.next_4:

		mov eax, esi
		call print_number

		.next_another:

		mov ecx, separator 
		call print_symbol

		inc esi
		cmp esi, ebp
		jng .loop
	
	mov ecx, newline
	call print_symbol

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

	.loop:
		xor edx, edx
		div ebx
		add dl, '0'
		dec ecx
		inc edi
		mov [ecx],dl
		test eax, eax
		jnz .loop

	mov edx, edi  ; length of the string
	call print_string

	add esp, 12   ; release space for the number string
	ret
