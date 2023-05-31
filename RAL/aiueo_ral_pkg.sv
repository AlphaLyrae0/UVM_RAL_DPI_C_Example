
`ifndef AIUEO_BLOCK_PKG_SV
`define AIUEO_BLOCK_PKG_SV
`include "uvm_macros.svh"
package aiueo_ral_pkg;
  import uvm_pkg::*;

  virtual class reg_base extends uvm_reg;

    function new(string name="");
      super.new(name, 32, UVM_NO_COVERAGE);
    endfunction

    virtual function uvm_reg_field create_field(
      string         name   ,
      int unsigned   lsb_pos,   // Bit offset within the register
      int unsigned   size   ,   // How many bits wide
      string         access ,   // "RW", "RO", "WO" etc
      uvm_reg_data_t reset      // The reset value
    );
      uvm_reg_field fld = uvm_reg_field::type_id::create(name);
      fld.configure(this, size, lsb_pos, access, 0, reset, 1, 1, 0);
    //uvm_reg         parent,   // The containing register
    //int unsigned   size,      // How many bits wide
    //int unsigned   lsb_pos,   // Bit offset within the register
    //string         access,    // "RW", "RO", "WO" etc
    //bit            volatile,  // Volatile if bit is updated by hardware
    //uvm_reg_data_t reset,     // The reset value
    //bit            has_reset, // Whether the bit is reset
    //bit            is_rand,   // Whether the bit can be randomized
    //bit            individually_accessible // i.e. Totally contained within a byte lane
      return (fld);
    endfunction

  endclass

  class CONFIG_AAA_reg_model extends reg_base;
    `uvm_object_utils(CONFIG_AAA_reg_model)
    function new(string name="");
      super.new(name); //, 32, UVM_NO_COVERAGE);
    endfunction
    rand uvm_reg_field param_0;
    rand uvm_reg_field param_1;
    rand uvm_reg_field param_2;
    rand uvm_reg_field param_3;
    rand uvm_reg_field param_4;
    rand uvm_reg_field param_5;
    rand uvm_reg_field param_6;
    function void build();
      param_0 = this.create_field("param_0",  0, 4, "RW", 4'ha);
      param_1 = this.create_field("param_1",  4, 4, "RW", 4'hb);
      param_2 = this.create_field("param_2",  8, 1, "RW", 1'h1);
      param_3 = this.create_field("param_3",  9, 2, "RW", 2'h0);
      param_4 = this.create_field("param_4", 11, 2, "RW", 2'h0);
      param_5 = this.create_field("param_5", 13, 2, "RW", 2'h0);
      param_6 = this.create_field("param_6", 15, 2, "RW", 2'h0);
    endfunction
  endclass
  class CONFIG_BBB_reg_model extends reg_base;
    `uvm_object_utils(CONFIG_BBB_reg_model)
    rand uvm_reg_field field;
    function new(string name="");
      super.new(name); //, 32, UVM_NO_COVERAGE);
    endfunction
    function void build();
      field = this.create_field("field", 0, 32, "RW", 32'hffffffff);
    endfunction
  endclass
  class CONFIG_CCC_reg_model extends reg_base;
    `uvm_object_utils(CONFIG_CCC_reg_model)
    function new(string name="");
      super.new(name); //, 32, UVM_NO_COVERAGE);
    endfunction
    rand uvm_reg_field param_0;
    rand uvm_reg_field param_1;
    rand uvm_reg_field param_2;
    rand uvm_reg_field param_3;
    rand uvm_reg_field param_4;
    function void build();
      param_0 = this.create_field("param_0",  0, 4, "RW", 4'h0 );
      param_1 = this.create_field("param_1",  8, 8, "RW", 8'hab);
      param_2 = this.create_field("param_2", 16, 4, "RW", 4'h0 );
      param_3 = this.create_field("param_3", 20, 4, "RW", 4'h0 );
      param_4 = this.create_field("param_4", 24, 8, "RW", 8'h00);
    endfunction
  endclass
  class CONFIG_DDD_reg_model extends reg_base;
    `uvm_object_utils(CONFIG_DDD_reg_model)
    function new(string name="");
      super.new(name); //, 32, UVM_NO_COVERAGE);
    endfunction
    rand uvm_reg_field param_0;
    rand uvm_reg_field param_1;
    rand uvm_reg_field param_2;
    rand uvm_reg_field param_3;
    function void build();
      param_0 = this.create_field("param_0",  0, 4, "RW", 4'ha);
      param_1 = this.create_field("param_1",  4, 4, "RW", 4'hb);
      param_2 = this.create_field("param_2",  8, 4, "RW", 4'hc);
      param_3 = this.create_field("param_3", 16, 4, "RW", 4'hd);
    endfunction
  endclass
  class CONFIG_EEE_reg_model extends reg_base;
    `uvm_object_utils(CONFIG_EEE_reg_model)
    function new(string name="");
      super.new(name); //, 32, UVM_NO_COVERAGE);
    endfunction
    rand uvm_reg_field param_0;
    rand uvm_reg_field param_1;
    rand uvm_reg_field param_2;
    rand uvm_reg_field param_3;
    function void build();
      param_0 = this.create_field("param_0", 0,  4, "RW", 4'h0);
      param_1 = this.create_field("param_1", 8,  4, "RW", 4'h1);
      param_2 = this.create_field("param_2", 12, 4, "RW", 4'h2);
      param_3 = this.create_field("param_3", 16, 4, "RW", 4'h3);
    endfunction
  endclass
  class CONFIG_FFF_reg_model extends reg_base;
    `uvm_object_utils(CONFIG_FFF_reg_model)
    function new(string name="");
      super.new(name); //, 32, UVM_NO_COVERAGE);
    endfunction
    rand uvm_reg_field param_0;
    rand uvm_reg_field param_1;
    rand uvm_reg_field param_2;
    rand uvm_reg_field param_3;
    rand uvm_reg_field param_4;
    rand uvm_reg_field param_5;
    rand uvm_reg_field param_6;
    rand uvm_reg_field param_7;
    rand uvm_reg_field param_8;
    rand uvm_reg_field param_9;
    function void build();
      param_0 = this.create_field("param_0",  0, 2, "RW", 2'h0);
      param_1 = this.create_field("param_1",  2, 2, "RW", 2'h0);
      param_2 = this.create_field("param_2",  4, 2, "RW", 2'h0);
      param_3 = this.create_field("param_3",  6, 2, "RW", 2'h0);
      param_4 = this.create_field("param_4",  8, 2, "RW", 2'h0);
      param_5 = this.create_field("param_5", 10, 2, "RW", 2'h0);
      param_6 = this.create_field("param_6", 12, 2, "RW", 2'h0);
      param_7 = this.create_field("param_7", 16, 2, "RW", 2'h0);
      param_8 = this.create_field("param_8", 18, 2, "RW", 2'h0);
      param_9 = this.create_field("param_9", 20, 2, "RW", 2'h0);
    endfunction
  endclass
  class CONFIG_GGG_reg_model extends reg_base;
    `uvm_object_utils(CONFIG_GGG_reg_model)
    function new(string name="");
      super.new(name); //, 32, UVM_NO_COVERAGE);
    endfunction
    rand uvm_reg_field param_0;
    rand uvm_reg_field param_1;
    rand uvm_reg_field param_2;
    rand uvm_reg_field param_3;
    rand uvm_reg_field param_4;
    rand uvm_reg_field param_5;
    rand uvm_reg_field param_6;
    rand uvm_reg_field param_7;
    rand uvm_reg_field param_8;
    rand uvm_reg_field param_9;
    function void build();
      param_0 = this.create_field("param_0",  0, 4, "RW", 4'h0);
      param_1 = this.create_field("param_1",  4, 4, "RW", 4'h0);
      param_2 = this.create_field("param_2",  8, 4, "RW", 4'h0);
      param_3 = this.create_field("param_3", 12, 4, "RW", 4'h0);
      param_4 = this.create_field("param_4", 16, 4, "RW", 4'h0);
      param_5 = this.create_field("param_5", 20, 4, "RW", 4'h0);
      param_6 = this.create_field("param_6", 24, 4, "RW", 4'h0);
      param_7 = this.create_field("param_7", 28, 2, "RW", 2'h0);
      param_8 = this.create_field("param_8", 30, 1, "RW", 1'h0);
      param_9 = this.create_field("param_9", 31, 1, "RW", 1'h0);
    endfunction
  endclass
  class CONFIG_HHH_reg_model extends reg_base;
    `uvm_object_utils(CONFIG_HHH_reg_model)
    function new(string name="");
      super.new(name); //, 32, UVM_NO_COVERAGE);
    endfunction
    rand uvm_reg_field param_0;
    rand uvm_reg_field param_1;
    rand uvm_reg_field param_2;
    rand uvm_reg_field param_3;
    function void build();
      param_0 = this.create_field("param_0",  0, 4, "RW", 4'h0);
      param_1 = this.create_field("param_1",  8, 4, "RW", 4'h1);
      param_2 = this.create_field("param_2", 16, 4, "RW", 4'h2);
      param_3 = this.create_field("param_3", 24, 4, "RW", 4'h3);
    endfunction
  endclass



  class aiueo_block_model extends  uvm_reg_block; //rggen_ral_block;
    `uvm_object_utils(aiueo_block_model)

    function new(string name="", int has_coverage=UVM_NO_COVERAGE);
      super.new(name); //, has_coverage); //, 4, 0);
    endfunction

    rand CONFIG_AAA_reg_model CONFIG_AAA;
    rand CONFIG_BBB_reg_model CONFIG_BBB;
    rand CONFIG_CCC_reg_model CONFIG_CCC;
    rand CONFIG_DDD_reg_model CONFIG_DDD;
    rand CONFIG_EEE_reg_model CONFIG_EEE;
    rand CONFIG_FFF_reg_model CONFIG_FFF;
    rand CONFIG_GGG_reg_model CONFIG_GGG;
    rand CONFIG_HHH_reg_model CONFIG_HHH;

    uvm_reg_map my_bus_map;

    virtual function void build();
      build_regs();
      build_map ();
      this.lock_model();
    endfunction

    virtual function void build_regs();
      CONFIG_AAA = CONFIG_AAA_reg_model::type_id::create("CONFIG_AAA"); CONFIG_AAA.configure(this); CONFIG_AAA.build();
      CONFIG_BBB = CONFIG_BBB_reg_model::type_id::create("CONFIG_BBB"); CONFIG_BBB.configure(this); CONFIG_BBB.build();
      CONFIG_CCC = CONFIG_CCC_reg_model::type_id::create("CONFIG_CCC"); CONFIG_CCC.configure(this); CONFIG_CCC.build();
      CONFIG_DDD = CONFIG_DDD_reg_model::type_id::create("CONFIG_DDD"); CONFIG_DDD.configure(this); CONFIG_DDD.build();
      CONFIG_EEE = CONFIG_EEE_reg_model::type_id::create("CONFIG_EEE"); CONFIG_EEE.configure(this); CONFIG_EEE.build();
      CONFIG_FFF = CONFIG_FFF_reg_model::type_id::create("CONFIG_FFF"); CONFIG_FFF.configure(this); CONFIG_FFF.build();
      CONFIG_GGG = CONFIG_GGG_reg_model::type_id::create("CONFIG_GGG"); CONFIG_GGG.configure(this); CONFIG_GGG.build();
      CONFIG_HHH = CONFIG_HHH_reg_model::type_id::create("CONFIG_HHH"); CONFIG_HHH.configure(this); CONFIG_HHH.build();
    endfunction

    virtual function void build_map ();
      my_bus_map = this.create_map ( .name("my_bus"), .base_addr('hF00), .n_bytes(4), .byte_addressing(1), .endian(UVM_LITTLE_ENDIAN));
      my_bus_map.add_reg(CONFIG_AAA, 5'h00, "RW");
      my_bus_map.add_reg(CONFIG_BBB, 5'h04, "RW");
      my_bus_map.add_reg(CONFIG_CCC, 5'h08, "RW");
      my_bus_map.add_reg(CONFIG_DDD, 5'h0c, "RW");
      my_bus_map.add_reg(CONFIG_EEE, 5'h10, "RW");
      my_bus_map.add_reg(CONFIG_FFF, 5'h14, "RW");
      my_bus_map.add_reg(CONFIG_GGG, 5'h18, "RW");
      my_bus_map.add_reg(CONFIG_HHH, 5'h1c, "RW");
      my_bus_map.set_auto_predict(1);
    endfunction

  endclass
endpackage
`endif