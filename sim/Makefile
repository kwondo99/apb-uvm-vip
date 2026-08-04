UVM_VERBOSITY = UVM_MEDIUM
UVM_TESTNAME = apb_test
UVM_VERSION = uvm-1.2

RUN_OPT = +UVM_TESTNAME=$(UVM_TESTNAME) +UVM_VERBOSITY=$(UVM_VERBOSITY)

VCS_SRC_FILES =	../src/master/apb_master_if.sv \
								../src/slave/apb_slave_if.sv \
								../src/common/dummy_dut.sv \
								../src/common/apb_pkg.sv \
								../src/common/apb_tb_top.sv 
								
VCS_INCDIR = +incdir+../src/common \
						 +incdir+../src/master \
						 +incdir+../src/slave 

VCS_OPTS = -full64 -sverilog -debug_access+all -kdb -lca \
						-ntb_opts $(UVM_VERSION) -timescale=1ns/1ps 

SIMV_OPTS = -l simv.log $(RUN_OPT) 

all : clean compile sim
						
compile:
	vcs $(VCS_OPTS) $(VCS_INCDIR) $(VCS_SRC_FILES) -l compile.log -o simv 
	@echo "compile.."

sim :
	./simv $(SIMV_OPTS)
	@echo "simulation.."

clean : 
	rm -rf simv* csrc *.log *.key *.h *.vdb *.conf *.rc *.fsdb 
	@echo "clear.."
