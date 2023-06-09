 VIVADO_VER := /tools/Xilinx/Vivado/2022.2
 VLOG := $(VIVADO_VER)/bin/xvlog
 ELAB := $(VIVADO_VER)/bin/xelab
 SIM  := $(VIVADO_VER)/bin/xsim
 XSC  := $(VIVADO_VER)/bin/xsc

 TOP   := tb_top
 WORK  := ./xsim.dir/work
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
run : $(AXSIM) dpi_lib.so
	./axsim.sh          --testplusarg "UVM_TESTNAME=$(TEST_NAME)"
	mv xsim.log xsim_$(TEST_NAME).log
#	$(AXSIM)            --testplusarg "UVM_TESTNAME=$(TEST_NAME)" --log $(TEST_NAME).log
gui : $(XSIMK) dpi_lib.so
	$(SIM) $(TOP).debug --testplusarg "UVM_TESTNAME=$(TEST_NAME)" --log gui_$(TEST_NAME).log --gui &
build     :
	make -B $(AXSIM)
build_c   :
	make -B ./dpi_lib.so

COMPILE_FILES := $(WORK)/aiueo.sdb
COMPILE_FILES += $(WORK)/my_uvm_pkg.sdb
COMPILE_FILES += $(WORK)/aiueo_ral_pkg.sdb
COMPILE_FILES += $(WORK)/my_agent_pkg.sdb
COMPILE_FILES += $(WORK)/my_env_pkg.sdb
COMPILE_FILES += $(WORK)/my_sequence_pkg.sdb
COMPILE_FILES += $(WORK)/test_lib_pkg.sdb
COMPILE_FILES += $(WORK)/my_busif.sdb
COMPILE_FILES += $(WORK)/tb_top.sdb

$(AXSIM) : $(COMPILE_FILES)
	cp -f C/dpi.h ./
	make dpi_lib.so
	$(ELAB) $(TOP) -L uvm -timescale 1ns/1ps -sv_lib dpi_lib -dpiheader dpi.h -standalone -snapshot $(TOP).batch
#$(TARGET) : ./dpi_lib.so
#	$(ELAB) $(TOP) -L uvm -timescale 1ns/1ps -sv_lib dpi_lib -standalone
#	$(XSC) C/dpi.cpp -o dpi_lib.so

$(XSIMK) : $(COMPILE_FILES)
	cp -f C/dpi.h ./
	make dpi_lib.so
	$(ELAB) $(TOP) -L uvm -timescale 1ns/1ps -sv_lib dpi_lib -dpiheader dpi.h -debug all -snapshot $(TOP).debug

./dpi_lib.so : ./C/C_reg_sequence.cpp ./dpi.h
	$(XSC) $< -o $@ 
#	g++ -m32 -fPIC -shared -o dpi_lib.so $^
#--------------------------------------------------------------------------
$(WORK)/aiueo.sdb            : ./DUT/aiueo.sv
	$(VLOG) -sv $< -L uvm

$(WORK)/my_uvm_pkg.sdb       : My_UVM/my_uvm_pkg.sv
	$(VLOG) -sv $< -L uvm

#--------------- RAL -----------------------------------------
$(WORK)/aiueo_ral_pkg.sdb    : ./RAL/aiueo_ral_pkg.sv
	$(VLOG) -sv $< -L uvm --include ../rggen-sv-ral
#--------------------------------------------------------------

#--------------- Agent----------------------------------------
$(WORK)/my_agent_pkg.sdb     : ./Agent/my_agent_pkg.sv $(shell ls ./Agent/*.svh)
	$(VLOG) -sv $< -L uvm --include ./Agent
#--------------------------------------------------------------

#--------------- Env -----------------------------------------
$(WORK)/my_env_pkg.sdb       : ./Env/my_env_pkg.sv $(shell ls ./Env/*.svh)
	make $(WORK)/my_agent_pkg.sdb
	$(VLOG) -sv $< -L uvm --include ./Env
#--------------------------------------------------------------

#--------------- Sequence -------------------------------------
$(WORK)/my_sequence_pkg.sdb  : ./Seq/my_sequence_pkg.sv
	make $(WORK)/my_uvm_pkg.sdb
	make $(WORK)/my_agent_pkg.sdb
	$(VLOG) -sv $< -L uvm --include ./Seq
#--------------------------------------------------------------

#--------------- Test -----------------------------------------
$(WORK)/test_lib_pkg.sdb      : ./Test/test_lib_pkg.sv $(shell ls./Test/*.svh)
	make $(WORK)/my_uvm_pkg.sdb
	make $(WORK)/aiueo_ral_pkg.sdb
	make $(WORK)/my_env_pkg.sdb
	make $(WORK)/my_sequence_pkg.sdb
	$(VLOG) -sv $< -L uvm --include ./Test
#--------------------------------------------------------------

$(WORK)/my_busif.sdb          : ./Agent/my_busif.sv
	$(VLOG) -sv $< -L uvm

$(WORK)/tb_top.sdb            : ./TB/tb_top.sv
	make $(WORK)/test_lib_pkg.sdb
	$(VLOG) -sv $< -L uvm

.PHONY: clean
clean:
	rm -fr xsim.dir .Xil axsim.sh dpi.h dpi_lib.so 
	rm -fr *.pb
	rm -rf *.log *.jou *.str
	rm -fr *.vcd *.wdb
