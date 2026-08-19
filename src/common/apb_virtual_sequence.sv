class apb_virtual_sequence extends uvm_sequence;
	`uvm_object_utils(apb_virtual_sequence)
	`uvm_declare_p_sequencer(apb_virtual_sequencer)

	apb_master_sequence m_seq;
	apb_slave_sequence s_seq;
			
	function new(string name = "apb_virtual_sequence");
		super.new(name);
	endfunction

	task body();
		m_seq = apb_master_sequence::type_id::create("m_seq");
		s_seq = apb_slave_sequence::type_id::create("s_seq");
		fork
			m_seq.start(p_sequencer.m_sqr);
			s_seq.start(p_sequencer.s_sqr);
		join_any
	endtask 

endclass 
