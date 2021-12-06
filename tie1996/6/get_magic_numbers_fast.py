start_numbers = [0,1,2,3,4,5]
#start_numbers = [0]
magic_numbers = []

for num in start_numbers:
    fish = [0,0,0,0,0,0,0,0,0]
    fish[num] = 1
    for i in range(256):
        print("day: " + str(i))
        number_of_new_fish = fish.pop(0)
        fish.append(number_of_new_fish)
        fish[6] += number_of_new_fish
        print(fish)
        print("total num: " + str(sum(fish)))
    magic_numbers.append(sum(fish))
print(magic_numbers)

