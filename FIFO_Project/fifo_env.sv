class fifo_env;
	wr_agent agent1;
	rd_agent agent2;
	fifo_sbd sbd;

	task run();
		agent1=new();
		agent2=new();
		sbd=new();

		fork 
			agent1.run();
			agent2.run();
			sbd.run();
		join
  endtask
endclass  
