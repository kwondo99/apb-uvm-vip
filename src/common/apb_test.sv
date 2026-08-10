class apb_base_test extends uvm_test;
 `uvm_component_utils(apb_base_test)
	apb_env env;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = apb_env::type_id::create("env", this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction 

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		
		phase.drop_objection(this);
	endtask	

endclass
