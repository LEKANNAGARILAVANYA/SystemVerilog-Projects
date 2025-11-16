class rd_gen;
	rd_tx tx;

	task run();
		//$display("rd_gen");
		case(fifo_common::test_name)
			"FULL": begin
			end	
			"EMPTY": begin	
				wait(fifo_common::wr_gen_count==fifo_common::wr_bfm_count) ;
					read(`FIFO_SIZE);
			end
			"OVERFLOW":begin
			end
			"UNDERFLOW":begin
				wait(fifo_common::wr_gen_count==fifo_common::wr_bfm_count) ;
					read(`FIFO_SIZE+1);
			end
		endcase
	endtask

	task read(input int N);
		repeat(N) begin
			tx=new();
			tx.randomize() with {tx.rd_en==1;}; 	
			tx.print("rd_gen");		
			fifo_common::rd_gen2bfm.put(tx);
		end
	endtask		

endclass	

