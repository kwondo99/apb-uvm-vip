module apb_dummy_dut (
	apb_master_if master_if,
	apb_slave_if slave_if
);

	// from master 
	assign slave_if.paddr = master_if.paddr;
	assign slave_if.psel = master_if.psel;
	assign slave_if.penable = master_if.penable;
	assign slave_if.pwrite = master_if.pwrite;
	assign slave_if.pwdata = master_if.pwdata;
	assign slave_if.pstrb = master_if.pstrb;

	// from slave
	assign master_if.prdata = slave_if.prdata;
	assign master_if.pready = slave_if.pready;
	assign master_if.pslverr = slave_if.pslverr;

endmodule
