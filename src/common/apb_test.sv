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

	virtual task run_phase(uvm_phase phase);
		apb_master_sequence m_seq;
		apb_slave_sequence s_seq;
		phase.raise_objection(this);
		m_seq = apb_master_sequence::type_id::create("m_seq");
		s_seq = apb_slave_sequence::type_id::create("s_seq");
		fork
		m_seq.start(env.master_agt.sqr);
		s_seq.start(env.slave_agt.sqr);	
		join_any
		phase.drop_objection(this);
	endtask	

endclass

class apb_virtual_test extends apb_base_test;
	`uvm_component_utils(apb_virtual_test)
	
	apb_virtual_sequence v_seq;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		v_seq = apb_virtual_sequence::type_id::create("v_seq");
		v_seq.start(env.v_sqr);
		phase.drop_objection(this);	
	endtask	

endclass
