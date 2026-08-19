class apb_virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(apb_virtual_sequencer)

  uvm_sequencer #(apb_item) m_sqr;
  uvm_sequencer #(apb_item) s_sqr;

  function new(string name = "apb_virtual_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_sqr = uvm_sequencer#(apb_item)::type_id::create("m_sqr", this);
    s_sqr = uvm_sequencer#(apb_item)::type_id::create("s_sqr", this);
  endfunction

endclass
