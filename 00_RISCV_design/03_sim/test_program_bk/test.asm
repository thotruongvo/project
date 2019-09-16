#==============================================
#File name: test.asm
#Author: Tho Vo
#Description: test_program for RISC-V design
#==============================================

# Store data to DMEM 
#=========================
#NOP 
ADDI x1, x0, 3
ADDI x2, x0, 5
ADDI x3, x0, 9
ADDI x4, x0, 1
ADDI x5, x0, 23
ADDI x6, x0, 15
ADDI x7, x0, 5
ADDI x8, x0, 9
ADDI x9, x0, 13
ADDI x10, x0, 11
#NOP
SW x1, 1(x0)
SW x2, 2(x0)
SW x3, 3(x0)
SW x4, 4(x0)
SW x5, 5(x0)
SW x6, 6(x0)
SW x7, 7(x0)
SW x8, 8(x0)
SW x9, 9(x0)
SW x10, 10(x0)
#==========================
# Program test: 
#============================
# Load 10 elements in DMEM
#NOP
LW x1,1(x0)
LW x2,2(x0)
LW x3,3(x0)
LW x4,4(x0)
LW x5,5(x0)
LW x6,6(x0)
LW x7,7(x0)
LW x8,8(x0)
LW x9,9(x0)
LW x10,10(x0)

ADDI x11, x0, 11
ADDI x12, x0, 0
ADDI x13, x0, 0
LOOP:
ADDI x12, x12, 1
NOP
ADDI x13, x12, 0
LW x1,0(x12)
  LOOP1:
  ADDI x13, x13, 1
  LW x2,0(x13)
  BLT x1,x2, NEXT
  ADDI x1,x2,0
  NEXT:
  BLT x13, x11, LOOP1
  SW x1,10(x12) 
BLT x12, x11, LOOP

LW x1,11(x0)
LW x2,12(x0)
LW x3,13(x0)
LW x4,14(x0)
LW x5,15(x0)
LW x6,16(x0)
LW x7,17(x0)
LW x8,18(x0)
LW x9,19(x0)
LW x10,20(x0)