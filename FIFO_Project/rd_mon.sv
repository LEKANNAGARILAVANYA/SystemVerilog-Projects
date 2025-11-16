class rd_mon;
	rd_tx tx;

	virtual fifo_intrf vif;

	task run();
		vif=tb.pif;
		forever begin	
			@(vif.rd_mon_cb) 
				tx=new();
				tx.rd_en=vif.rd_mon_cb.rd_en;
				if(vif.rd_en==1) begin
				//	tx=new();
				//	tx.rd_en=vif.rd_en;
					tx.rdata=vif.rdata;
					@(negedge vif.rd_clk);
					tx.empty=vif.empty;
					tx.underflow=vif.underflow;
					fifo_common::rd_mon2cov.put(tx);
					fifo_common::rd_mon2sbd.put(tx);
					tx.print("---rd_mon---");
			end	
      	end	
	endtask	
endclass	
		
