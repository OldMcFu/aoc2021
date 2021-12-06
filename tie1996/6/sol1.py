import numpy

with open("input.txt", "r") as f:
    numbers = numpy.array(list(map(int, f.readline().split(","))))
print(numbers)
maigc_numbers = [1421, 1401, 1191, 1154, 1034, 950]

sum = 0
for num in numbers:
    sum += maigc_numbers[num]
print(sum)