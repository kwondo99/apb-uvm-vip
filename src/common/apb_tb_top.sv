`timescale 1ns/1ps

module apb_tb_top();
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	logic clk;
	logic reset_n;

	apb_master_if master_if(clk, reset_n);
	apb_slave_if slave_if(clk, reset_n);

	apb_dummy_dut dut(master_if, slave_if);	

	initial clk = 0;
	always #5 clk = ~clk;

	initial begin
		reset_n = 0;
		#20 reset_n = 1;
	end

	initial begin
		$fsdbDumpfile("apb_test.fsdb");
		$fsdbDumpvars(0, apb_tb_top);
	end

	initial begin
		uvm_config_db#(virtual apb_master_if)::set(null, "*", "apb_master_if", master_if);
		uvm_config_db#(virtual apb_slave_if)::set(null, "*", "apb_slave_if", slave_if);
		run_test();
	end	

endmodule
