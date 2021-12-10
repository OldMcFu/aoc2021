opening = ['(', '[', '{', '<']
closing = [')', ']', '}', '>']
score = [3, 57, 1197, 25137]

high_score = 0

with open("input.txt", 'r') as f:
    for line in f.readlines():
        opened = []
        for char in line.strip():
            if char in opening:
                opened.append(char)
            else:
                o = opened.pop()
                if opening.index(o) == closing.index(char):
                    continue
                else:
                    print("Corrupted!")
                    high_score += score[closing.index(char)]
                    break
print(high_score)