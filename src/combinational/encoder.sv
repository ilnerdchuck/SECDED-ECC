//==============================================================================
// File Name: encoder.sv
// Author: Francesco Mignone - ilnerdchuck
// Description: SECDED Encoder (Combinational) implementation
// Created: 2025-11-9
//==============================================================================

`timescale 1ps/1ps
import SECDED_ECC_pkg::*;

module SECDED_Encoder_comb(
    input logic clk,
    input logic rst_n,
    input logic [63:0] data_in,
    output logic [71:0] data_out
);

// Just assign data and calculated parity bits to output
assign data_out = {mega_xor(data_in), data_in};

endmodule