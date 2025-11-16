module mem_assert(clk,res,wr_rd,valid,ready,wdata,rdata,addr);
	input clk,res,wr_rd,valid,ready;
	input [`WIDTH-1:0]wdata,rdata;
	input[`ADDR_WIDTH-1:0]addr;

	property reset;
		@(posedge clk) (res==1) |-> ##0(wr_rd==0 && valid==0 && ready==0 && wdata==0 && rdata==0 && addr==0);
	endproperty
 	RESET: assert property(reset);

	property preset;
		@(posedge clk) (res==0) |-> ##0((!($isunknown(wr_rd))) && (!($isunknown(valid))) && (!($isunknown(ready))) && (!($isunknown(wdata))) && (!($isunknown(rdata))) && (!($isunknown(addr))));
	endproperty
 PRESET:assert property(preset);

	property handshaking;
		@(posedge clk) (valid==1) |-> ##1 (ready==1);
	endproperty
  HANDSHAKING: assert property(handshaking);

	property writes;
		@(posedge clk) (wr_rd==1) |-> ##0 ((!($isunknown(wdata))) && (!($isunknown(addr))));
    endproperty 
	WRITES: assert property(writes);

	property reads;
		@(posedge clk) (wr_rd==0) |-> ##0 (!($isunknown(rdata))) && (!($isunknown(addr)));
	endproperty
	READS:assert property(reads);

	property hand;
		@(posedge clk) (valid==0) |-> ##1 (ready==0);
	endproperty
	HAND:assert property(hand);
endmodule 	

