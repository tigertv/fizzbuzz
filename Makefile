.PHONY: clean all

AS = nasm
LNK = ld 
SRC = $(wildcard *.asm)
BIN := $(SRC:.asm=)

all: $(BIN)
	
%: %.o
	$(LNK) -melf_i386 $< -o $@
%.o: %.asm
	$(AS) -f elf $< -o $@

fizzbuzz-cpp: fizzbuzz-cpp.cpp
	g++ $< -o $@

clean:
	rm -f $(BIN) fizzbuzz-cpp
