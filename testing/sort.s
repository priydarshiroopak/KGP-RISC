addi $3, 1          # BUBBLE SORT 
comp $30, $3
addi $1, 20     # array
xor $11, $11
addi $11, 10    # a1
sw $11, 0($1)
xor $11, $11
addi $11, 4    # a2
sw $11, 1($1)
xor $11, $11
addi $11, 100     # a3
sw $11, 2($1)
xor $11, $11
addi $11, 10     # a4
sw $11, 3($1)
xor $11, $11
addi $11, 25    # a5      
sw $11, 4($1)
xor $11, $11
addi $11, 75     # a6
sw $11, 5($1)
xor $11, $11
addi $11, 11    # a7
sw $11, 6($1)
xor $11, $11
addi $11, 4   # a8
sw $11, 7($1)
xor $11, $11
addi $11, -6    # a9
sw $11, 8($1)
xor $11, $11
addi $11, 22     # a10
sw $11, 9($1)
xor $15, $15
compi $15, 1
addi $2, 11      # i = n 
xor $16, $16
addi $16, 10
add $2, $30     #  LOOP1   # i=i-1
add $16, $30
bltz $16, 64
xor $3, $3      # j = 0
comp $4, $3     # LOOOP2
comp $17, $3
add $4, $2      # $4 = i - j
add $17, $16
bz $17, 63      # bz $4, endloop2
xor $6, $6
add $6, $1
add $6, $3      # $6 = ar + j
lw $7, 0($6)    # $7 = ar[j]
addi $6, 1      # $6 = ar + j + 1
lw $8, 0($6)    # $8 = ar[j+1]
addi $3, 1      # j = j + 1
comp $9, $7
add $9, $8      # $9 = ar[j+1] - ar[j]
bltz $9, 59     # if ar[j] > ar[j+1] goto swap
bltz $15, 43
sw $7, 0($6)    # ar[j+1]new = ar[j]old  #SWAP
add $6, $30     # $6 -= 1
sw $8, 0($6)   # ar[j]new = ar[j+1]old
bltz $15, 43
bltz $15, 39    # endloop2
lw $20, 0($1)   # endloop1
lw $21, 1($1)
lw $22, 2($1)
lw $23, 3($1)
lw $24, 4($1)
lw $25, 5($1)
lw $26, 6($1)
lw $27, 7($1)
lw $28, 8($1)
lw $29, 9($1)
xor $18, $18
add $18, $1
xor $19, $19
add $19, $18
add $19, $14
lw $1, 0($19)
bltz $15, 76
