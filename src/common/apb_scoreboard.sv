`uvm_analysis_imp_decl(_master)
`uvm_analysis_imp_decl(_slave)

class apb_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(apb_scoreboard)

	uvm_analysis_imp_master#(apb_item, apb_scoreboard) master_imp;
	uvm_analysis_imp_slave#(apb_item, apb_scoreboard) slave_imp;

	function new(string name, uvm_component parent);
		super.new(name, parent);
		master_imp = new("master_imp", this);
		slave_imp = new("slave_imp", this);
	endfunction

	function void write_master(apb_item tr);
      `uvm_info("SCB", $sformatf(
                "Get item from Master Monitor : paddr = 8'h%h, psel = %b, penable = %b, pwrite = %b, pwdata = 8'h%h, pstrb = %b, pready = %b, prdata = 8'h%h",
                tr.PADDR,
                tr.PSEL,
                tr.PENABLE,
                tr.PWRITE,
                tr.PWDATA,
                tr.PSTRB,
                tr.PREADY,
                tr.PRDATA
                ), UVM_MEDIUM)
    
	endfunction
		
	function void write_slave(apb_item tr);
      `uvm_info("SCB", $sformatf(
                "Get item from Slave Monitor : paddr = 8'h%h, psel = %b, penable = %b, pwrite = %b, pwdata = 8'h%h, pstrb = %b, pready = %b, prdata = 8'h%h",
                tr.PADDR,
                tr.PSEL,
                tr.PENABLE,
                tr.PWRITE,
                tr.PWDATA,
                tr.PSTRB,
                tr.PREADY,
                tr.PRDATA
                ), UVM_MEDIUM)
	endfunction

endclass 
	
	
