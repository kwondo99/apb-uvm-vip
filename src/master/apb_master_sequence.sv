class apb_master_sequence extends uvm_sequence#(apb_item);
	`uvm_object_utils(apb_master_sequence)

	function new(string name = "apb_master_sequence");
		super.new(name);
	endfunction 

	virtual task body();
		apb_item tr;
		repeat(20) begin
			tr = apb_item::type_id::create("tr");
			`uvm_do(tr)
			`uvm_info("M_SEQ", "make seq", UVM_MEDIUM)
		end
	endtask 

endclass 
