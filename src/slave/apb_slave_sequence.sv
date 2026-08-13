class apb_slave_sequence extends uvm_sequence #(apb_item);
  `uvm_object_utils(apb_slave_sequence)

  function new(name = "apb_slave_sequence");
    super.new(name);
  endfunction

  virtual task body();
    apb_item tr;
    repeat (20) begin
      tr = apb_item::type_id::create("tr");
      `uvm_do(tr)
      `uvm_info("S_SEQ", "make s_seq", UVM_MEDIUM)
    end
  endtask

endclass

