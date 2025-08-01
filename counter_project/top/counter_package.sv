package counter_pkg;
	
	int no_of_trans = 20;	
					//`include "counter_rtl_code"
	
					//`include "counter_if"
	`include "counter_trans.sv"
	`include "counter_gen.sv"
	`include "counter_wr_drv.sv"
	`include "counter_wr_mon.sv"
	`include "counter_rd_mon.sv"
	`include "counter_rm.sv"
	`include "counter_score_board.sv"
	`include "counter_env.sv"
	//`include "counter_test.sv"  // importimg test is illegal

endpackage : counter_pkg
