// Code your design here
/*module mod_12_coun(clk,load,rstn,mode,data_in,dout);
  
  input  clk,load,rstn,mode;
  input [3:0]data_in;
  output reg  [3:0] dout;
  
  always @(posedge clk)
  	begin
      if (!rstn)
        	dout <= 0;
      else  
        	begin
              if(load == 1)
                	dout <= data_in;
              else
                begin
                  if(mode == 0)
                    begin
                      if(dout == 11)
                        dout <= 0;
                      else 
			dout <= dout+1;
                    end
                  else
                    begin
                      if(dout == 0)
                        dout <= 11;
                      
                      else
			dout <= dout-1;
                    end
                end 
            end
      
    end
endmodule*/

module mod_12_coun(
  input clk,
  input rstn,
  input load,
  input mode,
  input [3:0]data_in,
  output reg [3:0]dout);
  
  always@(posedge clk)
    begin
      if(!rstn)
        dout<=4'b0000;
      else if(load)
        dout<=data_in;
      else if(!mode)
        dout<=(dout==4'd11)?4'b0000:dout+1;
      else
        dout<=(dout==4'd0)?4'd11:dout-1;
    end
endmodule 
