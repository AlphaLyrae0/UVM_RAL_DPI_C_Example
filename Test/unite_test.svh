
class unite_test extends test_base;

  `uvm_component_utils(unite_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task start_sequene();
    unite_sequence seq = unite_sequence::type_id::create("top_seq");
    seq.model = this.m_ral_model;
    seq.start( .sequencer(this.m_sequencer), .parent_sequence(null)  );
  endtask

endclass
