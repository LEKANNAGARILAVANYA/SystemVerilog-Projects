class wr_gen;
	wr_tx tx;

	task run();
      //$display("wr_gen");
		case(fifo_common::test_name)
			"FULL": begin
				write(`FIFO_SIZE);
			end	
			"EMPTY": begin
				write(`FIFO_SIZE);
				end
			"OVERFLOW":begin
				write(`FIFO_SIZE+1);
			end
			"UNDERFLOW":begin
				write(`FIFO_SIZE);
			end
		endcase
	endtask

	task write(input int N);
		fifo_common::wr_gen_count = `FIFO_SIZE;
		repeat(N) begin
			tx=new();
			//fifo_common::wr_gen_count++;
			tx.randomize() with {tx.wr_en==1;}; 	
			tx.print("wr_gen");
			fifo_common::wr_gen2bfm.put(tx);
		end
	endtask		
endclass	

