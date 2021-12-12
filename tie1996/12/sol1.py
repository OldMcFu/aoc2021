graph = {}
with open("input.txt", 'r') as f:
    for line in f.readlines():
        f, t = line.strip().split("-")
        if f not in graph.keys():
            graph[f] = []
        if t not in graph.keys():
            graph[t] = []
        graph[f].append(t)
        graph[t].append(f)

for key in graph.keys():
    print(f"{key}: {graph[key]}")

# stack to track current path
current_path = []
valid_paths = 0

def visit_edges(edge):
    global valid_paths
    current_path.append(edge)
    if edge == 'end':
        print('-'.join(current_path))
        current_path.pop()
        valid_paths += 1
        return
    for node in graph[edge]:
        if node.islower() and node not in current_path:
            visit_edges(node)
        elif node.isupper():
            visit_edges(node)
    # every vertice for this edge is taken, pop from stack and return
    current_path.pop()
    return

visit_edges('start')
print(valid_paths)
