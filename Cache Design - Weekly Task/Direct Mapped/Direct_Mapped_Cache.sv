`timescale 1ns / 1ps

module Direct_Mapped_Cache(clk, rst, address, hit, data);

 input clk, rst;
 input [15 : 0] address;
 output logic hit;
 output logic[31 : 0] data;
 logic [132 : 0] Cache [0 : 255];

 
 initial begin
 $readmemb("way0.bin", Cache);
 end
 
 always_ff@(negedge clk) begin
    if(!rst) begin
//        for(int i = 0; i < 256; i++)
//            Cache[i] <= 0;
                data <=32'b0;
                hit <=1'b0;
    end
     else if(address[15 : 12] == Cache[address[11 : 4]][131 : 128] && Cache[address[11 : 4]][132] == 1 ) begin
     hit=1'b1;
        case(address[3 : 2]) 
            2'd3:
                begin
                    data <= Cache[address[11 : 4]][31 : 0];
                    //hit <= 1;
                end
            2'd2: begin
                 data = Cache[address[11 : 4]][63 : 32];
                 //hit <= 1;
            end
            2'd1: begin
                data <= Cache[address[11 : 4]][95 : 64];
                //hit <= 1;
            end
            2'd0: begin
                data = Cache[address[11 : 4]][127 : 96];
                //hit <= 1;
            end
        default: begin
            //hit <= 0;
            data <= 0;
        end
        endcase
     
     end
 
         else
         begin
         hit <= 0;
         data <= 0;
         end
 
 
 end


endmodule
