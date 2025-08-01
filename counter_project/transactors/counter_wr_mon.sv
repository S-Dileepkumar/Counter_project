class counter_wr_mon;

	virtual counter_if.WR_MON_MP wr_mon_if;

	counter_trans data2rm;

	mailbox #(counter_trans) mon2rm;

	function new(mailbox #(counter_trans)  mon2rm,	virtual counter_if.WR_MON_MP wr_mon_if);
		this.wr_mon_if = wr_mon_if;
		this.mon2rm = mon2rm;
		this.data2rm = new;
	endfunction

	task start();
		fork
			forever 
			begin
			
				monitor();
								//$display("this is write monitor   %0p",data2rm);
				mon2rm.put(data2rm);
				
				$display("--------------\n\twrite_monitor \n\tdata to reference model %p \n------------",data2rm);		
								// need to write coverage 
			end
		join_none
	endtask : start

	task monitor();

		
		@(wr_mon_if.wr_mon_cb); 
		begin
								
		data2rm.load 	= wr_mon_if.wr_mon_cb.load; 
		data2rm.mode 	= wr_mon_if.wr_mon_cb.mode;
		data2rm.data_in = wr_mon_if.wr_mon_cb.data_in;
		data2rm.rstn 	= wr_mon_if.wr_mon_cb.rstn; 

	 
							
		end

	endtask : monitor
endclass : counter_wr_mon

