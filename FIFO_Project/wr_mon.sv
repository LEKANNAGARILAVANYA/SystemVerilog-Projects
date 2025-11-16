class wr_mon;
	wr_tx tx;

	virtual fifo_intrf vif;

	task run();
		vif=tb.pif;
	//	$display("wr_mon");
		forever begin	
			@(posedge vif.wr_clk) 
				if(vif.wr_en==1) begin
					tx=new();
					tx.wr_en=vif.wr_en;
					tx.wdata=vif.wdata;
					@(negedge vif.wr_clk)
				    tx.full=vif.full;
					tx.overflow=vif.overflow;
					fifo_common::wr_mon2cov.put(tx);
					fifo_common::wr_mon2sbd.put(tx);
					tx.print("---wr_mon---");
			end	
      	end	
	endtask	
endclass	
