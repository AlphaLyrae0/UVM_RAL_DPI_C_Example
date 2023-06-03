
class unite_test extends test_base;

  `uvm_component_utils(unite_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task start_sequene();
    unite_sequence seq = unite_sequence::type_id::create("top_seq");
    seq.start_on_ral( this.m_ral_model );
  endtask

endclass
