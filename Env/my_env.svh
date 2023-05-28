
class my_env extends uvm_env;

  `uvm_component_utils(my_env)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  uvm_sequencer_base  m_sequencer;
  uvm_reg_block       m_ral_model;

  my_agent      m_agent     ;
  my_scoreboard m_scoreboard;
  my_adapter    m_reg2bus;

  virtual function void build_phase(uvm_phase phase);
    super.build();
    m_agent      = my_agent     ::type_id::create("m_agent"     , this);
    m_scoreboard = my_scoreboard::type_id::create("m_scoreboard", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);

    m_agent.analysis_port.connect(m_scoreboard.ex_port);

    if (m_agent.get_is_active() == UVM_ACTIVE) begin
      this.m_sequencer = m_agent.m_sequencer; 
      m_reg2bus = my_adapter::type_id::create("m_reg2bus");
      if (m_ral_model.get_parent() == null)
        m_ral_model.default_map.set_sequencer(m_agent.m_sequencer, m_reg2bus);
    end

  endfunction

endclass