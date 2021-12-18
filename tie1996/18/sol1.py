import re

number_re = re.compile(r'\d+')

with open("input.txt", 'r') as f:
    lines = f.readlines()

def init_lines(lines):
    depths_per_line = []
    nums_per_line = []
    for line in lines:
        depth_count = 0
        depth = []
        nums = []
        for char in line.strip():
            if char == '[':
                depth_count += 1
            elif char == ']':
                depth_count -= 1
            elif number_re.match(char) is not None:
                nums.append(int(char))
                depth.append(depth_count)
        depths_per_line.append(depth)
        nums_per_line.append(nums)
    return depths_per_line, nums_per_line

def add_lines(nums1, nums2, depths1, depths2):
    nums1.extend(nums2)
    depths1.extend(depths2)
    depths1 = [depth + 1 for depth in depths1]
    return depths1, nums1

def check_and_split(nums, depths):

    has_split = True
    while has_split:
        new_nums = []
        new_depths = []
        has_split = False
        for i, num in enumerate(nums):
            if num > 9 and not has_split:
                left = num // 2
                right = num // 2 + (num % 2 > 0)
                new_nums.append(left)
                new_nums.append(right)
                new_depths.append(depths[i] + 1)
                new_depths.append(depths[i] + 1)
                has_split = True
            else:
                new_nums.append(num)
                new_depths.append(depths[i])
        nums = new_nums
        depths = new_depths
        if has_split:
            depths, nums = check_and_explode(nums, depths)
    return depths, nums

def check_and_explode(nums, depths):

    highest_depth = max(depths)

    if highest_depth < 5:
        #nothing to do
        return depths, nums
    else:
        while highest_depth > 4:
            new_depths = []
            new_nums = []
            skip = 0
            has_exploded = False
            for i, depth in enumerate(depths):
                if skip > 0:
                    skip -= 1
                    continue
                if depth == highest_depth and not has_exploded:
                    if depths[i + 1] != depth:
                        print("ERROR: a single nested element wants to explode")
                    else:
                        if i > 0 and i + 2 < len(nums):
                            #add to number before
                            new_nums[-1] += nums[i]
                            #append zero with depth -= 1
                            new_depths.append(depths[i] - 1)
                            new_nums.append(0)
                            #append next number added with the current one
                            new_nums.append(nums[i+1] + nums[i+2])
                            new_depths.append(depths[i+2])
                        elif i == 0 and i + 2 < len(nums):
                            new_depths.append(depths[i] - 1)
                            new_depths.append(depths[i+2])
                            new_nums.append(0)
                            new_nums.append(nums[i+1] + nums[i+2])
                        elif i > 0 and i + 2 == len(nums):
                            new_depths.append(depths[i] - 1)
                            new_nums[i - 1] += nums[i]
                            new_nums.append(0)
                        skip = 2
                        has_exploded = True
                else:
                    new_depths.append(depth)
                    new_nums.append(nums[i])
            depths = new_depths
            nums = new_nums
            highest_depth = max(depths)
    return depths, new_nums

def calculate_magnitude(nums, depths):
    highest_depth = max(depths)
    while highest_depth > 0:
        new_num = []
        new_depth = []
        skip = 0
        for i, depth in enumerate(depths):
            if skip > 0:
                skip -= 1
                continue
            if depth == highest_depth:
                new_num.append(nums[i]*3 + nums[i+1]*2)
                new_depth.append(depth - 1)
                skip = 1
            else:
                new_num.append(nums[i])
                new_depth.append(depth)
        nums = new_num
        depths = new_depth
        highest_depth = max(depths)
    return nums

depths_per_line, nums_per_line  = init_lines(lines)
current_nums = nums_per_line.pop(0)
current_depths = depths_per_line.pop(0)

while len(nums_per_line) > 0:
    next_nums = nums_per_line.pop(0)
    next_depths = depths_per_line.pop(0)
    current_depths, current_nums = add_lines(current_nums, next_nums, current_depths, next_depths)
    print("After addition: ")
    print(f"nums: {current_nums}")
    print(f"depths: {current_depths}")
    current_depths, current_nums = check_and_explode(current_nums, current_depths)
    print("After explode: ")
    print(f"nums: {current_nums}")
    print(f"depths: {current_depths}")
    current_depths, current_nums = check_and_split(current_nums, current_depths)
    print(current_nums)
    print(current_depths)

print(calculate_magnitude(current_nums, current_depths))
