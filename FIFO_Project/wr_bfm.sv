class wr_bfm;
	wr_tx tx;

    virtual fifo_intrf vif; 
	task run();
		vif=tb.pif;
	//	$display("wr_bfm");
		forever begin
		//	tx=new();
			fifo_common::wr_gen2bfm.get(tx);
			driver(tx);
			tx.print("wr_bfm");	
			fifo_common::wr_bfm_count++;
		end		
	endtask

	task driver(wr_tx tx);
		@(vif.wr_bfm_cb);
			vif.wr_bfm_cb.wr_en <=tx.wr_en;
			vif.wr_bfm_cb.wdata <=tx.wdata;
		//	vif.wr_bfm_cb.wdata <= tx.wr_en?tx.wdata:0;
	      	@(vif.wr_bfm_cb)
				vif.wr_bfm_cb.wr_en <= 0;
				vif.wr_bfm_cb.wdata <= 0;

			@(negedge vif.wr_clk)
				tx.full =vif.wr_bfm_cb.full;
				//	$display("%0t:-----%0b----",$time,vif.wr_bfm_cb.full);
				tx.overflow =vif.wr_bfm_cb.overflow;
			endtask	

endclass	
