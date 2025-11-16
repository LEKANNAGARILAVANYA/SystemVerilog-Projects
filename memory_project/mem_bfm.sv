class mem_bfm;
    mem_tx tx;
	virtual mem_intf vif;
	
	
	task run();	
			vif=top.pif;
		//	$display("bfm");
			forever begin
			mem_common::gen2bfm.get(tx);
			drive_tx(tx);
			tx.print("bfm_tx");
			mem_common::bfm_count++;
		end	
	endtask
	task drive_tx(input mem_tx tx);
		@(vif.bfm_mp.bfm_cb)
			vif.bfm_mp.bfm_cb.wr_rd    <=tx.wr_rd;
			vif.bfm_mp.bfm_cb.addr     <=tx.addr;
			if(tx.wr_rd==1) vif.bfm_mp.bfm_cb.wdata <=tx.wdata;
			//else tx.wdata  <=0;
			else vif.bfm_mp.bfm_cb.wdata<=0;
			vif.bfm_mp.bfm_cb.valid      <=1'b1;
			wait(vif.bfm_mp.bfm_cb.ready==1);
			if(tx.wr_rd==0) begin
				@(vif.bfm_mp.bfm_cb)
					tx.rdata <=vif.bfm_mp.bfm_cb.rdata;
			end		
			else tx.rdata <=0;
         @(vif.bfm_mp.bfm_cb) //if i didn't deassert to 0 i am not getting rdata
			vif.bfm_mp.bfm_cb.wr_rd<=0;
			vif.bfm_mp.bfm_cb.addr<=0;
			vif.bfm_mp.bfm_cb.wdata<=0;
		vif.bfm_mp.bfm_cb.valid<=0; 
	endtask		
endclass	
