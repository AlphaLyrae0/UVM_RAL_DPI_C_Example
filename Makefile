 VIVADO_VER := /tools/Xilinx/Vivado/2022.2
 VLOG := $(VIVADO_VER)/bin/xvlog
 ELAB := $(VIVADO_VER)/bin/xelab
 SIM  := $(VIVADO_VER)/bin/xsim
 XSC  := $(VIVADO_VER)/bin/xsc

 TOP   := tb_top
#AXSIM := $(WORK).$(TOP)/axsim ./axsim.sh
#XSIMK := $(WORK).$(TOP)/xsimk
#AXSIM := ./xsim.dir/$(TOP).batch/axsim ./axsim.sh
 AXSIM := ./xsim.dir/$(TOP).batch/axsim
 XSIMK := ./xsim.dir/$(TOP).debug/xsimk

#export LD_LIBRARY_PATH := ${LD_LIBRARY_PATH}:${VIVADO_VER}/lib/lnx64.o:${VIVADO_VER}/lib/lnx64.o/Default

 TEST_NAME := c_ral_test

.PHONY : build build_c run all run_% gui_%
all : run_example_ral_test run_c_ral_test run_unite_test
run_% : 
	make run TEST_NAME=$*
gui_% : 
	make gui TEST_NAME=$*
run : $(AXSIM) $(DPI_SO)
	./axsim.sh          --testplusarg "UVM_TESTNAME=$(TEST_NAME)"
	mv xsim.log xsim_$(TEST_NAME).log
#	$(AXSIM)            --testplusarg "UVM_TESTNAME=$(TEST_NAME)" --log $(TEST_NAME).log
gui : $(XSIMK) $(DPI_SO)
	$(SIM) $(TOP).debug --testplusarg "UVM_TESTNAME=$(TEST_NAME)" --log gui_$(TEST_NAME).log --gui &
build_a     :
	make -B $(AXSIM)
build_d     :
	make -B $(XSIMK)
build_c   :
	make -B $(DPI_SO)

SRC_FILES += ./DUT/aiueo.sv
SRC_FILES += ./My_UVM/my_uvm_pkg.sv
SRC_FILES += ./RAL/aiueo_ral_pkg.sv
SRC_FILES += ./Agent/my_agent_pkg.sv
SRC_FILES += ./Agent/my_busif.sv
SRC_FILES += ./Env/my_env_pkg.sv
SRC_FILES += ./Seq/my_sequence_pkg.sv
SRC_FILES += ./Test/test_lib_pkg.sv
SRC_FILES += ./TB/tb_top.sv

INC_FILES += $(shell ls ./Agent/*.svh)
INC_FILES += $(shell ls ./Env/*.svh)
INC_FILES += $(shell ls ./Test/*.svh)
INC_FILES += $(shell ls ./Agent/*.svh)

INC_OPT += --include ./Agent
INC_OPT += --include ./Env
INC_OPT += --include ./Seq
INC_OPT += --include ./Test

DPI_SO := ./xsim.dir/work/xsc/dpi.so
$(DPI_SO) : ./C/C_reg_sequence.cpp ./dpi.h
	$(XSC) $< 
#./dpi_lib.so : ./C/C_reg_sequence.cpp ./C/dpi.h
#	$(XSC) $< -o $@ 
#	g++ -m32 -fPIC -shared -o dpi_lib.so $^

dpi.h :
	$(VLOG) -incr -L uvm $(INC_OPT) -sv $(SRC_FILES)
	$(ELAB) -incr -L uvm $(TOP) -dpiheader dpi.h 

$(AXSIM) : $(SRC_FILES) $(INC_FILES)
	make $(DPI_SO)
	$(VLOG) -incr -L uvm $(INC_OPT) -sv $(SRC_FILES)
	$(ELAB) -incr -L uvm $(TOP) -timescale 1ns/1ps -sv_lib dpi -standalone -snapshot $(TOP).batch

$(XSIMK) : $(SRC_FILES) $(INC_FILES)
	make $(DPI_SO)
	$(VLOG) -incr -L uvm $(INC_OPT) -sv $(SRC_FILES)
	$(ELAB) -incr -L uvm $(TOP) -timescale 1ns/1ps -sv_lib dpi -snapshot $(TOP).debug -debug all
#	$(ELAB) -incr -L uvm $(TOP) -timescale 1ns/1ps -sv_lib dpi -snapshot $(TOP).debug -debug all -dpiheader dpi.h


.PHONY: clean
clean:
	rm -fr xsim.dir .Xil axsim.sh dpi.h dpi_lib.so 
	rm -fr *.pb
	rm -rf *.log *.jou *.str
	rm -fr *.vcd *.wdb
