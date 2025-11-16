interface mem_intf(input reg clk,res);
	bit wr_rd,valid,ready;
	bit[`ADDR_WIDTH-1:0]addr;
	bit[`WIDTH-1:0]wdata,rdata;

	clocking bfm_cb@(posedge clk);
		default input#0 output#1;
			input ready,rdata;
			output wr_rd,addr,wdata,valid;
	endclocking

	clocking mon_cb@(posedge clk);
		default input#1;
			input ready,rdata,wr_rd,addr,wdata,valid;
	endclocking	

	modport design_mp(
		input clk,
		input res,
		input wr_rd,
		input wdata,
		input valid,
		input addr,
		output rdata,
		output ready
	);
	modport bfm_mp(
		clocking bfm_cb
		);
		

endinterface

