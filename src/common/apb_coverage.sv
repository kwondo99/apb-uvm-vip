class apb_coverage extends uvm_subscriber #(apb_item);
	`uvm_component_utils(apb_coverage)
	
	apb_item tr;
	
	covergroup cov1;
	endgroup

	function new(string name = "apb_coverage", uvm_component parent);
		super.new(name, parent);
		cov1 = new();
	endfunction

	function void write(apb_item t);
		tr = t;
		cov1.sample();
		
	endfunction

endclass 
