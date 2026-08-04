class apb_item extends uvm_sequence_item;

  rand bit [31:0] PADDR;
  bit             PSEL;
  bit             PENABLE;
  rand bit        PWRITE;
  rand bit [31:0] PWDATA;
  rand bit [31:0] PRDATA;
  rand bit        PREADY;
  rand bit [ 3:0] PSTRB;
  rand bit        PSLVERR;


  `uvm_object_utils_begin(apb_item)
    `uvm_field_int(PADDR, UVM_DEFAULT)
    `uvm_field_int(PSEL, UVM_DEFAULT)
    `uvm_field_int(PENABLE, UVM_DEFAULT)
    `uvm_field_int(PWRITE, UVM_DEFAULT)
    `uvm_field_int(PWDATA, UVM_DEFAULT)
    `uvm_field_int(PRDATA, UVM_DEFAULT)
    `uvm_field_int(PREADY, UVM_DEFAULT)
    `uvm_field_int(PSTRB, UVM_DEFAULT)
    `uvm_field_int(PSLVERR, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "apb_item");
    super.new(name);
  endfunction

endclass
