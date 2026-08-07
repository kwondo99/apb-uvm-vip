class apb_master_driver extends uvm_driver #(apb_item);
	`uvm_component_utils(apb_master_driver)
	
	virtual apb_master_if vif;
	
	function new(string name, uvm_component parent);
		super.new(name, parent)
	endfunction 
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(virtual apb_master_if)::get(this, "", "apb_master_if", vif);
	endfunction

	task run_phase(uvm_phase phase);
		apb_item tr;
		forever begin
			seq_item_port.get_next_item(tr);
			// drive signal
			seq_item_port.item_done();
		end
	endtask
	
endclass
