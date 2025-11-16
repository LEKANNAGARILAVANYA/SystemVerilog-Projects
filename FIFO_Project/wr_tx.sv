class wr_tx;
	rand bit wr_en;
	rand bit[`WIDTH-1:0]wdata;
		 bit full;
		 bit overflow;

	function void print(input string str);
		$display("%0t :--------%s--------",$time,str);
		$display("wr_en=%b",wr_en);
		$display("wdata=%0d",wdata);
		$display("full=%b",full);
		$display("overflow=%b",overflow);
	endfunction
endclass	
