with open("input.txt", 'r') as f:
    map = [list(map(int,list(line.strip()))) for line in f.readlines()]

risk_level = 0
for i, row in enumerate(map):
    for k, col in enumerate(row):
        neighbours = []
        for ii in range(-1,2):
            for kk in range(-1,2):
                if i+ii < 0 or k+kk < 0 or (ii == 0 and kk == 0):
                    continue
                try:
                    neighbours.append(map[i+ii][k+kk])
                except:
                    pass
        if min(neighbours) > map[i][k]:
            print( map[i][k])
            risk_level += map[i][k] + 1

print(f"risk level: {risk_level}")