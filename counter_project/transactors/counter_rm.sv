class counter_rm;

mailbox #(counter_trans) wr2rm;
mailbox #(counter_trans) rm2sb;

static bit [3:0]ref_count;

counter_trans data2rm,datarm2sb;

function new( mailbox #(counter_trans) wr2rm, mailbox #(counter_trans) rm2sb);
	this.wr2rm = wr2rm;
	this.rm2sb = rm2sb;
	this.datarm2sb = new;
endfunction

virtual task start();
	fork
		forever 
		begin
			wr2rm.get(data2rm);
			calculate(data2rm);

			datarm2sb.dout 		= ref_count;  // check again
			datarm2sb.mode 		= data2rm.mode;
			datarm2sb.load 		= data2rm.load;
			datarm2sb.data_in 	= data2rm.data_in;
			datarm2sb.rstn 		= data2rm.rstn;
													


			rm2sb.put(datarm2sb);
			
			$display("\n");
			$display("ref_count : %0d",ref_count);	
			$display("\n\nreference model packets-- \np1-data2rm :%0p \np2-datarm2sb:%0p",data2rm,datarm2sb);
			//$display("------------------------------------------------------------------");	
		end
	join_none
endtask : start

task calculate(counter_trans data2rm);
      		begin
      if(!data2rm.rstn)
        ref_count<=4'b0000;
      else if(data2rm.load)
        ref_count<=data2rm.data_in;
      else 
	wait(data2rm.load==0)  
	begin
		if(!data2rm.mode)
        		ref_count<=(ref_count==4'd11)?4'b0000:ref_count+1;
      		else
        		ref_count<=(ref_count==4'd0)?4'd11:ref_count-1;
    	end
	end
						//$display("IN task ref dout is %0d rst: %0d",ref_count,data2rm.rstn);
endtask : calculate


endclass : counter_rm
