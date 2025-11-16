interface fifo_intrf(input wr_clk,rd_clk,res);
	bit wr_en,rd_en;
	bit full,overflow,underflow,empty;
	bit [`WIDTH-1:0]wdata,rdata;

	clocking wr_bfm_cb @(posedge wr_clk);
		default input #0 output #1;
	
	    input full,overflow;
		output wr_en,wdata;
   endclocking

	clocking rd_bfm_cb @(posedge rd_clk);
		default input #0 output #1;
	
	    output rd_en;
		input rdata,empty,underflow;
   endclocking

	clocking wr_mon_cb @(posedge wr_clk);
		default input #1;
	
	    input rd_en,rdata,empty,underflow;
   endclocking

	clocking rd_mon_cb @(posedge rd_clk);
		default input #1;
	
	    input rd_en,rdata,empty,underflow;
   endclocking

   	property reset;
		@(posedge wr_clk) (res==1) |-> ##0(wr_en==0 && rd_en==0 && rdata==0 && full==0 && overflow==0 && underflow==0 && empty==1 && dut.wr_ptr==0 && dut.rd_ptr==0);
	endproperty
 	RESET: assert property(reset);


endinterface	
