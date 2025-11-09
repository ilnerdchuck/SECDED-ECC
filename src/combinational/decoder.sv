`timescale 1ps/1ps

import SECDED_ECC_pkg::*;

module SECDED_Decoder_comb(
    input logic clk,
    input logic rst_n,
    input logic [71:0] data_in,
    output logic [71:0] data_out,
    output logic error_detected,
    output logic single_error,
    output logic double_error
);

// Internal signals
logic [71:0] BUFFER_DATA;
logic [7:0] syndrome;
logic [7:0] received_parity;
logic [7:0] calculated_parity;

// Parity & syndrome section
assign received_parity = data_in[71:64];
assign calculated_parity = mega_xor(data_in[63:0]);
assign syndrome = received_parity ^ calculated_parity;

// Error detection and correction
assign data_out = ECC_correction(data_in, syndrome);

assign error_detected = |syndrome;
assign single_error = ^syndrome & error_detected;
assign double_error = ~^syndrome & error_detected;

endmodule