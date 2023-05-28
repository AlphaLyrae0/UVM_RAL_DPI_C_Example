`include "uvm_macros.svh"
package my_sequence_pkg;
  import uvm_pkg::*;

  class ral_sequence extends my_uvm_pkg::my_ral_sequence_base;
    `uvm_object_utils(ral_sequence)
  
    function new(string name="");
      super.new(name);
    endfunction

    virtual task body();
    //this.reg_write("",????);
    //this.reg_write("",????);
      this.start_c_sequence();
    //this.start_my_ral_sequence();
    endtask

  //virtual task start_my_ral_sequence()
  //  my_uvm_pkg::my_c_ral_sequence seq = my_uvm_pkg::my_c_ral_sequence::type_id::create("seq");
  //  seq.model = this.model;
  //  seq.start( this.get_sequencer, this );
  //endtask

  endclass

endpackage