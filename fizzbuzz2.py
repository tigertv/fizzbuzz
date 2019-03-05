#!/usr/bin/python


# hard way :)
def fizzbuzz2(upper_limit=100):
    result = list(range(1, upper_limit + 1))
    for i, res in enumerate(result):

        # divisible by 15 ?
        rmd = res
        while rmd > 15:
            rmd = (rmd & 15) + (rmd >> 4)
        if rmd == 15:
            result[i] = 'FizzBuzz'
            continue

        # divisible by 3 ?
        tmp = rmd
        while tmp > 3:
            tmp = (tmp & 3) + (tmp >> 2)
        if tmp == 3:
            result[i] = 'Fizz'
            continue

        # divisible by 5 ?
        tmp = rmd
        do_pos = True
        pos = tmp & 3
        neg = (tmp >> 2) & 3

        if pos == neg:
            result[i] = 'Buzz'

    return result
    
print(fizzbuzz2())

