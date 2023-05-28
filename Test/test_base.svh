
virtual class test_base extends uvm_test;

  my_env  m_env;

  aiueo_ral_pkg::aiueo_block_model m_ral_model;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_env = my_env::type_id::create("m_env", this);
    create_ral();
    m_env.m_ral_model = this.m_ral_model;
  endfunction

  virtual function void create_ral();
    m_ral_model = aiueo_ral_pkg::aiueo_block_model::type_id::create("m_ral_model");
    m_ral_model.build();
  endfunction

  uvm_sequencer_base  m_sequencer;

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m_sequencer = m_env.m_sequencer;
  endfunction

  uvm_factory factory;

  virtual function void end_of_elaboration_phase (uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_pkg::uvm_top.print_topology();
    this.factory = uvm_factory::get();
    this.factory.print();
  endfunction

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TEST", $sformatf("\n\
####################################\n\
  TESTNAME : %s \n\
####################################"
      , this.get_type_name() ), UVM_MEDIUM)
  endfunction

  virtual function void final_phase(uvm_phase phase);
    `uvm_info("TEST", $sformatf("\n\
=====================================\n\
  Thank you for running me!! Bye.\n\
    -- %s \n\
====================================="
      , this.get_type_name() ), UVM_MEDIUM)
  endfunction

endclass


