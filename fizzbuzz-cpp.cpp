#include <iostream>

void fizzbuzz1() {
    const int fizz = 3; 
    const int buzz = 5;
    int f = fizz - 1;
    int b = buzz - 1;
    for (int times = 1; times <= 100; times++) {
        if(f == 0) {
            std::cout << "Fizz";
            f = fizz;
        }
        if(b == 0) {
            std::cout << "Buzz";
            b = buzz;
        } else if (f != fizz) {
            std::cout << times;
        }
        f--;
        b--;
        std::cout << " ";
    }
}

int mod15(uint64_t number) {
    while (number > 0xf) {
        number = (number >> 4) + (number & 0xf);
    }
    if (number == 15) number = 0;
    return number;
}

void fizzbuzz2() {
    for (int times = 1; times <= 100; times++) {
        int rmd = mod15(times);
        if (rmd == 0) {
            std::cout << "FizzBuzz";
        } else if (rmd % 3 == 0) {
            std::cout << "Fizz";
        } else if (rmd % 5 == 0) {
            std::cout << "Buzz";
        } else {
            std::cout << times;
        }
        std::cout << " ";
    }
}

int main(int argc, const char * argv[]) {
    fizzbuzz1();
    std::cout << std::endl;
    fizzbuzz2();
    std::cout << std::endl;

    return 0;
}
