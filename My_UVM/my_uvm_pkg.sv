`ifndef MY_UVM_PKG
`define MY_UVM_PKG

`include "uvm_macros.svh"

package my_uvm_pkg;
    import uvm_pkg::*;

    virtual class my_ral_sequence_base#(type BASE=uvm_sequence#(uvm_reg_item)) extends uvm_reg_sequence#(BASE);

        function new (string name="");
            super.new(name);
        endfunction

        string ral_name = "ral_model";

        uvm_status_e status;

        bit print_banners = 1;


        virtual function void check_model();
            if (this.model == null) begin
                if(!uvm_config_db#(uvm_reg_block)::get(this.get_sequencer(), this.get_sequence_path(), ral_name, this.model) )
                    `uvm_fatal(get_name(), {ral_name, " was not gotten!!!"})
            end
        endfunction

        virtual task start_on_ral(uvm_reg_block ral_model, uvm_sequence_base parent=null);
            this.model = ral_model;
            this.start(ral_model.default_map.get_sequencer(), parent);
        endtask

        virtual task pre_body();
            if (print_banners)
                `uvm_info(get_name(), $sformatf("\n============== Start Of Sequence (%s) ===================>",get_sequence_path()), UVM_MEDIUM)
            super.pre_body();
            check_model();
            this.model.default_map.set_auto_predict (1);
          //this.model.default_map.set_check_on_read(1);
        endtask

        pure virtual task body();

        virtual task post_body();
            super.post_body();
            if (print_banners)
                `uvm_info(get_name(), $sformatf("\n<============== End Of Sequence (%s) =====================",get_sequence_path()), UVM_MEDIUM)
        endtask

        virtual task reg_write(input string reg_name, int data);
          //uvm_reg l_reg = this.model.get_reg_by_name(reg_name);
          //l_reg.write(.status(status),.value(data), .parent(this));
          //this.write_reg(this.model.get_reg_by_name(reg_name), status, data);
            this.model.write_reg_by_name( .status(status) , .name(reg_name), .data(data), .parent(this));
            if (status != UVM_IS_OK)
               `uvm_error(get_name(), {reg_name, " is not found!!"})
        endtask

        virtual task reg_read(input string reg_name, output int data);
          //this.read_reg(this.model.get_reg_by_name(reg_name), status, data);
            this.model.read_reg_by_name( .status(status) , .name(reg_name), .data(data), .parent(this));
            if (status != UVM_IS_OK)
               `uvm_error(get_name(), {reg_name, " is not found!!"})
        endtask

        virtual function void reg_ralset(input string reg_name, int data);
            uvm_reg l_reg = this.model.get_reg_by_name(reg_name);
            if (l_reg == null) begin
               `uvm_error(get_name(), {reg_name, " is not found!!"})
                return;
            end
            l_reg.set(data);
        endfunction

        virtual function int reg_ralget(input string reg_name, bit mirrored=1);
            uvm_reg l_reg = this.model.get_reg_by_name(reg_name);
            if (l_reg == null) begin
               `uvm_error(get_name(), {reg_name, " is not found!!"})
                return 0;
            end
            if (mirrored)   return(l_reg.get_mirrored_value());
            else            return(l_reg.get               ());
        endfunction

        virtual function uvm_reg_field find_fld (input string name, delimiter=".");
            uvm_reg         l_reg;
            uvm_reg_field   l_fld;
            string reg_name;
            string fld_name;
            string split_q[$];
            uvm_pkg::uvm_split_string(name, delimiter.getc(0), split_q);
            if (split_q.size() != 2 )
                `uvm_error(get_name(), {"Illegal Register Field Name, ", name})
            reg_name = split_q[0];
            fld_name = split_q[1];

            l_reg = this.model.get_reg_by_name(reg_name);
            if (l_reg == null) begin
               `uvm_error(get_name(), {reg_name, " is not found!!"})
                return (null);
            end

            l_fld = l_reg.get_field_by_name(fld_name);
            if (l_fld == null) begin
                `uvm_error(get_name(), {fld_name, " is not found!!"})
                return (null);
            end

            return (l_fld);

        endfunction

        virtual function void fld_ralset(input string name, int data);
            uvm_reg_field l_fld = find_fld(name);
            if (l_fld == null) return;
            l_fld.set(data);
        endfunction

        virtual function int fld_ralget(input string name, bit mirrored=1);
            uvm_reg_field l_fld = find_fld(name);
            if (l_fld == null) return 0;
            if (mirrored) return(l_fld.get_mirrored_value());
            else          return(l_fld.get               ());
        endfunction

        virtual task reg_update(input string reg_name);
         //uvm_reg l_reg = this.model.get_reg_by_name(reg_name);
         //l_reg.update(.status(status), .parent(this));
           this.update_reg(this.model.get_reg_by_name(reg_name), status);
           if (status != UVM_IS_OK)
              `uvm_error(get_name(), {reg_name, " is not found!!"})
        endtask

        virtual task reg_mirror(input string reg_name);
         //uvm_reg l_reg = this.model.get_reg_by_name(reg_name);
         //l_reg.mirror(.status(status), .parent(this));
           this.mirror_reg(this.model.get_reg_by_name(reg_name), status);
           if (status != UVM_IS_OK)
              `uvm_error(get_name(), {reg_name, " is not found!!"})
        endtask

        virtual task start_c_sequence(int id=0);
            if (m_ral_seq != null)
                `uvm_fatal("MY_UVM_PKG", $sformatf("m_ral_seq is not empty. <%s>",m_ral_seq.get_full_name()))
            m_ral_seq = this; 
            `uvm_info(get_name(), $sformatf("start_c_sequence %s %0d",this.get_name(), id), UVM_MEDIUM)
            C_reg_sequence(this.get_name(), id);
          //C_reg_sequence(id);
            m_ral_seq = null;
        endtask

    endclass

    //---------- For C_Program ---------------
  //import "DPI-C" context task C_reg_sequence(input int id); //input string p_name, input int id);
    import "DPI-C" context task C_reg_sequence(input string p_name, input int id);

    export "DPI-C" ral_reg_write  = task     reg_write ;
    export "DPI-C" ral_reg_set    = function reg_ralset;
    export "DPI-C" ral_fld_set    = function fld_ralset;
    export "DPI-C" ral_reg_update = task     reg_update;

    export "DPI-C" ral_reg_read   = task     reg_read  ;
    export "DPI-C" ral_reg_mirror = task     reg_mirror;
    export "DPI-C" ral_reg_get    = function reg_ralget;
    export "DPI-C" ral_fld_get    = function fld_ralget;

    export "DPI-C" sv_print       = function print_msg;

    function void print_msg(input string msg);
        $display(msg);
    endfunction

  //uvm_sequencer_base   m_sequencer;
  //uvm_reg_block        m_ral_model;
  //uvm_sequencer_base   m_sequence;
    my_ral_sequence_base m_ral_seq;

    task reg_write(input string reg_name, input int data);
        m_ral_seq.reg_write(reg_name, data);
    endtask

    task reg_read (input string reg_name, output int data);
        m_ral_seq.reg_read(reg_name, data);
    endtask
    
    function void reg_ralset (input string reg_name, input int data);
        m_ral_seq.reg_ralset (reg_name, data);
    endfunction

    function void fld_ralset (input string reg_fld_name, input int data);
        m_ral_seq.fld_ralset (reg_fld_name, data);
    endfunction

    function int reg_ralget (input string reg_name);
        return (m_ral_seq.reg_ralget(reg_name));
    endfunction

    function int fld_ralget (input string reg_fld_name);
        return (m_ral_seq.fld_ralget(reg_fld_name));
    endfunction
    
    task reg_update(input string reg_name);
        m_ral_seq.reg_update(reg_name);
    endtask

    task reg_mirror(input string reg_name);
        m_ral_seq.reg_mirror(reg_name);
    endtask

    //---------------------------------------------------
    class my_c_ral_sequence extends my_ral_sequence_base;
        `uvm_object_utils(my_c_ral_sequence)

        function new (string name="");
            super.new(name);
        endfunction

        int id;

        virtual task pre_body();
            super.pre_body();
            if (m_ral_seq != null)
                `uvm_fatal(get_type_name(), $sformatf("m_ral_seq is not empty. <%s>",m_ral_seq.get_full_name()))
            m_ral_seq = this;
        endtask

        virtual task body();
          //C_reg_sequence(this.id);
            C_reg_sequence(this.get_name(), this.id);
        endtask

        virtual task post_body();
            super.post_body();
            m_ral_seq = null;
        endtask

    endclass
    //---------------------------------------------------
    
endpackage
`endif