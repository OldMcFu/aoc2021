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
map = numpy.zeros((max, max))
indices = numpy.where((p0[:,0] == p1[:,0]) | (p0[:,1] == p1[:,1]))[0]
indices_diag = numpy.where((numpy.abs(p0[:,0] - p1[:,1]) == numpy.abs(p0[:,1] - p1[:,0])) |  (numpy.abs(p0[:,0] - p1[:,0]) == numpy.abs(p0[:,1] - p1[:,1])))[0]
for i in indices:
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
for i in indices_diag:
    y1 = p0[i,0]
    y2 = p1[i,0]
    x1 = p0[i,1]
    x2 = p1[i,1]
    #get rightmost start point
    if y1 < y2:
        start_x = x1
        start_y = y1
        end_x = x2
        end_y = y2
        if x1 < x2:
            m = 1
        else:
            m = -1
    else:
        start_x = x2
        start_y = y2
        end_x = x1
        end_y = y1
        if x1 < x2:
            m = -1
        else:
            m = 1
    while(start_x != end_x):
        map[start_x, start_y] += 1
        start_x += m
        start_y += 1
    map[start_x, start_y] += 1
    #print(map)

print(map)
times = numpy.where(map >= 2)
print(numpy.shape(times))