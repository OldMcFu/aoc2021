import numpy

with open("input.txt", "r") as f:
    lines = f.readlines()
p0 = []
p1 = []
for line in lines:
    points = line.split(" -> ")
    p0.append(list(map(int, points[0].split(","))))
    p1.append(list(map(int, points[1].split(","))))

p0 = numpy.array(p0)
p1 = numpy.array(p1)
#find max
max = ( numpy.amax(p0) if numpy.amax(p0) > numpy.amax(p1) else numpy.amax(p1) ) + 1
print(max)
map = numpy.zeros((max, max))
indices = numpy.where((p0[:,0] == p1[:,0]) | (p0[:,1] == p1[:,1]))[0]

for i in indices:
    #print(i)
    y1 = p0[i,0]
    y2 = p1[i,0]
    x1 = p0[i,1]
    x2 = p1[i,1]
    if x1 == x2:
        if y1 < y2:
            map[x1, y1:y2+1] += 1
        else:
            map[x1, y2:y1+1] += 1
    else:
        if x1 < x2:
            map[x1:x2+1, y1] += 1
        else:
            map[x2:x1+1, y1] += 1
print(map)
times = numpy.where(map >= 2)
print(numpy.shape(times))