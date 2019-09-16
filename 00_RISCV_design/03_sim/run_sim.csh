#!/bin/csh -f

set TM_DIR = "../04_TM"

echo "============================================"
echo "              START SIMULATION               "
echo "============================================"

foreach a (`cat tm.list | grep -v "^\/\/" | grep -v "\s^\/\/" | awk '{print $1}'`)
  echo "============================================"
  echo "              Pattern: $a                   "
  echo "============================================"
  if (-d $a) then
    if (-d ${a}_bk) then
      rm -rf ${a}_bk
    endif
    cp -a ./$a/. ${a}_bk
    rm -rf ./$a/*
  else
    mkdir $a
  endif
  cp -a $TM_DIR/$a/. ./$a
  cp -f ../01_rtl/riscv_imem.v ./$a
  sed -e "s#LINK_MEMORY#../test.dat#g" -i $a/riscv_imem.v
  cd $a
  cp -f ../../02_tb/test_run.tcl ./
  vsim -c -do ./test_run.tcl
  cd ..
end
