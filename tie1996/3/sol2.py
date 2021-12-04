import numpy

lines = []
with open("input.txt", 'r') as f:
    for line in f.readlines():
        l = list(line)[0:-1]
        lines.append(list(map(int, l)))

def calc_bitmask(array, positive=True):
    threshold = numpy.shape(array)[0] / 2
    max = numpy.sum(array, axis=0)
    return list(map(int, max >= threshold if positive else max < threshold))

bits = numpy.array(lines)
ox_bits = numpy.copy(bits)
co2_bits = numpy.copy(bits)

for i in range(numpy.shape(bits)[1]):
    ox_bitmask = calc_bitmask(ox_bits)
    value = ox_bitmask[i]
    ox_mask = numpy.where(ox_bits[:, i] == value)[0]
    ox_bits = ox_bits[ox_mask, :]
    if numpy.shape(ox_bits)[0] == 1:
        print(ox_bits[0])
        break

for i in range(numpy.shape(bits)[1]):
    co2_bitmask = calc_bitmask(co2_bits, False)
    print(co2_bitmask)
    value = co2_bitmask[i]
    print(co2_bits)
    co2_mask = numpy.where(co2_bits[:, i] == value)[0]
    print(co2_mask)
    co2_bits = co2_bits[co2_mask, :]
    if numpy.shape(co2_bits)[0] == 1:
        print(co2_bits[0])
        break

oxygen_generator_rating = int("0b" + "".join(str(i) for i in ox_bits[0]), 2)
co2_scrubber_rating = int("0b" + "".join(str(i) for i in co2_bits[0]), 2)

print(f"oxygen_generator_rating {oxygen_generator_rating}, co2_scrubber_rating {co2_scrubber_rating}, product {oxygen_generator_rating*co2_scrubber_rating}")