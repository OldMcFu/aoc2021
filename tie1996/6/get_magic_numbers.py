import numpy

start_numbers = [0,1,2,3,4,5]
#start_numbers = [0]
magic_numbers = []

for num in start_numbers:
    fish_array = numpy.array([[num]])
    print(numpy.shape(fish_array))
    for i in range(256):
        print("day: "+ str(i))
        new_fish = numpy.where(fish_array == 0)[0]
        fish_array = numpy.where(fish_array == 0, 6, fish_array-1)
        print(numpy.shape(new_fish))
        if numpy.shape(new_fish)[0] > 0:
            print("new_fish")
            fish = numpy.zeros((1,numpy.shape(new_fish)[0])) + 8
            print(numpy.shape(fish_array))
            fish_array = numpy.concatenate((fish_array, fish), axis=1)
        print(fish_array)
    magic_numbers.append(numpy.shape(fish_array)[1])
print(magic_numbers)