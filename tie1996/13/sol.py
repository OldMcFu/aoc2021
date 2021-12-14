import numpy
dots = []
folds = []
with open("input.txt", 'r') as f:
    for line in f.readlines():
        if line == "\n":
            continue
        elif line.startswith("fold"):
            folds.append(line.replace("fold along",'').strip().split("="))
        else:
            dots.append(tuple(map(int, line.strip().split(","))))

def process_folds(dots, fold):
    fold_line = int(fold[1])
    if fold[0] == 'y':
        new_dots = list(set([dot if dot[1] < fold_line else (dot[0], dot[1] - (dot[1] - fold_line)*2) for dot in dots]))
    if fold[0] == 'x':
        new_dots = list(set([dot if dot[0] < fold_line else (dot[0] - (dot[0] - fold_line)*2, dot[1]) for dot in dots]))
    new_dots = list(set(new_dots))
    return new_dots

for i,fold in enumerate(folds):
    dots = process_folds(dots, fold)
    if i == 0:
        print(f"Part 1: {len(dots)}")
map = numpy.zeros((40,40), dtype=int)
for dot in dots:
    map[dot[1],dot[0]] = 1
numpy.savetxt("output.txt", map, delimiter=' ', fmt='%i')