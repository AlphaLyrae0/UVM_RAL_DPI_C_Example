//class my_scoreboard #(type Tin = uvm_sequence_item, type Tout = uvm_sequence_item) extends uvm_scoreboard;
//  `uvm_component_param_utils(scoreboard)
class my_scoreboard  extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)

  uvm_analysis_imp#(my_seq_item , my_scoreboard)  ex_port;
 
  function new( string name , uvm_component parent) ;
    super.new( name , parent );
    ex_port   = new("ex_port" , this);
  endfunction
 
  virtual function void write(my_seq_item t);    
    `uvm_info(get_name(), $sformatf("Transaction was received.\n%s",t.sprint()), UVM_MEDIUM)
  endfunction
 
endclass
