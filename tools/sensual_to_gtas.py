import os
import pathlib

def get_gtas_representation(line):
    s = ""
    if ('>' in line):
        s += "R"
    if ('<' in line):
        s += "L"
    if ('^' in line):
        s += "U"
    if ('+' in line):
        s += "D"
    if ('Z' in line):
        s += "Z"
    return s

def gtas_are_equal(a, b):
    return sorted(a) == sorted(b)

for file in pathlib.Path().glob("TAS_*.txt"):
    tup = str.partition(file.name, " ")
    id = tup[0]
    rest = tup[2]

    levelType = "L" if id == "TAS_Level" else "H"
    num = str.partition(rest, "_")[0]

    frameCount = 0
    with file.open() as f:
        lines = f.readlines()
        
        finished_file = ""
        i = 0
        framehold_acc = 1
        last_gtas = None
        while (i < len(lines)):
            is_last = i == len(lines) - 1
            cur_gtas = get_gtas_representation(lines[i])
            i += 1
            if last_gtas != None and gtas_are_equal(last_gtas, cur_gtas):
                framehold_acc += 1
                if is_last:
                    frameCount += framehold_acc
                    finished_file += f"{last_gtas},{framehold_acc}\n"
                    break
                continue
            else:
                frameCount += framehold_acc
                # pop to file
                if framehold_acc > 1:
                    finished_file += f"{last_gtas},{framehold_acc}\n"
                elif last_gtas != None:
                    finished_file += f"{last_gtas}\n"
                framehold_acc = 1
            last_gtas = cur_gtas
        
        name = f"{levelType}{num}_{frameCount}.gtas"
        with open(name, 'x') as f:
            f.write(finished_file)