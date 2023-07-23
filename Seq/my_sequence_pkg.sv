`include "uvm_macros.svh"
package my_sequence_pkg;
  import uvm_pkg::*;

  class example_ral_sequence extends my_uvm_pkg::my_ral_sequence_base;
    `uvm_object_utils(example_ral_sequence)
  
    function new(string name="");
      super.new(name);
    endfunction

    string msg;

    int data;

    virtual task body();

      get_ral_CONFIG_AAA ();
      read_reg_CONFIG_AAA();
      write_field_CONFIG_AAA();
      read_field_CONFIG_AAA ();

    endtask

    virtual function void get_ral_CONFIG_AAA();
      msg = "- Read RAL Values of CONFIG_AAA ---";
      msg = {msg, $sformatf(": 0x%8H",this.reg_ralget("CONFIG_AAA") )};
      `uvm_info(get_name(), msg, UVM_MEDIUM)
    endfunction

    virtual task read_reg_CONFIG_AAA();
      this.reg_read ("CONFIG_AAA", data);
      msg = "- Read REG Values of CONFIG_AAA ---";
      msg = {msg, $sformatf(" : 0x%8H",data )};
      `uvm_info(get_name(), msg, UVM_MEDIUM)

    endtask

    virtual task write_field_CONFIG_AAA();
    //this.reg_write("CONFIG_AAA",   100);
      this.fld_ralset("CONFIG_AAA.param_0",  9);
      this.fld_ralset("CONFIG_AAA.param_1",  9);
      this.fld_ralset("CONFIG_AAA.param_2",  1);
      this.fld_ralset("CONFIG_AAA.param_3",  2);
      this.fld_ralset("CONFIG_AAA.param_4",  2);
      this.fld_ralset("CONFIG_AAA.param_5",  2);
      this.fld_ralset("CONFIG_AAA.param_6",  2);
      this.reg_update("CONFIG_AAA");
    endtask

    virtual task read_field_CONFIG_AAA();
    //this.reg_read ("CONFIG_AAA", rdata);
      this.reg_mirror("CONFIG_AAA");
      msg = "\n- Read Values of CONFIG_AAA ---";
      msg = {msg, $sformatf("\n |- param_0 : %0d", this.fld_ralget("CONFIG_AAA.param_0"))};
      msg = {msg, $sformatf("\n |- param_1 : %0d", this.fld_ralget("CONFIG_AAA.param_1"))};
      msg = {msg, $sformatf("\n |- param_2 : %0d", this.fld_ralget("CONFIG_AAA.param_2"))};
      msg = {msg, $sformatf("\n |- param_3 : %0d", this.fld_ralget("CONFIG_AAA.param_3"))};
      msg = {msg, $sformatf("\n |- param_4 : %0d", this.fld_ralget("CONFIG_AAA.param_4"))};
      msg = {msg, $sformatf("\n |- param_5 : %0d", this.fld_ralget("CONFIG_AAA.param_5"))};
      msg = {msg, $sformatf("\n |- param_6 : %0d", this.fld_ralget("CONFIG_AAA.param_6"))};
      `uvm_info(get_name(), msg, UVM_MEDIUM)
    endtask

  endclass


  class unite_sequence extends my_uvm_pkg::my_ral_sequence_base;
    `uvm_object_utils(unite_sequence)
  
    function new(string name="");
      super.new(name);
    endfunction

    virtual task body();
      ral_seq();
      c_seq  ();
      this.start_c_sequence();
    endtask

    virtual task ral_seq();
      example_ral_sequence ral_seq;
      ral_seq = example_ral_sequence::type_id::create("ral_seq");
      ral_seq.start_on_ral(this.model, this);
    endtask

    virtual task c_seq();
      my_uvm_pkg::my_c_ral_sequence c_seq;
      c_seq = my_uvm_pkg::my_c_ral_sequence::type_id::create("c_ral_seq");
      c_seq.id = 1;
      c_seq.start_on_ral(this.model, this);
    endtask

  endclass


endpackage