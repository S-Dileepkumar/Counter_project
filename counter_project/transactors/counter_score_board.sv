class counter_sb;

	event done;
	
	mailbox #(counter_trans) rm2sb;
	mailbox #(counter_trans) mon2sb;

	counter_trans ref_data, rcv_data, cdata;
	static int  ref_count,rcv_count,data_verified;

	function new(mailbox #(counter_trans) rm2sb, mailbox #(counter_trans) mon2sb);
		this.rm2sb = rm2sb;
		this.mon2sb = mon2sb;
		count_coverage = new;
	endfunction

	virtual task start();
		fork 
			//begin
				forever
					begin
						rm2sb.get(ref_data);
						ref_count++;
						//$display("the trans from scoreboard");
						
					
						mon2sb.get(rcv_data);
						rcv_count++;
						compare(rcv_data);
					end 
			//end
		join_none
	endtask : start

	virtual task compare(counter_trans rcv_data);
	//	fork
			begin
				if(rcv_data.dout == ref_data.dout)
					begin $display("\n");	
					$display("# Dout is Matched between reference and read monitor--   \nref_data:%0p \nrcv_data:%0p",ref_data,rcv_data);
					$display("------------------------------------------------------------------");	
					cdata = new ref_data;
					count_coverage.sample();
					end
				else
					begin $display("\n");	
					$display("# Dout is Mismatched between reference and read monitor-- \nref_data:%0p \nrcv_data:%0p",ref_data,rcv_data);
					$display("------------------------------------------------------------------"); end	
			end
			data_verified++;

			if(data_verified >= no_of_trans)
				begin
					$display("# Event got Hit");
					->done;
				end 
		//join_none
	endtask : compare

	virtual function void report();
		$display("-------------------Scoreboard Report-------------------");
		$display("No of Transaction                             	- %0d",ref_data.trans_id);
		$display("No of Times Data Received in read monitor     	- %0d",rcv_count);
		$display("No of Times Data Generated in reference model 	- %0d",ref_count);
		$display("No of Times Data Verified                     	- %0d",data_verified);
		$display("-------------------------------------------------------");
	endfunction : report



covergroup count_coverage();
	option.per_instance=1;
	
	cp1 : coverpoint cdata.data_in{ bins b[] = {[0:11]};}

	cp2 : coverpoint cdata.mode;

	cp3 : coverpoint cdata.dout {	bins b1[] = {[0:11]};}


	cp4 : cross cp2,cdata.load;

endgroup

endclass : counter_sb

