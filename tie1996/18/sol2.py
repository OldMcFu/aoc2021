import re
import copy
class Pair:
    def __init__(self):
        self.parent = None
        pass

    def init_with_left_and_right(self, left, right):
        self.left = left
        self.right = right
        self.left.parent = self
        self.right.parent = self
    
    def init_with_ints(self, left, right):
        self.left = left
        self.right = right

    def init_from_string(self, str):
        number_re = re.compile(r'\d+')
        if str[0] != '[' or str[-1] != ']':
            print("Malformed String!")
        else:
            #find left and right
            count = 0
            split_index = 0
            for i in range(1, len(str)):
                if str[i] == ',' and count == 0:
                    #found the index -> stop
                    split_index = i
                    break
                elif str[i] == '[':
                    count += 1
                elif str[i] == ']':
                    count -= 1 
            sub_string_left = str[1:i]
            sub_string_right = str[i+1:len(str)-1]
        if number_re.match(sub_string_right) is not None:
            self.right = int(sub_string_right)
        else:
            self.right = Pair()
            self.right.init_from_string(sub_string_right)
            self.right.parent = self
        if number_re.match(sub_string_left) is not None:
            self.left = int(sub_string_left)
        else:
            self.left = Pair()
            self.left.init_from_string(sub_string_left)
            self.left.parent = self

    def get_magnitude(self):
        if type(self.left) == int:
            val_left = self.left
        else:
            val_left = self.left.get_magnitude()
        if type(self.right) == int:
            val_right = self.right
        else:
            val_right = self.right.get_magnitude()
        return 3 * val_left + 2 * val_right

    def go_down(self, num, direction):
        if direction == 'right':
            if type(self.right) == int:
                self.right += num
            else:
                self.right.go_down(num, direction)
        else:
            if type(self.left) == int:
                self.left += num
            else:
                self.left.go_down(num, direction)
        pass

    def go_up(self, child, num, direction):
        if direction == 'left':
            if self.right == child:
                #go down
                if type(self.left) == int:
                    self.left += num
                    return
                else:
                    self.left.go_down(num, direction='right')
            elif self.left == child and self.parent is None:
                #here we are at the top of the tree and there is no left element
                return
            elif self.parent is not None:
                self.parent.go_up(self, num, direction)
        else:
            if self.left == child:
                #go down
                if type(self.right) == int:
                    self.right += num
                    return
                else:
                    self.right.go_down(num, direction='left')
            elif self.left == child and self.parent is None:
                #here we are at the top of the tree and there is no left element
                return
            elif self.parent is not None:
                self.parent.go_up(self, num, direction)


    def set_zero(self, pair):
        if self.left == pair:
            self.left = 0
        else:
            self.right = 0

    def explode(self, depth = 0):
        has_exploded = False
        if type(self.left) == int and type(self.right) == int and depth >= 4:
            
            #add to left most
            self.parent.go_up(self, self.left, 'left')
            #add to right most
            self.parent.go_up(self, self.right, 'right')

            self.parent.set_zero(self)
            has_exploded = True
            
        if type(self.left) == Pair:
            has_exploded = self.left.explode(depth + 1)
        if type(self.right) == Pair:
            has_exploded = self.right.explode(depth + 1)
        return has_exploded

    def split_once(self):
        has_split = False
        if type(self.left) == int:
            if self.left > 9:
                new_pair = Pair()
                left_num = self.left // 2
                right_num = self.left // 2 + (self.left % 2 > 0)
                new_pair.init_with_ints(left_num, right_num)
                new_pair.parent = self
                self.left = new_pair
                has_split = True
        elif not has_split:
            has_split = self.left.split_once()

        if type(self.right) == int and not has_split:
            if self.right > 9:
                new_pair = Pair()
                left_num = self.right // 2
                right_num = self.right // 2 + (self.right % 2 > 0)
                new_pair.init_with_ints(left_num, right_num)
                new_pair.parent = self
                self.right = new_pair
                has_split = True
        elif not has_split:
            has_split = self.right.split_once()
        return has_split

    def print(self):
        print("[", end='')
        if type(self.left) == Pair:
            self.left.print()
        else:
            print(self.left, end='')
        print(',', end='')
        if type(self.right) == Pair:
            self.right.print()
        else:
            print(self.right, end='')
        print(']', end='')

def add_two_pairs(p1, p2):
    p = Pair()
    p.init_with_left_and_right(p1,p2)
    return p

def init(lines):
    pairs = []
    for line in lines:
        pair = Pair()
        pair.init_from_string(line.strip())
        pairs.append(pair)
    return pairs

with open("input.txt", 'r') as f:
    lines = f.readlines()

pairs = init(lines)

highest_magnitude = 0

for i in range(len(pairs)):
    for k in range(len(pairs)):
        if i == k:
            continue
        else:
            current_pair = add_two_pairs(copy.deepcopy(pairs[i]), copy.deepcopy(pairs[k]))
            current_pair.explode()
            has_split = current_pair.split_once()
            while has_split:
                current_pair.explode()
                has_split = current_pair.split_once()
            magnitude = current_pair.get_magnitude()
            if magnitude > highest_magnitude:
                pairs[i].print()
                print()
                pairs[k].print()
                print()
                highest_magnitude = magnitude
print(highest_magnitude)