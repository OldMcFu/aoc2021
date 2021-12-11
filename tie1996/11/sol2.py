import numpy
with open("input.txt", 'r') as f:
    energy_levels = numpy.array([list(map(int, list(line.strip()))) for line in f.readlines()])
energy_levels = numpy.pad(energy_levels, (1,1), 'constant', constant_values=(10))
day = 0
while True:
    day += 1
    energy_levels += 1
    has_flashed = numpy.zeros((10,10))
    while True:
        flashing_octopuses = numpy.where((energy_levels[1:-1, 1:-1] > 9) & (has_flashed == 0), 1, 0)
        has_flashed += flashing_octopuses
        if numpy.sum(flashing_octopuses) == 0:
            energy_levels[1:-1, 1:-1] = numpy.where(has_flashed > 0, 0, energy_levels[1:-1, 1:-1])
            has_flashed = numpy.where(has_flashed > 1, 1, has_flashed)
            print(f"----------- DAY {day+1} -------------")
            print(energy_levels)
            print(has_flashed)
            print("Flashes today: " + str(numpy.sum(has_flashed)))
            break
        else:
            for i, col in enumerate(flashing_octopuses):
                for k, val in enumerate(col):
                    if val == 1:
                        energy_levels[i:i+3, k:k+3] += 1
    if numpy.sum(has_flashed) == 100:
        print(f"All flashing at day {day}!")
        break