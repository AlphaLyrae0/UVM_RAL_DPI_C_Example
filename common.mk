
 TOP   := tb_top

 TEST_NAME := c_ral_test

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

C_SOURCE := ./C/C_reg_sequence.cpp

