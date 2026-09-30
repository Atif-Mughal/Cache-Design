`timescale 1ns / 1ps

module Full_Way_Associative(clk, rst, address, hit, data);

 input clk, rst;
 input [15 : 0] address;
 output logic hit;
 output logic[31 : 0] data;
 logic [139 : 0] Cache[0 : 255];
 string Way;
 
 initial 
    begin
        for(int i = 0; i < 256; i++)
        begin
            $sformat(Way, "../init_files/way%0d.bin", way);
            $readmemb(Way, Cache, i, i);
        end
    end
       
always_ff@(negedge clk) 
    begin
        if(!rst) 
            begin
                data <= 0;
                hit <= 0;
            end
        for(int i = 0; i < 256; i++)
            begin
                if(address[15 : 4] == Cache[i][139 : 128])
                    begin
                        hit <= 1;
                        case(address[4 : 2])
                            2'd0:   data <= Cache[i][127 : 96];
                            2'd1:   data <= Cache[i][95 : 64];
                            2'd2:   data <= Cache[i][63 : 32];
                            2'd3:   data <= Cache[i][31 : 0];
                            default:    data <= 0;
                        endcase
                        break;
                    end
                else
                    begin
                        hit <= 0;
                        data <= 0;
                    end
            end
    end

endmodule