import numpy

def calc_score(num, board, marked_board):
    zero_indices = numpy.where(marked_board == 0)
    zero_sum = numpy.sum(board[zero_indices])
    return zero_sum*num

def check_board(bingo_nums, board):
    check_board = numpy.zeros((5,5), dtype=bool)
    print(board)
    for i, num in enumerate(bingo_nums):
        #print("Calling number: ", num)
        index = numpy.where(board == num)
        #print(index)
        check_board[index] = True
        row = numpy.where(check_board.all(axis=1))[0]
        if numpy.shape(row)[0] != 0:
            print("Bingo")
            return i, calc_score(num, board, check_board)
        col = numpy.where(check_board.all(axis=0))[0]
        if numpy.shape(col)[0] != 0:
            print("Bingo")
            return i, calc_score(num, board, check_board)

numbers = []
boards = []
with open("input.txt", 'r') as f: 
    lines = f.readlines()
    board = []
    for i, line in enumerate(lines):
        if i == 0:
            numbers = list(map(int, line.split(",")))
            print(numbers)
            continue
        if ((i-1) % 6) == 0:
            if len(board) != 0:
                boards.append(board.copy())
            board = []
            continue
        board.append(list(map(int, line.split(" "))))
    boards.append(board.copy())

won_after = []
score = []

for board in boards:
    ret = check_board(numbers, numpy.array(board))
    if ret is not None:
        won_after.append(ret[0])
        score.append(ret[1])
maximum_index = numpy.argmax(numpy.array(won_after))
print(maximum_index)
losing_score = numpy.array(score)[maximum_index]
print(losing_score)