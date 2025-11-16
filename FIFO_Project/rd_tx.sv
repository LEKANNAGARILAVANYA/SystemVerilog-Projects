class rd_tx;
	rand bit rd_en;
	     bit[`WIDTH-1:0]rdata;
		 bit empty;
		 bit underflow;

	function void print(input string str);
		$display("%0t :--------%s--------",$time,str);
		$display("rd_en=%b",rd_en);
		$display("rdata=%0d",rdata);
		$display("empty=%b",empty);
		$display("underflow=%b",underflow);
	endfunction
endclass	
