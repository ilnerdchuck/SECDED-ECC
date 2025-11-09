import SECDED_ECC_pkg::*;

module SECDED_Encoder(
    input logic clk,
    input logic rst_n,
    input logic [63:0] data_in,
    output logic [71:0] data_out
);

/*
       |---|
       | b |
-data->| u |
       | f |
-clk-->| f |--------> data_out
       | e |
       | r |
       |---|
       | e |
 mega_xor-> | r |
       |---|

*/

// Internal signals
logic [71:0] BUFFER;

// Output assignments
assign data_out = BUFFER;

// Sequential logic to compute parity bits and store data into buffer
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) 
        BUFFER <= '0;
    else begin
        BUFFER[63:0] <= data_in;
        // Calculate parity bits
        BUFFER[71:64] <= mega_xor(data_in);
    end
end

endmodule