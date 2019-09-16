#!/bin/csh -f
riscv-none-embed-as $1 -o hello
riscv-none-embed-objdump -r -d -t hello > tmp
set a = `grep -n "Disassembly" tmp | awk -F ":" '{print $1}'`

sed "1,${a}d" tmp | awk '{if (NF>2) print $2}' | grep -v "RISCV" > test.dat
rm -rf hello tmp
