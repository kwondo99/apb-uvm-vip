class apb_slave_agent extends uvm_agent;
  `uvm_component_utils(apb_slave_agent)

  apb_slave_driver drv;
  apb_slave_monitor mon;
  uvm_sequencer #(apb_item) sqr;

  function new(name = "apb_slave_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv = apb_slave_driver::type_id::create("drv", this);
    mon = apb_slave_monitor::type_id::create("mon", this);
    sqr = uvm_sequencer#(apb_item)::type_id::create("sqr", this);
  endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
	endfunction
	
endclass
