with open("input1.txt", 'r') as f:
    lines = list(map(int, f.readlines()))

sliding_window = []

for i in range(0, len(lines)-2):
    sliding_window.append(lines[i] + lines[i+1] + lines[i+2])

asc = 0
for i in range(1, len(sliding_window)):
    if sliding_window[i] > sliding_window[i-1]:
        asc += 1
print(asc)