import numpy

class Node:

    q_index = 0

    def __init__(self, risk_level: int, pos: tuple):
        self.distance = numpy.inf
        self.predecessor = None
        self.risk_level = risk_level
        self.pos = pos

    def update_neighbours(self, nodes, boundarie, Q):
        for i in [-1, 1]:
            for set_x in [True, False]:
                x = self.pos[0] + i if set_x else self.pos[0]
                y = self.pos[1] + i if not set_x else self.pos[1]
                if x >= 0 and y >= 0 and x <= boundarie and y <= boundarie:
                    if nodes[x][y].distance != numpy.inf:
                        if self.distance + nodes[x][y].risk_level < nodes[x][y].distance:
                            nodes[x][y].distance = self.distance + nodes[x][y].risk_level
                            nodes[x][y].predecessor = self
                            self.change_position_in_Q(nodes[x][y], Q)
                    else:
                        nodes[x][y].distance = self.distance + nodes[x][y].risk_level
                        nodes[x][y].predecessor = self
                        Node.change_position_in_Q(nodes[x][y], Q)
    
    @staticmethod
    def change_position_in_Q(node, Q):
        try:
            index = Q.index(node)
            Q.pop(index)
            for i, n in enumerate(Q):
                if n.distance > node.distance:
                    Q.insert(i, node)
                    #node.q
                    break
        except ValueError:
            pass
        

    def get_field(self, field_size):
        field_x = self.pos[0] // field_size
        field_y = self.pos[1] // field_size
        return (field_x, field_y)

with open("input.txt", 'r') as f:
    risk_level = numpy.array([list(map(int,list(line.strip()))) for line in f.readlines()])

height = numpy.shape(risk_level)[0]
width = numpy.shape(risk_level)[1]

cave = numpy.zeros((height*5, width*5), dtype=int)

for i in range(5):
    for k in range(5):
        cave[i*height:i*height+height, k*width:k*width+width] = numpy.where(risk_level + i + k <= 9, risk_level + i + k, (risk_level + i + k) % 9)

numpy.savetxt("cave.txt", cave, fmt="%i")

nodes = [[Node(level, (i,k)) for k, level in enumerate(col)] for i, col in enumerate(cave)]
nodes[0][0].distance = 0
current_node = nodes[0][0]
Q = []
for i, col in enumerate(nodes):
    for k, node in enumerate(col):
        Q.append(node)
        node.q_index = i*len(col) + k

end_pos = (len(nodes[:][0]) - 1, len(nodes[0][:]) - 1)
end_node = nodes[end_pos[0]][end_pos[1]]
current_node.update_neighbours(nodes, end_pos[0], Q)
field_values = [[0, 1, 2, 3, 4],
                [1, 2, 3, 4, 5],
                [2, 3, 4, 5, 6],
                [3, 4, 5, 6, 7],
                [4, 5, 6, 7, 8]]
known_fields = [(0,0), (4,4)]

def delete_similar_fields(next_node_field, _Q, field_size):
    Q = []
    x, y = next_node_field
    field_value = field_values[x][y]
    #print(next_node_field)
    #print(f"deleting fields with value: {field_value}")
    #print("length before deleting: " + str(len(_Q)))
    for node in _Q:
        node_field = node.get_field(field_size)
        node_x, node_y = node_field
        if field_value == field_values[node_x][node_y] and node_field != next_node_field:
            continue
        else:
            Q.append(node)
    #print("length after deleting: " + str(len(Q)))
    return Q

while len(Q) != 0:
    # get node with lowest distance
    min_dist = numpy.inf
    index = 0
    """ for i, node in enumerate(Q):
        if node.distance < min_dist:
            min_dist = node.distance
            index = i """
    next_node = Q.pop(0)
    print(next_node.pos)
    """ next_node_field = next_node.get_field(height)
    
    if next_node_field not in known_fields:
        Q = delete_similar_fields(next_node_field, Q, height)
        known_fields.append(next_node_field) """
    if next_node == end_node:
        print("FINISH")
        print(end_node.distance)
        test = numpy.zeros((end_pos[0]+1,end_pos[0]+1))
        for row in nodes:
            for node in row:
                test[node.pos[0], node.pos[1]] = node.distance
        test = numpy.where(test == numpy.inf, 999, test)
        numpy.savetxt("test.txt", test, fmt="%03i")
        print(test)
        break
    next_node.update_neighbours(nodes, end_pos[0], Q)
    current_node = next_node
