import counter_pkg::*;

class test;

virtual counter_if.WR_DRIVER_MP wr_driver_if;
virtual counter_if.WR_MON_MP wr_mon_if;
virtual counter_if.RD_MON_MP rd_mon_if;

counter_env  env_h;

function new(virtual counter_if.WR_DRIVER_MP wr_driver_if, virtual counter_if.WR_MON_MP wr_mon_if, virtual counter_if.RD_MON_MP rd_mon_if);

	this.wr_driver_if = wr_driver_if;
	this.rd_mon_if = rd_mon_if;
	this.wr_mon_if = wr_mon_if;
	env_h = new(wr_driver_if, wr_mon_if, rd_mon_if);

endfunction

task build_run();
	begin
		//no_of_trans = 2;
		env_h.build();  //----->from env
		env_h.run();	//----->from env
		$finish;
	end
endtask : build_run


endclass
