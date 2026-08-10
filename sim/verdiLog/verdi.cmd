simSetSimulator "-vcssv" -exec \
           "/home/pedu02/dongo_work/project/20260731_apb_vip/sim/simv" -args \
           "+UVM_TESTNAME=apb_base_test +UVM_VERBOSITY=UVM_MEDIUM"
debImport "-dbdir" \
          "/home/pedu02/dongo_work/project/20260731_apb_vip/sim/simv.daidir"
debLoadSimResult \
           /home/pedu02/dongo_work/project/20260731_apb_vip/sim/apb_test.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "1146" "414" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSelectGroup -win $_nWave2 {G1}
verdiSetActWin -win $_nWave2
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvRenameGroup -win $_nWave2 {G1} {dut}
wvAddSignal -win $_nWave2 "/apb_tb_top/dut/master_if/pclk" \
           "/apb_tb_top/dut/master_if/preset_n" \
           "/apb_tb_top/dut/master_if/paddr\[31:0\]" \
           "/apb_tb_top/dut/master_if/psel" \
           "/apb_tb_top/dut/master_if/penable" \
           "/apb_tb_top/dut/master_if/pwrite" \
           "/apb_tb_top/dut/master_if/pwdata\[31:0\]" \
           "/apb_tb_top/dut/master_if/pstrb\[3:0\]" \
           "/apb_tb_top/dut/master_if/pready" \
           "/apb_tb_top/dut/master_if/prdata\[31:0\]" \
           "/apb_tb_top/dut/master_if/pslverr" "/apb_tb_top/dut/slave_if/pclk" \
           "/apb_tb_top/dut/slave_if/preset_n" \
           "/apb_tb_top/dut/slave_if/paddr\[31:0\]" \
           "/apb_tb_top/dut/slave_if/psel" "/apb_tb_top/dut/slave_if/penable" \
           "/apb_tb_top/dut/slave_if/pwrite" \
           "/apb_tb_top/dut/slave_if/pwdata\[31:0\]" \
           "/apb_tb_top/dut/slave_if/pstrb\[3:0\]" \
           "/apb_tb_top/dut/slave_if/pready" \
           "/apb_tb_top/dut/slave_if/prdata\[31:0\]" \
           "/apb_tb_top/dut/slave_if/pslverr"
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 22)}
wvSetPosition -win $_nWave2 {("dut" 22)}
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
verdiSetActWin -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 1
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
debExit
