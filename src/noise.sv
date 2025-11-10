//==============================================================================
// File Name: noise.sv
// Author: Francesco Mignone - ilnerdchuck
// Description: SECDED noise module
// Created: 2025-11-9
//==============================================================================

`timescale 1ps/1ps

module noise(
    input logic [71:0] data_in,
    output logic [71:0] data_out
);
// Simple noise model: flip a single bit for demonstration
assign data_out = data_in ^ 72'b000000000000010000000000000;

endmodule