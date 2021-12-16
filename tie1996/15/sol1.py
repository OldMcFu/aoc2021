import numpy

class Node:
    def __init__(self, risk_level: int, pos: tuple):
        self.distance = numpy.inf
        self.predecessor = None
        self.risk_level = risk_level
        self.pos = pos

    def update_neighbours(self, nodes, boundarie):
        for i in [1]:
            for set_x in [True, False]:
                x = self.pos[0] + i if set_x else self.pos[0]
                y = self.pos[1] + i if not set_x else self.pos[1]
                if x >= 0 and y >= 0 and x <= boundarie and y <= boundarie:
                    if nodes[x][y].distance != numpy.inf:
                        if self.distance + nodes[x][y].risk_level < nodes[x][y].distance:
                            nodes[x][y].distance = self.distance + nodes[x][y].risk_level
                            nodes[x][y].predecessor = self
                    else:
                        nodes[x][y].distance = self.distance + nodes[x][y].risk_level
                        nodes[x][y].predecessor = self

with open("input.txt", 'r') as f:
    risk_level = [list(map(int,list(line.strip()))) for line in f.readlines()]
nodes = [[Node(level, (i,k)) for k, level in enumerate(col)] for i, col in enumerate(risk_level)]
nodes[0][0].distance = 0
current_node = nodes[0][0]
Q = []
for col in nodes:
    for node in col:
        Q.append(node)
end_pos = (len(nodes[:][0]) - 1, len(nodes[0][:]) - 1)
end_node = nodes[end_pos[0]][end_pos[1]]
current_node.update_neighbours(nodes, end_pos[0])

while len(Q) != 0:
    # get node with lowest distance
    min_dist = numpy.inf
    index = 0
    for i, node in enumerate(Q):
        if node.distance < min_dist:
            min_dist = node.distance
            index = i
    next_node = Q.pop(index)

    if next_node == end_node:
        print("FINISH")
        print(end_node.distance)
        test = numpy.zeros((end_pos[0]+1,end_pos[0]+1))
        for row in nodes:
            for node in row:
                test[node.pos[0], node.pos[1]] = node.distance
        print(test)
        break
    next_node.update_neighbours(nodes, end_pos[0])
    current_node = next_node
