class mem_cov;
	mem_tx tx;

	covergroup cg;
		option.per_instance=1;
		option.name="mem_cov";
		option.comment="this comment i put in covergroup";

	   WR_RD:coverpoint tx.wr_rd{
	   		option.weight=2;
			bins writes={1'b1};
	    	bins reads ={1'b0};
			option.comment="this comment i put in coverpoint in wr_rd";
			}

		ADDR:coverpoint tx.addr{
			option.weight=1;
			option.comment="this comment i put in coverpoint in addr";
		  //option.goal=50;
		  option.at_least=1;//every address need to hit atleast once
		  option.detect_overlap=1;
      	    bins addr0 = {5'd0};
			bins addr1 = {5'd1};
			bins addr2 = {5'd2};
			bins addr3 = {5'd3};
			bins addr4 = {5'd4};
			bins addr5 = {5'd5};
			bins addr6 = {5'd6};
			bins addr7 = {5'd7};
			bins addr8 = {5'd8};
			bins addr9 = {5'd9};
			bins addr10 = {5'd10};
			bins addr11 = {5'd11};
			bins addr12 = {5'd12};
			bins addr13 = {5'd13};
			bins addr14 = {5'd14};
			bins addr15 = {5'd15};
			bins addr16 = {5'd16};
			bins addr17 = {5'd17};
			bins addr18 = {5'd18};
			bins addr19 = {5'd19};
			bins addr20 = {5'd20};
			bins addr21 = {5'd21};
			bins addr22 = {5'd22};
			bins addr23 = {5'd23};
			bins addr24 = {5'd24};
			bins addr25 = {5'd25};
			bins addr26 = {5'd26};
			bins addr27 = {5'd27};
			bins addr28 = {5'd28};
			bins addr29 = {5'd29};
			bins addr30 = {5'd30};
			bins addr31 = {5'd31};

			//other ways to create bins
			//bins addr[15]={[0:31]};//static array
			//bins addr[]={[0:31]};//dynamic array
			//bins addr[]={[0:63]};//dynamic array 32 bins only
			//bins addr[] = {[0:31]} with (item%2!=0);
	  		// option.auto_bin_max=32;
	  		// bins addr0 = {[0:4]};
	  		// bins addr1 = {[3:8]};
	  		// bins addr2 = {[5:10]};
	  		// bins addr3 = {[9:15]};
	  		// bins addr4 = {[16:19]};
	  		// bins addr5 = {[20:23]};
	  		// bins addr6 = {[24:27]};
	  		// bins addr7 = {[28:31]};
	   }
	   cross WR_RD,ADDR{
	  	bins s=binsof(ADDR.addr26)|| binsof(ADDR.addr20);
	  	//	bins s=binsof(WR_RD.writes) && binsof(ADDR.addr20);
	   //	bins s=binsof(ADDR) intersect {[2:12]} ;
     }
	   cross tx.wr_rd, tx.addr;
	endgroup

	function new();
		cg=new();
	endfunction	
	
	task run();
    //	$display("coverage");
		forever begin
			mem_common::mon2cov.get(tx);
			tx.print("cov_tx");
			cg.sample();
		end
	endtask
endclass	
