interface apb_slave_if (
    input logic pclk,
    input logic preset_n
);
  logic [31:0] paddr;
  logic        psel;
  logic        penable;
  logic        pwrite;
  logic [31:0] pwdata;
  logic [ 3:0] pstrb;
  logic        pready;
  logic [31:0] prdata;
  logic        pslverr;
	
	clocking cb @(posedge pclk);
		default input #1ns output #1ns;
			input paddr, psel, penable, pwrite, pwdata, pstrb;
			output prdata, pslverr, pready;
	endclocking

endinterface 

