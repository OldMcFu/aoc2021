import numpy
import cv2 
with open("input.txt", 'r') as f:
    map = numpy.array([list(map(int,list(line.strip()))) for line in f.readlines()], dtype=numpy.uint8)
max_height = numpy.amax(map)
basin_map = numpy.array(numpy.where(map == max_height, 0, 1), dtype=numpy.uint8)
ret, labels, stats, centroids = cv2.connectedComponentsWithStats(basin_map, connectivity=4)
label_area = sorted(stats[1::,4])
print(label_area[-1]*label_area[-2]*label_area[-3])
