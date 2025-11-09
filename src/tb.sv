// `include "encoder.sv"
// `include "decoder.sv"
// `include "./noise.sv"
`default_nettype none

module tb_encoder;
reg clk;
reg rst_n;

encoder 
(
    .rst_n (rst_n),
    .clk (clk),
    .data_in (64'hDEADBEEF_CAFECAFE),
    .data_out ()
    
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("tb_SECDED.vcd");
    $dumpvars(0, tb_encoder);
end

initial begin
    rst_n<=1;
    #(CLK_PERIOD*3) rst_n<=0;
    repeat(2) @(posedge clk);
    rst_n<=1;
    @(posedge clk);
    repeat(2) @(posedge clk);
    $finish(2);
end

endmodule
`default_nettype wire