.PHONY: clean 

fizzbuzz: fizzbuzz.o
	ld -melf_i386 $< -o $@
fizzbuzz.o: fizzbuzz.asm
	nasm -f elf $< -o $@
clean:
	rm -f *.o fizzbuzz
