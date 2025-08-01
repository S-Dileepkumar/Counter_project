class counter_trans;

rand bit load;
rand logic [3:0]data_in;
logic [3:0]dout;
rand bit mode;
rand bit rstn;

constraint con1{data_in inside{[0:11]};}
constraint con2{load dist{0:=8,1:=2};
		 		mode dist{0:=2,1:=8};
		 		rstn dist{0:=1,1:=9};}

static int trans_id;
//logic id;


function void display(input string message);

		
	$display("#-----------------------------------------------#");
		if(message == "Randomized Data") 
		begin
			$display("\t%s",message);
			$display("\tTransaction Id:%0d",trans_id);
			$display("\tLoad = %0d\n\tdata_in = %0d\n\tresetn = %0d\n\tmode = %0d\n",load,data_in,rstn,mode);
		end

	if(message == "from read monitor") 
		begin
			$display("\t%s",message);
			$display("\tdout: %0d",dout);
		end

	$display("#-----------------------------------------------#");
endfunction


endclass:counter_trans
