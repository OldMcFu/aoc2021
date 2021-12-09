seven_seg = ["abcefg", "cf", "acdeg", "acdfg", "bcdf", "abdfg", "abdefg", "acf", "abcdefg", "abcdfg"]

with open("input.txt", 'r') as f:
    lines_digits = [(line.split(" | ")[0], line.split(" | ")[1].replace("\n", "")) for line in f.readlines()]
chars = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
summe = 0
for line, digits in lines_digits:
    # entspricht a,b,c,d,e,f
    char_map = [" ", " ", " ", " ", " ", " ", " "]
    for i ,char in enumerate(chars):
        if line.count(char) == 4:
            char_map[4] = char
        elif line.count(char) == 6:
            char_map[1] = char
        elif line.count(char) == 9:
            char_map[5] = char

    nums = line.split(" ")
    for num in nums:
        if len(num) == 2:
            for char in num:
                if char not in char_map:
                    char_map[2] = char
    for num in nums:
        if len(num) == 4:
            for char in num:
                if char not in char_map:
                    char_map[3] = char
    for i ,char in enumerate(chars):
        if line.count(char) == 8 and char not in char_map:
            char_map[0] = char
        elif line.count(char) == 7 and char not in char_map:
            char_map[6] = char
    for i, char in enumerate(char_map):
        digits = digits.replace(char, str(i))
    for i, char in enumerate(chars):
        digits = digits.replace(str(i), char)
    nums = [10**(i)*seven_seg.index("".join(sorted(digit))) for i,digit in enumerate(digits.split(" ")[::-1])]
    summe += sum(nums)
print(summe)
