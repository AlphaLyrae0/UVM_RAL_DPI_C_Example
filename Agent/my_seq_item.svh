
class my_seq_item extends uvm_sequence_item;
    rand    uvm_access_e    acc ;
    rand    bit   [11:0]    addr;
    rand    logic [31:0]    data;

    `uvm_object_utils_begin(my_seq_item)
        `uvm_field_enum( uvm_access_e, acc , UVM_ALL_ON)
        `uvm_field_int (               addr, UVM_ALL_ON | UVM_HEX)
        `uvm_field_int (               data, UVM_ALL_ON | UVM_BIN)
    `uvm_object_utils_end

    function new(string name = "");
        super.new(name);
    endfunction

endclass
