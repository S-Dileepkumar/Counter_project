class counter_wr_drv;

	virtual counter_if.WR_DRIVER_MP wr_driver_if;

	counter_trans data2duv;

	mailbox #(counter_trans) gen2drv;

	function new(mailbox #(counter_trans)  gen2drv,	virtual counter_if.WR_DRIVER_MP wr_driver_if);
		this.gen2drv = gen2drv;
		this.wr_driver_if = wr_driver_if;
	endfunction

	virtual task start();
		fork
			forever 
			begin
				gen2drv.get(data2duv);
				$display("--------------\n\twrite_driver \n\tdata to DUV model %p \n------------",data2duv);
				drive();
			end
		join_none
	endtask : start

	virtual task drive();

		@(wr_driver_if.wr_driver_cb);
	
		wr_driver_if.wr_driver_cb.load 		<= data2duv.load;
		wr_driver_if.wr_driver_cb.mode 		<= data2duv.mode;
		wr_driver_if.wr_driver_cb.data_in 	<= data2duv.data_in;
		wr_driver_if.wr_driver_cb.rstn 		<= data2duv.rstn;
		
	
	endtask : drive
endclass : counter_wr_drv
