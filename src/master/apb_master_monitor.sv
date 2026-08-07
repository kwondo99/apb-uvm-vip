class apb_master_monitor extends uvm_monitor;
	`uvm_component_utils(apb_master_monitor)

	virtual apb_master_if vif;

	function new(name = "apb_master_monitor", parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.new(phase);
		uvm_confing_db#(virtual apb_master_if)::get(this,"","apb_master_if", vif);
	endfunction 

	task run_phase(uvm_phase phase);
		apb_item tr;
		forever begin
		end
	endtask 
endclass
