class apb_env extends uvm_env;
	`uvm_component_utils(apb_env);

	apb_master_agent master_agt;
	apb_slave_agent slave_agt;
	apb_virtual_sequencer v_sqr;
	apb_scoreboard scb;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		master_agt = apb_master_agent::type_id::create("master_agt", this);
		slave_agt = apb_slave_agent::type_id::create("slave_agt", this);
		scb = apb_scoreboard::type_id::create("scb", this);
		v_sqr = apb_virtual_sequencer::type_id::create("v_sqr", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		// connect monitor to scb, cov 
		master_agt.mon.ap.connect(scb.master_imp);
		slave_agt.mon.ap.connect(scb.slave_imp);
		v_sqr.m_sqr = master_agt.sqr;
		v_sqr.s_sqr = slave_agt.sqr;
	endfunction 
	
endclass
