class my_adapter extends uvm_reg_adapter;
 
  `uvm_object_utils(my_adapter)
 
   function new(string name = "my_adapter");
      super.new(name);
      supports_byte_enable = 0;
      provides_responses = 0;
   endfunction
 
  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    my_seq_item tr = my_seq_item::type_id::create("tr");
    tr.acc =  rw.kind;
    tr.addr = rw.addr;
    tr.data = rw.data;
    return tr;
  endfunction
 
  virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    my_seq_item tr;
    if (!$cast(tr, bus_item)) begin
      `uvm_fatal(get_name,"Provided bus_item is not of the correct type.")
      return;
    end
    rw.kind = tr.acc ;
    rw.addr = tr.addr;
    rw.data = tr.data;
    rw.status = UVM_IS_OK;
  endfunction
 
endclass