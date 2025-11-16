module tb;
	bit wr_clk,rd_clk,res;
	
	fifo_intrf pif(wr_clk,rd_clk,res);

	async dut(.wr_clk(pif.wr_clk),
			  .rd_clk(pif.rd_clk),
			  .res(pif.res),
			  .wr_en(pif.wr_en),
			  .rd_en(pif.rd_en),
			  .wdata(pif.wdata),
			  .rdata(pif.rdata),
			  .full(pif.full),
			  .overflow(pif.overflow),
			  .empty(pif.empty),
			  .underflow(pif.underflow));

	
    always #5 wr_clk=~wr_clk;
	always #7 rd_clk=~rd_clk;

	fifo_env env;
	initial begin
		wr_clk=0;
		rd_clk=0;
		res=1;
		repeat(1) @(posedge wr_clk)
		res=0;
		$value$plusargs("test_name=%0s",fifo_common::test_name);
		env=new();
		env.run();
	end
	initial begin
		#1000;
		if(fifo_common::matchings!=0 && fifo_common::mismatchings==0) begin
			$display("test_passed");
			$display("matchings =%0d,mismatchings=%0d",fifo_common::matchings,fifo_common::mismatchings);  end
		else begin
			$display("test_failed");
			$display("matchings =%0d,mismatchings=%0d",fifo_common::matchings,fifo_common::mismatchings);  
end
		$finish;
	end	
	
endmodule	
