insertions = {}
chars = set()
with open("sample_input.txt",'r') as f:
    polymer_template = f.readline().strip()
    chars = set(polymer_template)
    f.readline()
    for line in f.readlines():
        key, value = line.strip().split(" -> ")
        insertions[key] = value
        chars.add(value)

for i in range(10):
    new_string = list(polymer_template)
    inserts = 0
    for k in range(len(polymer_template) - 1):
        sub = polymer_template[k:k+2]
        #print(sub)
        if sub in insertions.keys():
            inserts += 1
            new_string.insert(k  + inserts, insertions[sub])
    polymer_template = "".join(new_string)
    
char_count = []
for char in list(chars):
    char_count.append(polymer_template.count(char))
max_char_count = max(char_count)
min_char_count = min(char_count)
print(f"Max: {max_char_count} \nMin: {min_char_count}\nSolution: {max_char_count-min_char_count}")