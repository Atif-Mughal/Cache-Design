`timescale 1ns / 1ps

module Way_Associative(clk, rst, address, hit, data);

 input clk, rst;
 input [15 : 0] address;
 output logic hit;
 output logic[31 : 0] data;
 logic [134 : 0] Cache0[0 : 63];
 logic [134 : 0] Cache1[0 : 63];

 initial
        begin
			$readmemb("init_files/way0.bin", Cache0);
			$readmemb("init_files/way1.bin", Cache1);
        end   
always_ff@(negedge clk) 
    begin
        if(!rst) 
            begin
                data <= 0;
                hit <= 0;
            end
        else 
        begin 
            data <= 0;
            hit <= 0;
        end
        if((address[15 : 10] == Cache0[address[9 : 4]][133 : 128] && (Cache0[address[9 : 4]][134] == 1)))
            begin
                hit <= 1;
                case(address[3: 2])
                    2'd0:  data <= Cache0[address[9 : 4]][127 : 96];
                    2'd1: data <= Cache0[address[9 : 4]][95 : 64];
                    2'd2: data <= Cache0[address[9 : 4]][63 : 32];
                    2'd3: data <= Cache0[address[9 : 4]][31 : 0];
                    default:    data <= 0;
                endcase
            end 
        else if((address[15 : 10] == Cache1[address[9 : 4]][133 : 128] && (Cache1[address[9 : 4]][134] == 1)))
            begin
                hit <= 1;
                case(address[3: 2])
                    2'd0: data <= Cache1[address[9 : 4]][127 : 96];
                    2'd1: data <= Cache1[address[9 : 4]][95 : 64];
                    2'd2: data <= Cache1[address[9 : 4]][63 : 32];
                    2'd3: data <= Cache1[address[9 : 4]][31 : 0];
                    default:    data <= 0;
                endcase
            end
        else
            begin
                hit <= 0;
                data <= 0;
            end
    end

endmodule
