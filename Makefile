
## Aotomatic Invoke
ifdef DSIM_HOME
  include dsim.mk
else
  include xsim.mk
endif

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

.PHONY: clean_all
clean_all : dsim_clean xsim_clean