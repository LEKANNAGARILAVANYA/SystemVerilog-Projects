class rd_cov;
	rd_tx tx;

   covergroup cg;
   		coverpoint tx.rd_en{
		ignore_bins writes={1'b0};
			bins reads = {1'b1};
			}
	endgroup
	function new();
		cg=new();
	endfunction	

	task run();
    // $display("rd_cov");
		forever begin
			fifo_common::rd_mon2cov.get(tx);
				tx.print("rd_cov");
				cg.sample();
			end
	endtask
endclass	
