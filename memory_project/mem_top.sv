
`include "mem_common.sv"
`include "mem_intf.sv"
`include "mem.v"
`include "mem_assert.sv"
`include "mem_tx.sv"
`include "mem_gen.sv"
`include "mem_bfm.sv"
`include "mem_mon.sv"
`include "mem_cov.sv"
`include "mem_sbd.sv"
`include "mem_agent.sv"
`include "mem_env.sv"


module top;
	reg clk,res;

	//interface
	mem_intf pif(clk,res);

	//dut instance
	// memory dut (.clk(pif.clk),
	// 		.res(pif.res),
	//		.valid(pif.valid),
	//		.ready(pif.ready),
	//		.wdata(pif.wdata),
	//		.rdata(pif.rdata),
	//		.wr_rd(pif.wr_rd),
	//		.addr(pif.addr));
 memory dut(pif.design_mp);

	mem_assert uut(.clk(pif.clk),
		 		   .res(pif.res),
			       .valid(pif.valid),
				   .ready(pif.ready),
			       .wdata(pif.wdata),
			       .rdata(pif.rdata),
			       .wr_rd(pif.wr_rd),
			       .addr(pif.addr));


   always #5 clk=~clk;

	mem_env env;	
   initial begin
   //$display("top");
   	clk=0;
   	res=1;
	repeat(2)@(posedge clk)
	res=0;
//	if($value$plusargs("test_name=%0s",mem_common::test_case));
//	if($value$plusargs("N=%0d",mem_common::N));

    env=new();
	env.run();
   end
   initial begin
   	#30;//initial both counts 0 so it will end 
   //	#1000; //instead of doing this we automate 
   	wait(mem_common::gen_count==mem_common::bfm_count);
	#50;
	if(mem_common::d_matches!=0 && mem_common::mismatches==0) begin
	$display("test_passed");
	$display("matches=%0d",mem_common::d_matches); end
	else begin
	$display("failed");
	$display("mismatches=%0d",mem_common::mismatches);
	end
	$finish;
	end
endmodule 


