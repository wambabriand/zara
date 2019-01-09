


.PHONY: compile_all ,recompile

compile_all :
	vlog +acc ../src/MCE.sv
	vlog +acc ../src/MUX.sv
	vlog +acc ../src/MED.sv
	vlog +acc ../src/MEDIAN.sv
	vlog +acc ../src/MCE_tb.sv
	vlog +acc ../src/MED_tb.sv
	vlog +acc ../src/MEDIAN_tb.sv

recompile:
	vlog +acc ../src/MEDIAN.sv
	vlog +acc ../src/MEDIAN_IMAGE_tb.sv
