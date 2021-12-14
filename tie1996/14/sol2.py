insertions = {}
chars = set()
with open("input.txt",'r') as f:
    polymer_template = f.readline().strip()
    chars = set(polymer_template)
    f.readline()
    for line in f.readlines():
        key, value = line.strip().split(" -> ")
        insertions[key] = value
        chars.add(value)

char_count = {}
for char in list(chars):
    char_count[char] = polymer_template.count(char)

substring_count = {}
for k in range(len(polymer_template) - 1):
    sub = polymer_template[k:k+2]
    if sub not in substring_count.keys():
        substring_count[sub] = 1
    else:
        substring_count[sub] += 1

for i in range(40):
    substring_count_temp = substring_count.copy()
    for key in substring_count.keys():
        if key in insertions.keys():
            char_count[insertions[key]] += substring_count[key]
            new_key_1 = key[0] + insertions[key]
            new_key_2 = insertions[key] + key[1]
            substring_count_temp[new_key_1] = substring_count[key] if new_key_1 not in substring_count_temp.keys() else substring_count_temp[new_key_1] + substring_count[key]
            substring_count_temp[new_key_2] = substring_count[key] if new_key_2 not in substring_count_temp.keys() else substring_count_temp[new_key_2] + substring_count[key]
            substring_count_temp[key] -= substring_count[key]
    substring_count = substring_count_temp.copy()

nums = [value for value in char_count.values()]
max_char_count = max(nums)
min_char_count = min(nums)
print(f"Max: {max_char_count} \nMin: {min_char_count}\nSolution: {max_char_count-min_char_count}")
