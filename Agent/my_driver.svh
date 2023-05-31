class my_driver extends uvm_driver #(my_seq_item);

    `uvm_component_utils(my_driver)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual my_busif vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (this.vif == null) begin
            if ( !uvm_config_db#(virtual my_busif)::get(this, "", "v_my_busif", this.vif) )
                `uvm_fatal(get_name(), "v_my_busif was not gotten.")
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        vif.en    = 1'b0;
        vif.we    = 1'b0;
        vif.wdata =   '0;
        vif.addr  =   '0;
        @(posedge vif.rst_n);
        @(negedge vif.clk  );
        forever begin
          //this.seq_item_port.get(req);
            this.seq_item_port.get_next_item(this.req);
            vif.en    = 1'b1; //req.en;
            vif.we    = 1'b0;
            vif.wdata =   '0;
            vif.addr  = req.addr;
            if (this.req.acc == UVM_WRITE) begin
                vif.we    = 1'b1;
                vif.wdata = this.req.data;
            end
            @(negedge vif.clk);
            vif.en = 1'b0;
            if (this.req.acc == UVM_READ) begin
                @(negedge vif.clk);
                this.req.data = vif.rdata;
            end
            this.seq_item_port.item_done();
          //rsp = RSP::type_id::create("rsp");
          //rsp.set_id_info(req);
          //rsp.data = vif.rdata;
          //seq_item_port.put(rsp);
        end
    endtask

endclass
