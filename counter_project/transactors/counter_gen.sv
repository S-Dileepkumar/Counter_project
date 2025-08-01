class counter_gen;

counter_trans datagen, data2drv;

mailbox #(counter_trans)  gen2drv;

function new(mailbox #(counter_trans)  gen2drv);
	this.gen2drv = gen2drv;
	this.datagen = new;
endfunction

virtual task start();
	fork 
		begin
			for(int i=0; i<no_of_trans; i++)
			begin 
				datagen.trans_id++;
			
				assert(datagen.randomize());
				datagen.display("Randomized Data");
				data2drv = new datagen;
				gen2drv.put(data2drv);
				
			end
		end
	join_none
endtask : start

endclass:counter_gen

