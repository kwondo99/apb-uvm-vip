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
		apb_master_sequence seq;
		phase.raise_objection(this);
		seq = apb_master_sequence::type_id::create("seq");
		seq.start(env.master_agt.sqr);
				
		phase.drop_objection(this);
	endtask	

endclass
