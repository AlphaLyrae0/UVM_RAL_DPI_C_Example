
class c_ral_test extends test_base;

  `uvm_component_utils(c_ral_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task start_sequene();
    my_uvm_pkg::my_c_ral_sequence seq = my_uvm_pkg::my_c_ral_sequence::type_id::create("my_c_ral_seq");
    seq.model = this.m_ral_model;
    seq.start( .sequencer(this.m_sequencer), .parent_sequence(null)  );
  endtask

endclass
