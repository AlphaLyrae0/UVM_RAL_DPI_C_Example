class my_agent extends uvm_agent;

    `uvm_component_utils(my_agent)

    function new (string name, uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction : new

    uvm_analysis_port #(my_seq_item) analysis_port;

    my_driver       m_driver;
    my_sequencer    m_sequencer;
    my_monitor      m_monitor;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if ( this.get_is_active() == UVM_ACTIVE ) begin
            m_sequencer = my_sequencer::type_id::create("m_sequencer", this);
            m_driver    = my_driver   ::type_id::create("m_driver"   , this);
        end
        m_monitor = my_monitor::type_id::create("m_monitor", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        if( this.get_is_active() == UVM_ACTIVE )
            m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
        m_monitor.analysis_port.connect(analysis_port);
    endfunction

endclass
