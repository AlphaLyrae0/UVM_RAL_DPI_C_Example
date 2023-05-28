`ifndef MY_AGENT_PKG_SV
`define MY_AGENT_PKG_SV
`include "uvm_macros.svh"
package my_agent_pkg;
    import uvm_pkg::*;

    `include "my_seq_item.svh"

    typedef uvm_sequencer#(my_seq_item) my_sequencer;

    `include "my_driver.svh"
    `include "my_monitor.svh"
    `include "my_agent.svh"
    `include "my_adapter.svh"

endpackage
`endif
