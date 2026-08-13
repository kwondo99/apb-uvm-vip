class apb_slave_driver extends uvm_driver #(apb_item);
  `uvm_component_utils(apb_slave_driver)

  virtual apb_slave_if vif;

  function new(name = "apb_slave_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual apb_slave_if)::get(this, "", "apb_slave_if", vif);
  endfunction

  task write_drive(apb_item tr);
    vif.cb.pready <= 1'b1;
  endtask

  task read_drive(apb_item tr);
    vif.cb.pready <= 1'b1;
    vif.cb.prdata <= tr.PRDATA;
  endtask

  task run_phase(uvm_phase phase);
    apb_item tr;
    forever begin
			vif.cb.pready <= 1'b0;
      seq_item_port.get_next_item(tr);
      // drive signal
      while (!vif.cb.psel) begin
        @(vif.cb);
      end
      @(vif.cb);
      while (!vif.cb.penable) begin
        @(vif.cb);
      end
			`uvm_info("S_DRV", $sformatf("delay = %d", tr.PREADY_DELAY), UVM_MEDIUM)
      for (int i = 0; i < tr.PREADY_DELAY; i++) begin
        @(vif.cb);
      end
      if (vif.cb.pwrite) write_drive(tr);
      else read_drive(tr);
			@(vif.cb);
      seq_item_port.item_done();
    end
  endtask

endclass

