class fifo_sbd;
    wr_tx tx1;
	rd_tx tx2;
	int intq[$];
	int y;

	task run();
		forever begin
			tx1=new();
			tx2=new();
			fifo_common::wr_mon2sbd.get(tx1);	
			fifo_common::rd_mon2sbd.get(tx2);
	 		 if(tx1.wr_en==1) intq.push_back(tx1.wdata);
		 		if(tx2.rd_en==1) begin
		 			y=intq.pop_front();
					if(tx2.rdata==y) fifo_common::matchings++;
					else fifo_common::mismatchings++;
		     end	
	  end	
	endtask
endclass	
