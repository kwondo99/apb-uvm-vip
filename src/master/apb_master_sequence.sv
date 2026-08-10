class apb_master_sequence extends uvm_sequence#(apb_item);
	`uvm_object_utils(apb_master_sequence)

	function new(string name = "apb_master_sequence");
		super.new(name);
	endfunction 

	virtual task body();
		apb_item tr;
		repeat(2) begin
			`uvm_do(tr)
		end
	endtask 

endclass 
