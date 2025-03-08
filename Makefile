
SIMULATOR := DSIM
ifdef XILINX_VIVADO
SIMULATOR := XSIM
endif
ifdef DSIM_HOME
SIMULATOR := DSIM
endif
ifdef USE_XSIM
SIMULATOR := XSIM
endif
ifdef USE_DSIM
SIMULATOR := DSIM
endif

#------------------ Metrics DSim --------------------------------------
ifeq ($(SIMULATOR),DSIM)
  include dsim.mk
endif
#----------------------------------------------------------------------

#------------------ Vivado XSIM ---------------------------------------
ifeq ($(SIMULATOR),XSIM)
  include xsim.mk
endif
#----------------------------------------------------------------------

## Manual Invoke
dsim_% :
	make -f dsim.mk $*
xsim_% :
	make -f xsim.mk $*

.PHONY : all
all : run_example_ral_test run_c_ral_test run_unite_test

run_% : 
	make run  TEST_NAME=$*
gui_% : 
	make gui  TEST_NAME=$*
dump_% : 
	make dump TEST_NAME=$*

.PHONY: all
clean_all : dsim_clean xsim_clean