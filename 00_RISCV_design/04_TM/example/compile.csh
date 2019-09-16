#!/bin/csh -f

##############################################
# File name: compile.csh
# Author: Tho Vo
# Description: compile assembly code RISC-V 32
##############################################

if ($#argv != 1 ) then
  echo "ERROR: syntax error."
  echo "    Syntax: compile.csh file_name.as"
  echo "    Example: compile.csh factorial.as" 
  exit
endif

riscv-none-embed-as $1 -o data_out
riscv-none-embed-objdump -r -d -t data_out > tmp
set a = `grep -n "Disassembly" tmp | awk -F ":" '{print $1}'`

sed "1,${a}d" tmp | awk '{if (NF>2) print $2}' | grep -v "RISCV" > test.dat

echo "======================================"
echo "       Finish compile "
echo "======================================"
echo "Hex file is test.dat "
rm -rf tmp
