aim = 0
horizontal = 0
depth = 0
lines = []
with open("input.txt", 'r') as f:
    lines = f.readlines()

for line in lines:
    command, value = line.split(" ")[0:2]
    if command == "forward":
        horizontal += int(value)
        depth += aim * int(value)
    elif command == "down":
        aim += int(value)
    else:
        aim -= int(value)

print("horizontal " + str(horizontal))
print("depth " + str(depth))

print(depth * horizontal)
