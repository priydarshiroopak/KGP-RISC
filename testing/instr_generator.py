import sys
import re
import json

REGDICT = {}
INSTRUCTION_DICT = {}
OUTPUT_FILE = open("sort.coe", "w")

def two_comp(num,nbits):
    '''
    gives n-bit long two complement representation of number
    '''
    if num>=0:
        return f"{num:0{nbits}b}"
    else:
        return f"{((1<<nbits)+num):0{nbits}b}"

def spit_line(line):
    try:
        # print(line)
        opcode=INSTRUCTION_DICT[line[0]][0]
        opc=int(opcode,2)
        # print(opc)
        if opc==1:      # add, and, xor, comp, diff
            if len(line)!=3:
                print(f"error in line {line}")
                return
            else:
                rs=f"{REGDICT[line[1]]:05b}"
                rt=f"{REGDICT[line[2]]:05b}"
                extra=f"{0:011b}"
                funct=f"{INSTRUCTION_DICT[line[0]][-1]}"
                print(f"{opcode}{rs}{rt}{extra}{funct},", file = OUTPUT_FILE)
        elif opc==2 :   # addi, compi
            if len(line)!=3:
                print(f"error in line {line}")
                return
            else:
                rs=f"{REGDICT[line[1]]:05b}"
                imm_dec=int(line[2])
                imm=two_comp(imm_dec,16)
                funct=f"{INSTRUCTION_DICT[line[0]][-1]}"
                print(f"{opcode}{rs}{imm}{funct},", file = OUTPUT_FILE)
        elif opc==3:    # sll, srl, sra
            if len(line) != 3:
                print(f"error in line {line}")
                return
            else:
                rs=f"{REGDICT[line[1]]:05b}"
                funct=f"{INSTRUCTION_DICT[line[0]][-1]}"
                imm_dec=abs(int(line[2]))
                imm=two_comp(imm_dec,16)
                print(f"{opcode}{rs}{imm}{funct},", file = OUTPUT_FILE)
        elif opc==4:    # sllv, srlv, srav
            if len(line) != 3:
                print(f"error in line {line}")
                return
            else:
                rs=f"{REGDICT[line[1]]:05b}"
                rt=f"{REGDICT[line[2]]:05b}"
                extra=f"{0:011b}"
                funct=f"{INSTRUCTION_DICT[line[0]][-1]}"
                print(f"{opcode}{rs}{rt}{extra}{funct},", file = OUTPUT_FILE)
        elif opc==5 or opc==6:      # lw, sw
            if len(line)!=4:
                print(f"error in line {line}")
                return
            else:
                rs=f"{REGDICT[line[3]]:05b}"
                rt=f"{REGDICT[line[1]]:05b}"
                imm_dec=abs(int(line[2]))
                imm=two_comp(imm_dec,16)
                print(f"{opcode}{rs}{rt}{imm},", file = OUTPUT_FILE)
        elif opc==8 :       # b, bcy, bncy
            if len(line)!=2:
                print(f"error in line {line}")
                return
            else:
                funct = f"{INSTRUCTION_DICT[line[0]][-1]}"
                unused_reg=f"{0:05b}"
                imm_dec=abs(int(line[1]))
                imm=two_comp(imm_dec,16)
                print(f"{opcode}{unused_reg}{imm}{funct},", file = OUTPUT_FILE)
        elif opc==9:        # br
            if len(line)!=2:
                print(f"error in line {line}")
                return
            else:
                funct = f"{INSTRUCTION_DICT[line[0]][-1]}"
                rs=f"{REGDICT[line[1]]:05b}"
                addr=f"{0:016b}"
                print(f"{opcode}{rs}{addr}{funct},", file = OUTPUT_FILE)
        elif opc==10:       # bl
            if len(line)!=2:
                print(f"error in line {line}")
                return
            else:
                funct = f"{INSTRUCTION_DICT[line[0]][-1]}"
                unused_reg=f"{0:05b}"
                imm_dec=abs(int(line[1]))
                imm=two_comp(imm_dec,16)
                print(f"{opcode}{unused_reg}{imm}{funct},", file = OUTPUT_FILE)
        elif opc==11:       # bltz, bz, bnz
            if len(line)!=3:
                print(f"error in line {line}")
                return
            else:
                funct = f"{INSTRUCTION_DICT[line[0]][-1]}"
                rs=f"{REGDICT[line[1]]:05b}"
                imm_dec=abs(int(line[2]))
                imm=two_comp(imm_dec,16)
                print(f"{opcode}{rs}{imm}{funct},", file = OUTPUT_FILE)
    except:
        print(f"error in line {line}")


def bin_comm(string):
    string = re.sub(re.compile("/'''.*?\'''", re.DOTALL), "", string)
    string = re.sub(re.compile("#.*?\n"), "", string)
    return string


def process(filename):
    print("memory_initialization_radix=2;", file = OUTPUT_FILE)
    print("memory_initialization_vector=", file = OUTPUT_FILE)
    print(f"{0:032b}", file = OUTPUT_FILE)
    with open(filename, 'r') as f:
        lines = f.readlines()
        for line in lines:
            line.strip()
            line = bin_comm(line)
            
            line = line.replace(',',' ').replace(')',' ').replace('(',' ').split()
            if len(line):
                spit_line(line)
    print(f"{0:032b};", file = OUTPUT_FILE)

if __name__ == '__main__':
    with open('instruction.json', 'r') as f:
        INSTRUCTION_DICT = json.load(f)
    with open('register.json', 'r') as f:
        REGDICT = json.load(f)
    process("sort.s")