 VIVADO_DIR := /tools/Xilinx/Vivado/2022.2/bin
 VLOG := $(VIVADO_DIR)/xvlog
 ELAB := $(VIVADO_DIR)/xelab
 SIM  := $(VIVADO_DIR)/xsim
 XSC  := $(VIVADO_DIR)/xsc

 TOP   := tb_top
 WORK  := ./xsim.dir/work
#AXSIM := $(WORK).$(TOP)/axsim ./axsim.sh
#XSIMK := $(WORK).$(TOP)/xsimk
 AXSIM := ./xsim.dir/$(TOP).batch/axsim ./axsim.sh
 XSIMK := ./xsim.dir/$(TOP).debug/xsimk

 TEST_NAME := c_ral_test

.PHONY : build build_c run all run_% gui_%
all : run_example_ral_test run_c_ral_test
run_% : 
	make run TEST_NAME=$*
gui_% : 
	make gui TEST_NAME=$*
run : $(AXSIM) dpi_lib.so
	./axsim.sh        --testplusarg "UVM_TESTNAME=$(TEST_NAME)"
gui : $(XSIMK) dpi_lib.so
	$(SIM) $(TOP).debug --testplusarg "UVM_TESTNAME=$(TEST_NAME)" --gui &
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
$(WORK)/my_agent_pkg.sdb     : ./Agent/my_agent.svh
$(WORK)/my_agent_pkg.sdb     : ./Agent/my_driver.svh
$(WORK)/my_agent_pkg.sdb     : ./Agent/my_monitor.svh
$(WORK)/my_agent_pkg.sdb     : ./Agent/my_seq_item.svh
$(WORK)/my_agent_pkg.sdb     : ./Agent/my_adapter.svh
$(WORK)/my_agent_pkg.sdb     : ./Agent/my_agent_pkg.sv
	$(VLOG) -sv $< -L uvm --include ./Agent
#--------------------------------------------------------------

#--------------- Env -----------------------------------------
$(WORK)/my_env_pkg.sdb       : $(WORK)/my_agent_pkg.sdb
$(WORK)/my_env_pkg.sdb       : ./Env/my_env.svh
$(WORK)/my_env_pkg.sdb       : ./Env/my_scoreboard.svh
$(WORK)/my_env_pkg.sdb       : ./Env/my_env_pkg.sv
	$(VLOG) -sv $< -L uvm --include ./Env
#--------------------------------------------------------------

#--------------- Sequence -------------------------------------
$(WORK)/my_sequence_pkg.sdb  : $(WORK)/my_uvm_pkg.sdb
$(WORK)/my_sequence_pkg.sdb  : $(WORK)/my_agent_pkg.sdb
$(WORK)/my_sequence_pkg.sdb  : ./Seq/my_sequence_pkg.sv
	$(VLOG) -sv $< -L uvm --include ./Seq
#--------------------------------------------------------------

#--------------- Test -----------------------------------------
$(WORK)/test_lib_pkg.sdb      : $(WORK)/my_uvm_pkg.sdb
$(WORK)/test_lib_pkg.sdb      : $(WORK)/aiueo_ral_pkg.sdb
$(WORK)/test_lib_pkg.sdb      : $(WORK)/my_env_pkg.sdb
$(WORK)/test_lib_pkg.sdb      : $(WORK)/my_sequence_pkg.sdb
$(WORK)/test_lib_pkg.sdb      : ./Test/test_base.svh
$(WORK)/test_lib_pkg.sdb      : ./Test/example_ral_test.svh
$(WORK)/test_lib_pkg.sdb      : ./Test/c_ral_test.svh
$(WORK)/test_lib_pkg.sdb      : ./Test/test_lib_pkg.sv
	$(VLOG) -sv $< -L uvm --include ./Test
#--------------------------------------------------------------

$(WORK)/my_busif.sdb          : ./Agent/my_busif.sv
	$(VLOG) -sv $< -L uvm

$(WORK)/tb_top.sdb            : $(WORK)/test_lib_pkg.sdb
$(WORK)/tb_top.sdb            : ./TB/tb_top.sv
	$(VLOG) -sv $< -L uvm

.PHONY: clean
clean:
	rm -fr xsim.dir .Xil axsim.sh dpi.h dpi_lib.so 
	rm -fr *.pb
	rm -rf *.log *.jou *.str
	rm -fr *.vcd *.wdb
