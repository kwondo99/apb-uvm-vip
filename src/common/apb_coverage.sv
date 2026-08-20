class apb_coverage extends uvm_subscriber #(apb_item);
  `uvm_component_utils(apb_coverage)

  apb_item tr;

  covergroup cov_write;
    option.per_instance = 1;
    cp_wdata: coverpoint {tr.PWDATA} {option.auto_bin_max = 32;}
    cp_addr: coverpoint {tr.PADDR} {option.auto_bin_max = 32;}
  endgroup

  covergroup cov_read;
    option.per_instance = 1;
    cp_rdata: coverpoint {tr.PRDATA} {option.auto_bin_max = 32;}
    cp_addr: coverpoint {tr.PADDR} {option.auto_bin_max = 32;}
  endgroup

  function new(string name = "apb_coverage", uvm_component parent);
    super.new(name, parent);
		cov_write = new();
		cov_read = new();
  endfunction

  function void write(apb_item t);
    tr = t;
    if (tr.PENABLE && tr.PREADY) begin
      if (tr.PWRITE) cov_write.sample();
      else cov_read.sample();
    end
  endfunction

	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info("COV", "******** Functional Coverage result ***********", UVM_LOW)
		`uvm_info("COV", $sformatf(" write_transaction_coverage : %6.2f %%", cov_write.get_inst_coverage()), UVM_LOW)
		`uvm_info("COV", $sformatf(" read_transaction_coverage : %6.2f %%", cov_read.get_inst_coverage()), UVM_LOW)
		`uvm_info("COV", "************************************************", UVM_LOW)
	endfunction

endclass
