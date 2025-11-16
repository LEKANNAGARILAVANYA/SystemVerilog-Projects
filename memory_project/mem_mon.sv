class mem_mon;
	mem_tx tx;

	virtual mem_intf vif;

	task run();
	//$display("monitor");
		vif=top.pif;
		forever begin
			@(vif.mon_cb);
			if(vif.mon_cb.valid==1 && vif.mon_cb.ready==1) begin
					tx=new();
					tx.wr_rd=vif.mon_cb.wr_rd;
					tx.addr=vif.mon_cb.addr;
					if(vif.mon_cb.wr_rd==1) begin
						tx.wdata=vif.mon_cb.wdata;
						tx.rdata=0;
					end	
					else  begin
						tx.wdata=0;
						@(vif.mon_cb);
							tx.rdata=vif.mon_cb.rdata;
					end	
				mem_common::mon2cov.put(tx);	
				mem_common::mon2sbd.put(tx);	
				tx.print("mon_tx");	
			end
		end
	endtask
endclass	
