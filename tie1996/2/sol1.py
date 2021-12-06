horizontal = 0
depth = 0
lines = []
with open("input.txt", 'r') as f:
    lines = f.readlines()

for line in lines:
    command, value = line.split(" ")[0:2]
    if command == "forward":
        horizontal += int(value)
    elif command == "down":
        depth += int(value)
    else:
        depth -= int(value)

print("horizontal " + str(horizontal))
print("depth " + str(depth))

print(depth * horizontal)
