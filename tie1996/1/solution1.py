with open("input1.txt", 'r') as f:
    lines = list(map(int, f.readlines()))

asc = 0
for i in range(1, len(lines)):
    if lines[i] > lines[i-1]:
        asc += 1
print(asc)

