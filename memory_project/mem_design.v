//`define WIDTH 8
//`define DEPTH 32
//`define ADDR_WIDTH $clog2(`DEPTH)

/*module memory(clk,res,valid,ready,wdata,rdata,wr_rd,addr);
   input clk,res,valid,wr_rd;
   input [`WIDTH-1:0]wdata;
   input [`ADDR_WIDTH-1:0]addr;
   
   output reg [`WIDTH-1:0]rdata;
   output reg ready;
   
   reg [`WIDTH-1:0]mem[`DEPTH-1:0];
   integer i;
       always@(posedge clk)begin //synchronous active high reset
            if(res==1)begin      
                 ready=0;
                 rdata=0;
                 for(i=0; i<`DEPTH; i=i+1)begin
                  mem[i]=0;end
              end
            else begin
               if (valid==1)begin //valid
                   ready=1;
                   if(wr_rd==1) //write operation
                      mem[addr]=wdata;
                   else  //read operation
                     rdata=mem[addr];
               end
               else
                  ready=0;
            end
       end
endmodule */

module memory(mem_intf.design_mp mp);
      
   reg [`WIDTH-1:0]mem[`DEPTH-1:0];
   integer i;
       always@(posedge mp.clk)begin //synchronous active high reset
            if(mp.res==1)begin      
                 mp.ready=0;
                 mp.rdata=0;
                 for(i=0; i<`DEPTH; i=i+1)begin
                  mem[i]=0;end
              end
            else begin
               if (mp.valid==1)begin //valid
                   mp.ready=1;
                   if(mp.wr_rd==1) //write operation
                      mem[mp.addr]=mp.wdata;
                   else  //read operation
                     mp.rdata=mem[mp.addr];
               end
               else
                  mp.ready=0;
            end
       end
endmodule 




 


 




 


 
