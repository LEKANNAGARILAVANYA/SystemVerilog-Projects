class mem_gen;
	mem_tx tx,temp,tempq[$];
	 
	task run();
		case(mem_common::test_case)
			"1wr":begin
					mem_common::gen_count=1;
					tx=new();
					assert(tx.randomize() with {tx.wr_rd==1;})
					tx.print("write");
					mem_common::gen2bfm.put(tx);
			end
			"5wr":begin
					mem_common::gen_count=5;
			        tx=new();//because of randc we allocated outside the block
					repeat(5) begin	
						assert(tx.randomize() with {tx.wr_rd==1;})
						tx.print("write");
						mem_common::gen2bfm.put(tx);
			
			        end
			end
			"1wr_1rd":begin
					mem_common::gen_count=2;
			            //write
						tx=new();
						assert(tx.randomize() with {tx.wr_rd==1;})
						tx.print("write_happen");
                        mem_common::gen2bfm.put(tx);
						//read
						temp=tx;
						tx=new();
						assert(tx.randomize() with {tx.wr_rd==0;tx.addr==temp.addr;wdata==0;})
						tx.print("read_happen");
					    mem_common::gen2bfm.put(tx);
			
			end
			"5wr_5rd":begin
					mem_common::gen_count=10;
			            tx=new();
						repeat(5) begin
							//write
							assert(tx.randomize() with {tx.wr_rd==1;})
							tx.print("write_happen");
							temp=new tx;
							tempq.push_back(temp);
							mem_common::gen2bfm.put(temp);
						end
						repeat(5) begin
                       		 //read
					   		 temp=tempq.pop_front();
					   		 tx=new();
					   		 assert(tx.randomize() with {tx.wr_rd==0;tx.addr==temp.addr;wdata==0;})
					   		 tx.print("read_happen");
							 mem_common::gen2bfm.put(tx);
						end
			end
			"Nwr_Nrd":begin
					mem_common::gen_count=2*(mem_common::N);
			            tx=new();
					  	repeat(mem_common::N) begin
							//write
						    assert(tx.randomize() with {tx.wr_rd==1;})
							tx.print("write_happen");
							temp=new tx;
							tempq.push_back(temp);
							mem_common::gen2bfm.put(temp);
						end
						repeat(mem_common::N) begin
                       	 	//read
					   	    temp=tempq.pop_front();
					   	 	tx=new();
					   	 	assert(tx.randomize() with {tx.wr_rd==0;tx.addr==temp.addr;wdata==0;})
					   	 	tx.print("read_happen");
							mem_common::gen2bfm.put(tx);
						end
			end 
		endcase	
	endtask
endclass

