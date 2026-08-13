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
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("master_if(apb_master_if)" 0)}
wvRenameGroup -win $_nWave2 {G1} {master_if(apb_master_if)}
wvAddSignal -win $_nWave2 "/apb_tb_top/master_if/pclk" \
           "/apb_tb_top/master_if/preset_n" \
           "/apb_tb_top/master_if/paddr\[31:0\]" "/apb_tb_top/master_if/psel" \
           "/apb_tb_top/master_if/penable" "/apb_tb_top/master_if/pwrite" \
           "/apb_tb_top/master_if/pwdata\[31:0\]" \
           "/apb_tb_top/master_if/pstrb\[3:0\]" "/apb_tb_top/master_if/pready" \
           "/apb_tb_top/master_if/prdata\[31:0\]" \
           "/apb_tb_top/master_if/pslverr"
wvSetPosition -win $_nWave2 {("master_if(apb_master_if)" 0)}
wvSetPosition -win $_nWave2 {("master_if(apb_master_if)" 11)}
wvSetPosition -win $_nWave2 {("master_if(apb_master_if)" 11)}
wvSetPosition -win $_nWave2 {("G2" 0)}
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvZoomOut -win $_nWave2
verdiSetActWin -win $_nWave2
