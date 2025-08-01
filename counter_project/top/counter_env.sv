class counter_env;
	
	virtual counter_if.WR_DRIVER_MP wr_drv_if;   // interfaces
	virtual counter_if.WR_MON_MP wr_mon_if;
	virtual counter_if.RD_MON_MP rd_mon_if;
	
	mailbox #(counter_trans) gen2drv = new;
	mailbox #(counter_trans) wr2rm 	 = new;
	mailbox #(counter_trans) rm2sb   = new;
	mailbox #(counter_trans) mon2sb  = new;

	counter_gen			gen_h;
	counter_wr_drv 		drv_h;
	counter_wr_mon 		wr_mon_h;
	counter_rd_mon 		rd_mon_h;
	counter_rm 			rm_h;
	counter_sb	 		sb_h;

	
	function new(virtual counter_if.WR_DRIVER_MP wr_drv_if,
			virtual counter_if.WR_MON_MP wr_mon_if,
			virtual counter_if.RD_MON_MP rd_mon_if);

		this.wr_drv_if = wr_drv_if;
		this.wr_mon_if = wr_mon_if;
		this.rd_mon_if = rd_mon_if;

	endfunction

	virtual task reset();
		
		repeat(2) @(wr_drv_if.wr_driver_cb);    // delay of  2 clocking block
		wr_drv_if.wr_driver_cb.rstn    <= 0;
		wr_drv_if.wr_driver_cb.mode    <= 0;
		wr_drv_if.wr_driver_cb.load    <= 0;
		wr_drv_if.wr_driver_cb.data_in <= 0;
		repeat(3) @(wr_drv_if.wr_driver_cb); 	// delay of 3 clocking block
												//repeat(5) @(wr_drv_if.wr_driver_cb);
		wr_drv_if.wr_driver_cb.rstn <= 1;
				
	endtask

	virtual task run();                        // environment task run  ->reset ->start ->stop
		reset();	
		start();
		stop();
		sb_h.report();
	endtask : run

	virtual task build();					//----> called in test_class
		gen_h 	 = 	new(gen2drv);
		drv_h 	 = 	new(gen2drv,wr_drv_if);
		wr_mon_h = 	new(wr2rm,wr_mon_if);
		rd_mon_h = 	new(mon2sb,rd_mon_if);
		rm_h 	 = 	new(wr2rm,rm2sb);
		sb_h 	 =	new(rm2sb,mon2sb);
	endtask : build

	virtual task stop();					// environment stops when the done is triggered 
		wait(sb_h.done.triggered); 
	endtask : stop
	
	virtual task start();
		gen_h.start();
		drv_h.start();
		wr_mon_h.start();
		rd_mon_h.start();
		rm_h.start();
		sb_h.start();
	endtask : start
	
endclass : counter_env
