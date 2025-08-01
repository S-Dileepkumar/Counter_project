class counter_rd_mon;

	virtual counter_if.RD_MON_MP rd_mon_if;

	counter_trans data2sb;

	mailbox #(counter_trans) mon2sb;

	function new(mailbox #(counter_trans)  mon2sb,	virtual counter_if.RD_MON_MP rd_mon_if);
		this.mon2sb 	= mon2sb;
		this.rd_mon_if 	= rd_mon_if;
		this.data2sb 	= new;
	endfunction

	task start();
		fork
			forever 
			begin			// need to rdite coverage 
				monitor();
				$display("--------------\n\twrite_monitor \n\tdata to scoreboard %p \n------------",data2sb);
				mon2sb.put(data2sb);
				
								
			end
		join_none
	endtask : start

	task monitor();
		
		@(rd_mon_if.rd_mon_cb);
		begin
							
			data2sb.dout = rd_mon_if.rd_mon_cb.dout;
																		
		end

	endtask : monitor
endclass : counter_rd_mon


