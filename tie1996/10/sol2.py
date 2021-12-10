opening = ['(', '[', '{', '<']
closing = [')', ']', '}', '>']
score = [1, 2, 3, 4]
scores = []


with open("input.txt", 'r') as f:
    for line in f.readlines():
        opened = []
        line_score = 0
        corrupted = False
        for char in line.strip():
            if char in opening:
                opened.append(char)
            else:
                o = opened.pop()
                if opening.index(o) == closing.index(char):
                    continue
                else:
                    corrupted = True
                    break
        if not corrupted:
            print(opened)
            while len(opened) > 0:
                char = opened.pop()
                line_score = line_score*5 + score[opening.index(char)]
            scores.append(line_score)
scores = sorted(scores)
index = len(scores) // 2
print(scores[index])