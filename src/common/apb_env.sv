class apb_env extends uvm_env;
	`uvm_component_utils(apb_env);

	apb_master_agent master_agt;
	apb_slave_agent  slave_agt;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		master_agt = apb_master_agent::type_id::create("master_agt", this);
		slave_agt = apb_slave_agent::type_id::create("slave_agt", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		// connect monitor to scb, cov 
	endfunction 
	
endclass
