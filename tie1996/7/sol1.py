import numpy

with open("input.txt") as f:
    crab_positions = [int(i) for i in f.readline().split(',')]

min = min(crab_positions)
max = max(crab_positions)
index = 0
min_fuel = 999999999999
for i in range(min, max+1):
    print("index" + str(i))
    fuel_consumption = numpy.sum(numpy.abs(numpy.array(crab_positions) - i))
    print(fuel_consumption)
    if fuel_consumption < min_fuel:
        index = i
        min_fuel = fuel_consumption
    #index = i if fuel_consumption < min_fuel else index

print(index)
print(min_fuel)

""" fuel_costs = numpy.zeros((max-min+1, len(crab_positions)))
positions = numpy.arange(min, max+1)
fuel_costs = numpy.array(crab_positions)[numpy.newaxis, :]
fuel_costs = numpy.abs(fuel_costs - positions[:, numpy.newaxis])
sums = numpy.sum(fuel_costs, axis=1)
min_fuel_sum_index = numpy.argmin(sums)
print(min_fuel_sum_index + min) """