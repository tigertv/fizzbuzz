#!/usr/bin/python


def fizzbuzz(substitutes=[('Fizz', 3), ('Buzz', 5)], upper_limit=100):
    '''
    Description of fizzbuzz
    '''

    result = list(range(1, upper_limit + 1))

    for substitute, divisor in substitutes:
        for i in range(divisor - 1, upper_limit, divisor):
            if isinstance(result[i], int):
                result[i] = substitute
            else:
                result[i] += substitute

    return result
   

print(fizzbuzz())
