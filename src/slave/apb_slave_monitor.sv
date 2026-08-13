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
      @(posedge vif.pclk);
    end
  endtask

endclass

