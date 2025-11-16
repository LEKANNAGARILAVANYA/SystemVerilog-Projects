class mem_tx;
	rand bit wr_rd;
	randc bit[`ADDR_WIDTH-1:0]addr;
	rand bit[`WIDTH-1:0]wdata;
         bit[`WIDTH-1:0]rdata;
		 
		 function void print(string str);
		 	$display("%0t:----%0s----",$time,str);
		//	$display("wr_rd=%0s",wr_rd?"WRITE":"READ");
			$display("wr_rd=%0b",wr_rd);
			$display("addr=%d",addr);
			$display("wdata=%0d",wdata);	
			$display("rdata=%0d",rdata);
		endfunction
endclass		
	
