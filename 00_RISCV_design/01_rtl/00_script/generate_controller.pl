#!/bin/perl -w
################################################
# File name: generate_controller.pl
# Author: Tho Vo
# Date: 27 Aug, 2019
# Description: generate controller for RISC-V cpu
################################################

#==========================================
# Define variable
#==========================================
my $line;
my $tmp_line;
my $input_file = "./controller.txt";
my @file_array;
my @tmp_array;
my @tmp_array_0;
my @bit_width;
my $output_file = "../riscv_controller.v";
my $i;
my $j;

#==========================================
# Read file and store to array
#==========================================
open (INPUT,"<$input_file") or die "Could not open csv file";
	for $tmp_line (<INPUT>) {
		chomp($tmp_line);
		push(@file_array,$tmp_line);
	}
close INPUT;

#==========================================
# Ouput file
#==========================================
open (OUTPUT,">$output_file") || die "Could not create file";
	print OUTPUT "//====================================\n";
	print OUTPUT "//File name: riscv_controller.v\n";
	print OUTPUT "//Author: Tho Vo\n";
	print OUTPUT "//Date: 27 Aug, 2019\n";
	print OUTPUT "//Description: Controller for RISC-V CPU\n";
	print OUTPUT "//====================================\n";

	##############################################
	# Define instruction
	##############################################
	for ($i =	2; $i < scalar(@file_array); $i = $i+1) {
		@tmp_array = split(" ",$file_array[$i]);
		print OUTPUT "`define $tmp_array[2] \t 32'b?$tmp_array[3]???????????????$tmp_array[4]?????$tmp_array[5]11\n";
	}

	print OUTPUT "module riscv_controller(\n";
	print OUTPUT "inst,\n";
	## output port
	@tmp_array = split(" ",$file_array[0]);
	@bit_width = split(" ",$file_array[1]);
	for($i = 6; $i < scalar(@tmp_array); $i = $i+1) {
		if ($i == scalar(@tmp_array) - 1) {
			print OUTPUT "$tmp_array[$i]\n";
		} else {
			print OUTPUT "$tmp_array[$i],\n";
		}
	}
	print OUTPUT ");\n";

	###################################
	# Port define
	###################################
	print OUTPUT "\tinput [31:0] inst;\n";
	print OUTPUT "\tinput  BrEq;\n";
	print OUTPUT "\tinput  BrLT;\n";
	for($i = 8; $i < scalar(@tmp_array); $i = $i+1) {
		if ($bit_width[$i] == 1) {
			print OUTPUT "\toutput $tmp_array[$i];\n";
			print OUTPUT "\treg $tmp_array[$i]_reg;\n";
		} else {
			my $a = $bit_width[$i] - 1;
			print OUTPUT "\toutput \[$a\:0\] $tmp_array[$i];\n";
			print OUTPUT "\treg \[$a\:0\] $tmp_array[$i]_reg;\n";
		}
	}

	####################################
	# Always block
	####################################
	print OUTPUT "\t always @ (*) begin\n";

	print OUTPUT "\t\t case(inst)\n";
	@tmp_array_0 = split(" ",$file_array[0]);
	
	########################
	# print control signal of instructions
	#########################
	
	for ($i = 2; $i < scalar(@file_array); $i=$i+1) {
		@tmp_array = split(" ",$file_array[$i]);
		print OUTPUT "\t\t\t `$tmp_array[2]: begin\n";

		if ($tmp_array[2] eq "BEQ") {
			print OUTPUT "\t\t\t\t if (BrEq == 1'b1) begin\n";
			print OUTPUT "\t\t\t\t\t $tmp_array_0[8]_reg = 1'b1;\n";
			for ($j = 9; $j < scalar(@tmp_array); $j = $j + 1) {
        print OUTPUT "\t\t\t\t\t $tmp_array_0[$j]_reg = $tmp_array[$j];\n";
      }
			print OUTPUT "\t\t\t\t end\n";
			print OUTPUT "\t\t\t\t else begin\n";
			print OUTPUT "\t\t\t\t\t $tmp_array_0[8]_reg = 1'b0;\n";
			for ($j = 9; $j < scalar(@tmp_array); $j = $j + 1) {
        print OUTPUT "\t\t\t\t\t $tmp_array_0[$j]_reg = $tmp_array[$j];\n";
      }
			print OUTPUT "\t\t\t\t end\n";
##################################################			
		} elsif ($tmp_array[2] eq "BNE") {
			print OUTPUT "\t\t\t\t if (BrEq == 1'b0) begin\n";
			print OUTPUT "\t\t\t\t\t $tmp_array_0[8]_reg = 1'b1;\n";
			for ($j = 9; $j < scalar(@tmp_array); $j = $j + 1) {
        print OUTPUT "\t\t\t\t\t $tmp_array_0[$j]_reg = $tmp_array[$j];\n";
      }
			print OUTPUT "\t\t\t\t end\n";
			print OUTPUT "\t\t\t\t else begin\n";
			print OUTPUT "\t\t\t\t\t $tmp_array_0[8]_reg = 1'b0;\n";
			for ($j = 9; $j < scalar(@tmp_array); $j = $j + 1) {
        print OUTPUT "\t\t\t\t\t $tmp_array_0[$j]_reg = $tmp_array[$j];\n";
      }
			print OUTPUT "\t\t\t\t end\n";
##################################################################
		} elsif (($tmp_array[2] eq "BLT") || ($tmp_array[2] eq "BLTU")) {
			print OUTPUT "\t\t\t\t if (BrLT == 1'b0) begin\n";
			print OUTPUT "\t\t\t\t\t $tmp_array_0[8]_reg = 1'b1;\n";
			for ($j = 9; $j < scalar(@tmp_array); $j = $j + 1) {
        print OUTPUT "\t\t\t\t\t $tmp_array_0[$j]_reg = $tmp_array[$j];\n";
      }
			print OUTPUT "\t\t\t\t end\n";
			print OUTPUT "\t\t\t\t else begin\n";
			print OUTPUT "\t\t\t\t\t $tmp_array_0[8]_reg = 1'b0;\n";
			for ($j = 9; $j < scalar(@tmp_array); $j = $j + 1) {
        print OUTPUT "\t\t\t\t\t $tmp_array_0[$j]_reg = $tmp_array[$j];\n";
      }
			print OUTPUT "\t\t\t\t end\n";
################################################################
		} elsif (($tmp_array[2] eq "BGE") || ($tmp_array[2] eq "BGEU")) {
			print OUTPUT "\t\t\t\t if ((BrEq == 1'b1) || ((BrLT == 1'b0) && (BrEq == 0))) begin\n";
			print OUTPUT "\t\t\t\t\t $tmp_array_0[8]_reg = 1'b1;\n";
			for ($j = 9; $j < scalar(@tmp_array); $j = $j + 1) {
        print OUTPUT "\t\t\t\t\t $tmp_array_0[$j]_reg = $tmp_array[$j];\n";
      }
			print OUTPUT "\t\t\t\t end\n";
			print OUTPUT "\t\t\t\t else begin\n";
			print OUTPUT "\t\t\t\t\t $tmp_array_0[8]_reg = 1'b0;\n";
			for ($j = 9; $j < scalar(@tmp_array); $j = $j + 1) {
        print OUTPUT "\t\t\t\t\t $tmp_array_0[$j]_reg = $tmp_array[$j];\n";
      }
			print OUTPUT "\t\t\t\t end\n";
			
###############################################################
	  } else {
			for ($j = 8; $j < scalar(@tmp_array); $j = $j + 1) {
				print OUTPUT "\t\t\t\t $tmp_array_0[$j]_reg = $tmp_array[$j];\n";
			}
		}

	#=====================================
		print OUTPUT "\t\t\t  end\n";
	}

	#################################
	# Default
	#################################
	print OUTPUT "\t\t\tdefault: begin\n";
    for ($j = 8; $j < scalar(@tmp_array); $j = $j + 1) {
      print OUTPUT "\t\t\t\t $tmp_array_0[$j]_reg = 32'hz;\n";
    }
	print OUTPUT "\t\t\tend\n";
	print OUTPUT "\t\t endcase\n";
	print OUTPUT " end\n";

    for ($j = 8; $j < scalar(@tmp_array); $j = $j + 1) {
      print OUTPUT "assign $tmp_array_0[$j] = $tmp_array_0[$j]_reg;\n";
	}

	print OUTPUT "endmodule";	
close OUTPUT;




