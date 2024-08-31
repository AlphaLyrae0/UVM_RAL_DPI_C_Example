include common.mk

ifdef XILINX_VIVADO
 VLOG := xvlog
 ELAB := xelab
 SIM  := xsim
 XSC  := xsc
else
 VIVADO_VER := /tools/Xilinx/Vivado/2023.1
 VLOG := $(VIVADO_VER)/bin/xvlog
 ELAB := $(VIVADO_VER)/bin/xelab
 SIM  := $(VIVADO_VER)/bin/xsim
 XSC  := $(VIVADO_VER)/bin/xsc
endif

#AXSIM := $(WORK).$(TOP)/axsim ./axsim.sh
#XSIMK := $(WORK).$(TOP)/xsimk
#AXSIM := ./xsim.dir/$(TOP).batch/axsim ./axsim.sh
 AXSIM  := ./xsim.dir/$(TOP).batch/axsim
 XSIMK  := ./xsim.dir/$(TOP).debug/xsimk
 DPI_SO := ./xsim.dir/work/xsc/dpi.so
#export LD_LIBRARY_PATH := ${LD_LIBRARY_PATH}:${VIVADO_VER}/lib/lnx64.o:${VIVADO_VER}/lib/lnx64.o/Default


.PHONY : run gui
run : $(AXSIM) $(DPI_SO)
	./axsim.sh          --testplusarg "UVM_TESTNAME=$(TEST_NAME)"
	mv xsim.log xsim_$(TEST_NAME).log
#	$(AXSIM)            --testplusarg "UVM_TESTNAME=$(TEST_NAME)" --log $(TEST_NAME).log
gui : $(XSIMK) $(DPI_SO)
	$(SIM) $(TOP).debug --testplusarg "UVM_TESTNAME=$(TEST_NAME)" --log gui_$(TEST_NAME).log --gui &

.PHONY : build_a build_d build_c
build_a     :
	make -f xsim.mk -B $(AXSIM)
build_d     :
	make -f xsim.mk -B $(XSIMK)
build_c   :
	make -f xsim.mk -B $(DPI_SO)

INC_OPT += --include ./Agent
INC_OPT += --include ./Env
INC_OPT += --include ./Seq
INC_OPT += --include ./Test

$(DPI_SO) : $(C_SOURCE) ./dpi.h
	$(XSC) $< 
#./dpi_lib.so : ./C/C_reg_sequence.cpp ./C/dpi.h
#	$(XSC) $< -o $@ 
#	g++ -m32 -fPIC -shared -o dpi_lib.so $^

./dpi.h :
	$(VLOG) -incr -L uvm $(INC_OPT) -sv $(SRC_FILES)
	$(ELAB) -incr -L uvm $(TOP) -dpiheader dpi.h 

$(AXSIM) : $(SRC_FILES) $(INC_FILES)
	make -f xsim.mk $(DPI_SO)
	$(VLOG) -incr -L uvm $(INC_OPT) -sv $(SRC_FILES)
	$(ELAB) -incr -L uvm $(TOP) -timescale 1ns/1ps -sv_lib dpi -standalone -snapshot $(TOP).batch

$(XSIMK) : $(SRC_FILES) $(INC_FILES)
	make -f xsim.mk $(DPI_SO)
	$(VLOG) -incr -L uvm $(INC_OPT) -sv $(SRC_FILES)
	$(ELAB) -incr -L uvm $(TOP) -timescale 1ns/1ps -sv_lib dpi -snapshot $(TOP).debug -debug all
#	$(ELAB) -incr -L uvm $(TOP) -timescale 1ns/1ps -sv_lib dpi -snapshot $(TOP).debug -debug all -dpiheader dpi.h


.PHONY: clean
clean:
	rm -fr xsim.dir .Xil axsim.sh dpi.h dpi_lib.so 
	rm -fr *.pb
	rm -rf *.log *.jou *.str
	rm -fr *.vcd *.wdb
