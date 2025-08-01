interface counter_if(input bit clk);

logic load,rstn;
logic [3:0]data_in;
logic [3:0]dout;
logic mode;
//int id;

clocking wr_driver_cb@(posedge clk);
	default input #1 output #1;
	output rstn; 
	output load;	
	output mode;
	output data_in;
						//output id;
endclocking:wr_driver_cb


clocking wr_mon_cb@(posedge clk);
	default input #1 output #1;
	input rstn;
	input load;	
	input mode;
	input data_in;
						//input id;
endclocking:wr_mon_cb

clocking rd_mon_cb@(posedge clk);
	 default input #1 output #1;
	input dout;
	input mode;
	input load;
						 //input id;
endclocking:rd_mon_cb

modport WR_DRIVER_MP (clocking wr_driver_cb);

modport WR_MON_MP 	(clocking wr_mon_cb);

modport RD_MON_MP 	(clocking rd_mon_cb);

endinterface:counter_if

