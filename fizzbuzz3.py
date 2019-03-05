#!/usr/bin/python

# Without division
def fizzbuzz(number):
	rmd3 = 0
	rmd5 = 0
	print(1),
	for num in range(2,number+1):
		rmd3 += 1
		rmd5 += 1
		string = ""
		if rmd3 == 3:
			rmd3 = 0
			string = "Fizz"
		if rmd5 == 5:
			rmd5 = 0
			string += "Buzz"
		if string == "":
			string = str(num)
		print(", "+string),

fizzbuzz(100)
