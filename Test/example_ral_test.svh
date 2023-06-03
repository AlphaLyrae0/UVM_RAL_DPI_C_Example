
class example_ral_test extends test_base;

  `uvm_component_utils(example_ral_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task start_sequene();
    example_ral_sequence seq = example_ral_sequence::type_id::create("ral_seq");
    seq.start_on_ral( this.m_ral_model  );
  endtask

endclass
