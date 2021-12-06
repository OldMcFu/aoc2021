import numpy

with open("input.txt", "r") as f:
    numbers = numpy.array(list(map(int, f.readline().split(","))))
print(numbers)
maigc_numbers = [6703087164, 6206821033, 5617089148, 5217223242, 4726100874, 4368232009]

sum = 0
for num in numbers:
    sum += maigc_numbers[num]
print(sum)