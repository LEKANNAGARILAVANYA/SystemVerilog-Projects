class mem_sbd;
	mem_tx tx;
	int arr[int];

	task run();
		forever begin
			mem_common::mon2sbd.get(tx);
			if(tx.wr_rd==1) arr[tx.addr]=tx.wdata;
			else begin
				if(tx.wr_rd==0)
					if(tx.rdata==arr[tx.addr]) mem_common::d_matches++;
					else mem_common::mismatches++;
			end		
		//	tx.print("sbd_tx");
		end
	endtask	
endclass	
