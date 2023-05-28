class my_monitor extends uvm_monitor;

    virtual my_busif vif;

    uvm_analysis_port #(my_seq_item) analysis_port;

    `uvm_component_utils(my_monitor)

    function new (string name, uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (this.vif == null) begin
            if ( !uvm_config_db#(virtual my_busif)::get(this, "", "v_my_busif", this.vif) )
                `uvm_fatal(get_name(), "v_my_busif was not gotten.")
        end
    endfunction

    my_seq_item trans;
    virtual task run_phase(uvm_phase phase);
        forever @(posedge vif.clk) begin
            if ( !vif.rst_n ) continue;
            if (vif.en) begin
                trans      = my_seq_item::type_id::create("trans");
                trans.addr = vif.addr;
                if (vif.we) begin
                    trans.acc  = UVM_WRITE;
                    trans.data = vif.wdata;
                end
                else begin
                    @(posedge vif.clk);
                    trans.acc  = UVM_READ;
                    trans.data = vif.rdata;
                end
                analysis_port.write(trans);
            end
        end
    endtask

endclass

