`include "counter_test.sv"; 

module top;

	//parameter cycle = 10;
 	bit clk =1'b0;

	counter_if duv_if(clk);
	
	test test_h;

	//counter_trans t;
	
	mod_12_coun DUV(.clk(duv_if.clk), .load(duv_if.load), .rstn(duv_if.rstn), .mode(duv_if.mode), .data_in(duv_if.data_in), .dout(duv_if.dout));

	always #5 clk = ~clk;
	
	initial 
		begin
	`ifdef VCS
        	 $fsdbDumpvars(0, top);
        `endif
	
			test_h = new(duv_if,duv_if,duv_if);  //static i_f
	
			test_h.build_run();
		end
endmodule : top
	
