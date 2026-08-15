class apb_slave_monitor extends uvm_monitor;
  `uvm_component_utils(apb_slave_monitor)

  virtual apb_slave_if vif;

  function new(name = "apb_slave_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual apb_slave_if)::get(this, "", "apb_slave_if", vif);
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
    end
  endtask

endclass

