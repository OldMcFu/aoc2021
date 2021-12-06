import numpy

lines = []
with open("input.txt", 'r') as f:
    for line in f.readlines():
        l = list(line)[0:-1]
        lines.append(list(map(int, l)))

bits = numpy.array(lines)
threshold = numpy.shape(bits)[0] / 2
max = numpy.sum(bits, axis=0)
gamma_bitmask = list(map(int, max > threshold))
epsilon_bitmask = list(map(int, max < threshold))

print(gamma_bitmask)
print(epsilon_bitmask)

gamma = int("0b" + "".join(str(i) for i in gamma_bitmask), 2)
epsilon = int("0b" + "".join(str(i) for i in epsilon_bitmask), 2)
print(f"gamme {gamma}, epsilon {epsilon}, product {gamma*epsilon}")

