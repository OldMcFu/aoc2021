import math
version_sum = 0

functions = [lambda x: sum(x),
             lambda x: math.prod(x),
             lambda x: min(x),
             lambda x: max(x),
             lambda x: None,
             lambda x: int(x[0] > x[1]),
             lambda x: int(x[0] < x[1]),
             lambda x: int(x[0] == x[1])]

def to_binary_string(packet_string):
    ret = ""
    for char in packet_string:
        ret = ret + "{0:04b}".format(int(char, base=16))
    return ret

with open("input.txt", 'r') as f:
    packet_string = f.readline().strip()

packet_string = to_binary_string(packet_string)


def decode_packet(packet_string):
    global version_sum
    
    version = int(packet_string[0:3], base=2)
    typ = int(packet_string[3:6], base=2)
    version_sum += version

    if typ != 4:
        length_mode = packet_string[6]
        if length_mode == '1':
            number_of_subpackets = int(packet_string[7:7+11], base=2)
            next_packet_start = 18
            values = []
            for i in range(number_of_subpackets):
                subpacket_length, value = decode_packet(packet_string[next_packet_start::])
                values.append(value)
                next_packet_start += subpacket_length
            result = functions[typ](values)
            return next_packet_start, result
        else:
            number_of_subpacket_bits = int(packet_string[7:7+15], base=2)
            next_packet_start = 22
            values = []
            while number_of_subpacket_bits != 0:
                subpacket_length, value = decode_packet(packet_string[next_packet_start::])
                values.append(value)
                next_packet_start += subpacket_length
                number_of_subpacket_bits -= subpacket_length
            result = functions[typ](values)
            return next_packet_start, result
    else:
        start = 6
        count = 0
        value = ''
        while packet_string[start] == '1':
            count += 5
            value += packet_string[start+1:start+5]
            start += 5
        count += 5
        value += packet_string[start+1:start+5]
        value = int(value, base = 2)
        return (count + 6), value

print("Result " + str(decode_packet(packet_string)[1]))