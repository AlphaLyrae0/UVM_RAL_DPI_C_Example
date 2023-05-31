
`include "uvm_macros.svh"

package test_lib_pkg;
  import uvm_pkg::*;
  import my_sequence_pkg::*;
  import my_env_pkg::*;

  `include "test_base.svh"
  `include "example_ral_test.svh"
  `include "c_ral_test.svh"

endpackage : test_lib_pkg
