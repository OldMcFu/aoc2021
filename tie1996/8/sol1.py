with open("input.txt") as f:
    digits_per_line = [line.split(" | ")[1].replace("\n", "").split(" ") for line in f.readlines()]
print(sum([sum([1 if len(set(digit)) in [2,4,3,7] else 0 for digit in line]) for line in digits_per_line]))
