`uvm_analysis_imp_decl(_master)
`uvm_analysis_imp_decl(_slave)

class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)

  uvm_analysis_imp_master #(apb_item, apb_scoreboard) master_imp;
  uvm_analysis_imp_slave #(apb_item, apb_scoreboard)  slave_imp;

  parameter IDLE = 0, SETUP = 1, ACCESS = 2;
  parameter S_FAULT_INJECTED = 3;

  int unsigned m_state = IDLE;
  int unsigned s_state = IDLE;

  int unsigned m_write, m_read, m_pass, m_fail;
  int unsigned s_write, s_read, s_pass, s_fail;
  int unsigned fault_injection;

	bit [31:0] temp0;
	bit [31:0] temp1;
	int unsigned num_check;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    master_imp      = new("master_imp", this);
    slave_imp       = new("slave_imp", this);
    m_write         = 0;
    m_read          = 0;
    m_pass          = 0;
    m_fail          = 0;
    s_write         = 0;
    s_read          = 0;
    s_pass          = 0;
    s_fail          = 0;
    fault_injection = 0;
		temp0 = null;
		temp1 = null;
		num_check = 0;
  endfunction

	function void write_data_check(bit [31:0] data);
		if (temp0 == null) begin 
			temp0 = data;
			num_check++;
			`uvm_info("SCB", $sformatf("start check data"), UVM_HIGH)	
		end
		else begin
			if (temp0 == data) `uvm_info("SCB", $sformatf("get same data from master and slave"), UVM_HIGH)
			else `uvm_error("SCB", $sformatf("get different data frm master and slave"))
			temp0 = null;
		end
	endfunction

	function void read_data_check(bit [31:0] data);
		if (temp1 == null) begin 
			temp1 = data;
			num_check++;
			`uvm_info("SCB", $sformatf("start check data"), UVM_HIGH)
		end
		else begin
			if (temp1 == data) `uvm_info("SCB", $sformatf("get same data from master and slave"), UVM_HIGH)
			else `uvm_error("SCB", $sformatf("get different data frm master and slave"))
			temp1 = null;
		end
	endfunction

  function void write_master(apb_item tr);
    `uvm_info("SCB", $sformatf(
              "Get item from Master Monitor : paddr = 8'h%h, psel = %b, penable = %b, pwrite = %b, pwdata = 8'h%h, pstrb = %b, pready = %b, prdata = 8'h%h",
              tr.PADDR,
              tr.PSEL,
              tr.PENABLE,
              tr.PWRITE,
              tr.PWDATA,
              tr.PSTRB,
              tr.PREADY,
              tr.PRDATA
              ), UVM_HIGH)
		write_data_check(tr.PWDATA);	
		read_data_check(tr.PRDATA);	
    case (m_state)
      IDLE: begin
        case ({
          tr.PSEL, tr.PENABLE
        })
          2'b00: begin
            m_state = IDLE;
          end
          2'b01: begin
            m_state = S_FAULT_INJECTED;
            `uvm_info("SCB", $sformatf("Fault_injected start"), UVM_HIGH)
          end
          2'b10: begin
            m_state = SETUP;
            if (tr.PWRITE) begin
              m_write++;
              `uvm_info("M_SCB", $sformatf("Write transaction start"), UVM_MEDIUM)
            end else begin
              m_read++;
              `uvm_info("M_SCB", $sformatf("Read transaction start"), UVM_MEDIUM)
            end
          end
          2'b11: begin
            m_fail++;
            `uvm_error("M_SCB", $sformatf("FAIL psel, penable rise same time"))
          end
        endcase
      end
      SETUP: begin
        if (!tr.PSEL) begin
          `uvm_error("M_SCB", $sformatf("psel is low while transaction"))
          m_state = IDLE;
        end else if (tr.PENABLE) begin
          `uvm_info("M_SCB", $sformatf("PASS setup state"), UVM_HIGH)
          m_state = ACCESS;
        end else begin
          m_fail++;
          m_state = IDLE;
          `uvm_error("M_SCB", $sformatf("FAIL, Penable is low"))
        end
      end
      ACCESS: begin
        if (!tr.PSEL) begin
          `uvm_error("M_SCB", $sformatf("psel is low while transaction"))
          m_state = IDLE;
          m_fail++;
        end else if (!tr.PENABLE) begin
          `uvm_error("M_SCB", $sformatf("penable is low while transaction"))
          m_state = IDLE;
          m_fail++;
        end
        if (tr.PREADY) begin
          `uvm_info("M_SCB", $sformatf("PASS end transaction"), UVM_HIGH)
          m_pass++;
          m_state = IDLE;
        end
      end
      S_FAULT_INJECTED: begin
        if (tr.PSEL) begin
          if (tr.PENABLE) begin
            `uvm_error("M_SCB", $sformatf("Penable and psel are HIGH simultaneously"))
            fault_injection++;
            m_fail++;
            m_state = IDLE;
          end else begin
            if (tr.PWRITE) begin
              m_write++;
              `uvm_info("M_SCB", $sformatf("Write transaction start"), UVM_MEDIUM)
            end else begin
              m_read++;
              `uvm_info("M_SCB", $sformatf("Read transaction start"), UVM_MEDIUM)
            end
            fault_injection++;
            m_pass++;
            m_state = SETUP;
          end
        end else if (!tr.PENABLE) begin
          fault_injection++;
          m_pass++;
          m_state = IDLE;
        end
      end
      default: begin
      end
    endcase

  endfunction

  function void write_slave(apb_item tr);
    `uvm_info("SCB", $sformatf(
              "Get item from Slave Monitor : paddr = 8'h%h, psel = %b, penable = %b, pwrite = %b, pwdata = 8'h%h, pstrb = %b, pready = %b, prdata = 8'h%h",
              tr.PADDR,
              tr.PSEL,
              tr.PENABLE,
              tr.PWRITE,
              tr.PWDATA,
              tr.PSTRB,
              tr.PREADY,
              tr.PRDATA
              ), UVM_HIGH)
		write_data_check(tr.PWDATA);	
		read_data_check(tr.PRDATA);	
    case (s_state)
      IDLE: begin
        if (tr.PREADY) begin
          `uvm_error("S_SCB", $sformatf(" At IDLE state, PREADY is High"))
        end
        case ({
          tr.PSEL, tr.PENABLE
        })
          2'b00: begin
            s_state = IDLE;
          end
          2'b01: begin
            s_state = IDLE;
          end
          2'b10: begin
            s_state = SETUP;
            if (tr.PWRITE) begin
              s_write++;
              `uvm_info("S_SCB", $sformatf("Write transaction start"), UVM_MEDIUM)
            end else begin
              s_read++;
              `uvm_info("S_SCB", $sformatf("Read transaction start"), UVM_MEDIUM)
            end
          end
          2'b11: begin
            s_fail++;
            `uvm_error("S_SCB", $sformatf("FAIL psel, penable rise same time"))
          end
        endcase
      end
      SETUP: begin
        if (!tr.PSEL) begin
          `uvm_error("S_SCB", $sformatf("psel is low while transaction"))
          s_state = IDLE;
          s_fail++;
        end else if (tr.PENABLE) begin
          `uvm_info("S_SCB", $sformatf("PASS setup state"), UVM_HIGH)
          s_state = ACCESS;
        end else begin
          `uvm_error("S_SCB", $sformatf("FAIL, Penable is low"))
          s_fail++;
          s_state = IDLE;
        end
      end
      ACCESS: begin
        if (!tr.PSEL) begin
          `uvm_error("S_SCB", $sformatf("psel is low while transaction"))
          s_fail++;
          s_state = IDLE;
        end else if (!tr.PENABLE) begin
          `uvm_error("S_SCB", $sformatf("penable is low while transaction"))
          s_fail++;
          s_state = IDLE;
        end
        if (tr.PREADY) begin
          `uvm_info("S_SCB", $sformatf("PASS end transaction"), UVM_HIGH)
          s_pass++;
          s_state = IDLE;
        end
      end
    endcase
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);

    `uvm_info("SCB", $sformatf("*********** End test ***********"), UVM_LOW)
    `uvm_info("SCB", $sformatf("check data : %0d", num_check), UVM_LOW)
    `uvm_info("SCB", $sformatf("*********** Master Scoreboard ***********"), UVM_LOW)
    `uvm_info("SCB", $sformatf(
              "** write : %0d, read : %0d, fault_injection = %0d, pass : %0d, fail : %0d **",
              m_write,
              m_read,
              fault_injection,
              m_pass,
              m_fail
              ), UVM_LOW)
    `uvm_info("SCB", $sformatf("*********** Slave Scoreboard ***********"), UVM_LOW)
    `uvm_info("SCB", $sformatf(
              "** write : %0d, read : %0d, pass : %0d, fail : %0d **",
              s_write,
              s_read,
              s_pass,
              s_fail
              ), UVM_LOW)
    `uvm_info("SCB", $sformatf("********************************"), UVM_LOW)
  endfunction

endclass


