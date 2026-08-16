class apb_master_monitor extends uvm_monitor;
  `uvm_component_utils(apb_master_monitor)

  virtual apb_master_if vif;

	uvm_analysis_port#(apb_item) ap;

  function new(name = "apb_master_monitor", uvm_component parent);
    super.new(name, parent);
		ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual apb_master_if)::get(this, "", "apb_master_if", vif);
  endfunction

  task run_phase(uvm_phase phase);
    apb_item tr;
    forever begin
      tr = apb_item::type_id::create("tr");
      @(vif.cb);
      tr.PADDR   = vif.paddr;
      tr.PSEL    = vif.psel;
      tr.PENABLE = vif.penable;
      tr.PWRITE  = vif.pwrite;
      tr.PWDATA  = vif.pwdata;
      tr.PSTRB   = vif.pstrb;
      tr.PREADY  = vif.pready;
      tr.PRDATA  = vif.prdata;
      `uvm_info("M_MON", $sformatf(
                "paddr = 8'h%h, psel = %b, penable = %b, pwrite = %b, pwdata = 8'h%h, pstrb = %b, pready = %b, prdata = 8'h%h",
                tr.PADDR,
                tr.PSEL,
                tr.PENABLE,
                tr.PWRITE,
                tr.PWDATA,
                tr.PSTRB,
                tr.PREADY,
                tr.PRDATA
                ), UVM_MEDIUM)
			ap.write(tr);
    end
  endtask
endclass
