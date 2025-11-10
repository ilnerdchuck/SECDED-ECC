// `include "encoder.sv"
// `include "decoder.sv"
// `include "./noise.sv"
`timescale 1ps/1ps
module tb_SECDED_ECC_comb;
logic clk;
logic rst_n;
logic error_detected;
logic single_error;
logic double_error;

logic [63:0] enc_data_in;
logic [71:0] enc_data_out;
logic [71:0] noisy_data_out;
logic [71:0] dec_data_out;

// Instantiate Encoder
SECDED_Encoder_comb enc_DUT_comb(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(enc_data_in),
    .data_out(enc_data_out)
);

noise noise_DUT(
    .data_in(enc_data_out),
    .data_out(noisy_data_out)
);

// Instantiate Decoder
SECDED_Decoder_comb dec_DUT_comb(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(noisy_data_out),
    .data_out(dec_data_out),
    .error_detected(error_detected),
    .single_error(single_error),
    .double_error(double_error)
);

localparam CLK_PERIOD = 10;
initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end
initial begin
    $dumpfile("build/tb_SECDED_comb.vcd");
    $dumpvars(0, tb_SECDED_ECC_comb);
end

initial begin

    $monitor("TIME: %0t | ENC_IN: 0x%h | ENC_OUT: 0x%h | DEC_OUT: 0x%h | ERR_DET: %b | S_ERR: %b | D_ERR: %b", 
              $time, enc_data_in, enc_data_out, dec_data_out, error_detected, single_error, double_error);

    $display("Time %0t - LOG: Starting SECDED ECC Combinatorial Testbench",$time);
    $display("Time %0t - LOG: Apply Reset",$time);
    rst_n = 1;
    enc_data_in = 0;
    #(CLK_PERIOD/2) rst_n = 0;
    repeat(2) @(posedge clk);
    rst_n = 1;
    $display("Time %0t - LOG: Release Reset",$time);
    repeat(2) @(posedge clk);
    @(negedge clk);
    $display("---------------------------------------------------");
    $display("Time %0t - LOG: Start Applying Test Vectors",$time);
    $display("---------------------------------------------------");
    $display("Time %0t - LOG: Applying Test Vector 1: 0xDEADBEEF_CAFECAFE",$time);
    enc_data_in = 64'hDEADBEEF_CAFECAFE;
    repeat(2) @(negedge clk);
    no_error_1: assert (dec_data_out[63:0] == enc_data_in) else $error("Assertion no_error failed!");
    $display("Time %0t - LOG: Test Vector 1 Passed",$time);
    $display("---------------------------------------------------");
    $display("Time %0t - LOG: Applying Test Vector 2: 0x12345678_9ABCDEF0",$time);
    enc_data_in = 64'h12345678_9ABCDEF0;
    repeat(2) @(negedge clk);
    no_error_2: assert (dec_data_out[63:0] == enc_data_in) else $error("Assertion no_error failed!");
    $display("Time %0t - LOG: Test Vector 2 Passed",$time);
    $display("---------------------------------------------------");
    $display("Time %0t - LOG: All Test Vectors Passed",$time);  
    $finish(2);
end

endmodule
`default_nettype wire