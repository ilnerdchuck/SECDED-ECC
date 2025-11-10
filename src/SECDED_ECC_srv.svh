//==============================================================================
// File Name: SECDED_ECC_srv.svh
// Author: Francesco Mignone - ilnerdchuck
// Description: SECDED functions package
// Created: 2025-11-9
//==============================================================================

`timescale 1ps/1ps
package SECDED_ECC_pkg;

// This SECDED encoding process is based on the M. Y Hsiao second table 
// for single error correction and double error detection.
// M. Y. Hsiao second Parity Matrix:
// 
//    |D0 |D1 |D2 |D3 |D4 |D5 |D6 |D7 |D8 |D9 |D10|D11|D12|D13|D14|D15|D16|D17|D18|D19|D20|D21|D22|D23|D24|D25|D26|D27|D28|D29|D30|D31| 
// P0 | x | x | x | x | x | x | x | x |   |   |   |   | x | x | x | x |   |   |   |   | x | x | x | x |   |   |   |   | x | x |   |   |
// P1 | x | x | x | x |   |   |   |   | x | x | x | x | x | x | x | x |   |   |   |   |   |   |   |   | x | x | x | x |   |   | x | x |
// P2 |   |   | x | x |   |   |   |   | x | x | x | x |   |   |   |   | x | x | x | x | x | x | x | x |   |   |   |   | x | x | x | x |
// P3 | x | x |   |   | x | x | x | x |   |   |   |   |   |   |   |   | x | x | x | x |   |   |   |   | x | x | x | x | x | x | x | x |
// P4 |   | x | x |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   |   |   |   |   |
// P5 |   | x | x |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   |   |   |   |
// P6 |   |   |   |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   | x | x |   |
// P7 |   |   |   |   |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   | x | x |   |
//    |D32|D33|D34|D35|D36|D37|D38|D39|D40|D41|D42|D43|D44|D45|D46|D47|D48|D49|D50|D51|D52|D53|D54|D55|D56|D57|D58|D59|D60|D61|D62|D63| 
// P0 |   | x | x |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   |   |   |   |   |
// P1 |   | x | x |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   |   |   |   |
// P2 |   |   |   |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   | x | x |   |
// P3 |   |   |   |   |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   |   |   | x |   | x | x |   |
// P4 | x | x | x | x | x | x | x | x |   |   |   |   | x | x | x | x |   |   |   |   |   |   |   |   | x | x | x | x |   |   | x | x |
// P5 | x | x | x | x |   |   |   |   | x | x | x | x | x | x | x | x |   |   |   |   | x | x | x | x |   |   |   |   | x | x |   |   |
// P6 | x | x |   |   | x | x | x | x |   |   |   |   |   |   |   |   | x | x | x | x | x | x | x | x |   |   |   |   | x | x | x | x |
// P7 |   |   | x | x |   |   |   |   | x | x | x | x |   |   |   |   | x | x | x | x |   |   |   |   | x | x | x | x | x | x | x | x |

// Function to compute the mega XOR for the parity bits
    parameter int N = 64;
    function automatic logic [7:0] mega_xor(input logic [N-1:0] data_in);
    logic [7:0] result;
    begin
        result = '0;    
        // Compute each parity bit based on the defined mega XOR pattern
        // P0
        //  0  1  2  3  4  5  6  7 12 13 14 15 20 21 22 23 28 29 33 34 36 40 44 48 52 56
        result[0] = ^{  data_in[0], data_in[1],
                        data_in[2], data_in[3],
                        data_in[4], data_in[5],
                        data_in[6], data_in[7],
                        data_in[12], data_in[13],
                        data_in[14], data_in[15],
                        data_in[20], data_in[21],
                        data_in[22], data_in[23],
                        data_in[28], data_in[29],
                        data_in[33], data_in[34],
                        data_in[36], data_in[40],
                        data_in[44], data_in[48],
                        data_in[52], data_in[56]};
        // P1
        //  0  1  2  3  8  9 10 11 12 13 14 15 24 25 26 27 30 31 33 34 37 41 45 49 53 57
        result[1] = ^{  data_in[0], data_in[1],
                        data_in[2], data_in[3],
                        data_in[8], data_in[9],
                        data_in[10], data_in[11],
                        data_in[12], data_in[13],
                        data_in[14], data_in[15],
                        data_in[24], data_in[25],
                        data_in[26], data_in[27],
                        data_in[30], data_in[31],
                        data_in[33], data_in[34],
                        data_in[37], data_in[41],
                        data_in[45], data_in[49],
                        data_in[53], data_in[57]};
        // P2
        //  2  3  8  9 10 11 16 17 18 19 20 21 22 23 28 29 30 31 38 42 46 50 54 55 58 61 62
        result[2] = ^{  data_in[2], data_in[3],
                        data_in[8], data_in[9],
                        data_in[10], data_in[11],
                        data_in[16], data_in[17],
                        data_in[18], data_in[19],
                        data_in[20], data_in[21],
                        data_in[22], data_in[23],
                        data_in[28], data_in[29],
                        data_in[30], data_in[31],
                        data_in[38], data_in[42],
                        data_in[46], data_in[50],
                        data_in[54], data_in[55],
                        data_in[58], data_in[61],
                        data_in[62]};
        // P3
        //  0  1  4  5  6  7 16 17 18 19 24 25 26 27 28 29 30 31 39 43 47 51 55 59 61 62
        result[3] = ^{  data_in[0], data_in[1],
                        data_in[4], data_in[6],
                        data_in[7], data_in[16],
                        data_in[17], data_in[18],
                        data_in[19], data_in[24],
                        data_in[25], data_in[26],
                        data_in[27], data_in[28],
                        data_in[29], data_in[30],
                        data_in[31], data_in[39],
                        data_in[43], data_in[47],
                        data_in[51], data_in[55],
                        data_in[59], data_in[61],
                        data_in[62]};
        // P4
        //  1  2  4  8 12 16 20 32 33 34 35 36 37 38 39 44 45 46 47 56 57 58 59 62 63
        result[4] = ^{  data_in[1], data_in[2],
                        data_in[4], data_in[8],
                        data_in[12], data_in[16],
                        data_in[20], data_in[32],
                        data_in[33], data_in[34],
                        data_in[35], data_in[36],
                        data_in[37], data_in[38],
                        data_in[39], data_in[44],
                        data_in[45], data_in[46],
                        data_in[47], data_in[56],
                        data_in[57], data_in[58],
                        data_in[59], data_in[62],
                        data_in[63]};
        // P5
        //  1  2  5  9 13 17 21 25 32 33 34 35 36 40 41 42 43 44 45 46 47 52 53 54 55 60 61
        result[5] = ^{  data_in[1], data_in[2],
                        data_in[5], data_in[9],
                        data_in[13], data_in[17],
                        data_in[21], data_in[25],
                        data_in[32], data_in[33],
                        data_in[34], data_in[35],
                        data_in[36], data_in[40],
                        data_in[41], data_in[42],
                        data_in[43], data_in[44],
                        data_in[45], data_in[46],
                        data_in[47], data_in[52],
                        data_in[53], data_in[54],
                        data_in[55], data_in[60],
                        data_in[61]};
        // P6
        //  6 10 14 18 22 26 29 30 32 33 36 37 38 39 48 49 50 51 52 53 54 55 60 61 62 63
        result[6] = ^{  data_in[6], data_in[10],
                        data_in[14], data_in[18],
                        data_in[22], data_in[26],
                        data_in[29], data_in[30],
                        data_in[32], data_in[33],
                        data_in[36], data_in[37],
                        data_in[38], data_in[39],
                        data_in[48], data_in[49],
                        data_in[50], data_in[51],
                        data_in[52], data_in[53],
                        data_in[54], data_in[55],
                        data_in[60], data_in[61],
                        data_in[62], data_in[63]};
        // P7
        //  7 11 15 19 23 27 29 30 34 35 40 41 42 43 48 49 50 51 56 57 58 59 60 61 62 63
        result[7] = ^{  data_in[7], data_in[11],
                        data_in[15], data_in[19],
                        data_in[23], data_in[27],
                        data_in[29], data_in[30],
                        data_in[34], data_in[35],
                        data_in[40], data_in[41],
                        data_in[42], data_in[43],
                        data_in[48], data_in[49],
                        data_in[50], data_in[51],
                        data_in[56], data_in[57],
                        data_in[58], data_in[59],
                        data_in[60], data_in[61],
                        data_in[62], data_in[63]};
        return result;
    end
    endfunction
    
// Function to map syndrome to error position
function automatic [71:0] syndrome_to_err_vector(input logic [7:0] syndrome);
    logic [71:0] err_vector;
    begin
        // Map syndrome to err_vector (0-71)
        case (syndrome)
            8'b00001011: err_vector = 72'h00_0000_0000_0000_0001;
            8'b00111011: err_vector = 72'h00_0000_0000_0000_0002;
            8'b00110111: err_vector = 72'h00_0000_0000_0000_0004;
            8'b00000111: err_vector = 72'h00_0000_0000_0000_0008;
            8'b00011001: err_vector = 72'h00_0000_0000_0000_0010;
            8'b00101001: err_vector = 72'h00_0000_0000_0000_0020;
            8'b01001001: err_vector = 72'h00_0000_0000_0000_0040;
            8'b10001001: err_vector = 72'h00_0000_0000_0000_0080;
            8'b00010110: err_vector = 72'h00_0000_0000_0000_0100;
            8'b00100110: err_vector = 72'h00_0000_0000_0000_0200;
            8'b01000110: err_vector = 72'h00_0000_0000_0000_0400;
            8'b10000110: err_vector = 72'h00_0000_0000_0000_0800;
            8'b00010011: err_vector = 72'h00_0000_0000_0000_1000;
            8'b00100011: err_vector = 72'h00_0000_0000_0000_2000;
            8'b01000011: err_vector = 72'h00_0000_0000_0000_4000;
            8'b10000011: err_vector = 72'h00_0000_0000_0000_8000;
            8'b00011100: err_vector = 72'h00_0000_0000_0001_0000;
            8'b00101100: err_vector = 72'h00_0000_0000_0002_0000;
            8'b01001100: err_vector = 72'h00_0000_0000_0004_0000;
            8'b10001100: err_vector = 72'h00_0000_0000_0008_0000;
            8'b00010101: err_vector = 72'h00_0000_0000_0010_0000;
            8'b00100101: err_vector = 72'h00_0000_0000_0020_0000;
            8'b01000101: err_vector = 72'h00_0000_0000_0040_0000;
            8'b10000101: err_vector = 72'h00_0000_0000_0080_0000;
            8'b00011010: err_vector = 72'h00_0000_0000_0100_0000;
            8'b00101010: err_vector = 72'h00_0000_0000_0200_0000;
            8'b01001010: err_vector = 72'h00_0000_0000_0400_0000;
            8'b10001010: err_vector = 72'h00_0000_0000_0800_0000;
            8'b00001101: err_vector = 72'h00_0000_0000_1000_0000;
            8'b11001101: err_vector = 72'h00_0000_0000_2000_0000;
            8'b11001110: err_vector = 72'h00_0000_0000_4000_0000;
            8'b00001110: err_vector = 72'h00_0000_0000_8000_0000;
            8'b01110000: err_vector = 72'h00_0000_0001_0000_0000;
            8'b01110011: err_vector = 72'h00_0000_0002_0000_0000;
            8'b10110011: err_vector = 72'h00_0000_0004_0000_0000;
            8'b10110000: err_vector = 72'h00_0000_0008_0000_0000;
            8'b01010001: err_vector = 72'h00_0000_0010_0000_0000;
            8'b01010010: err_vector = 72'h00_0000_0020_0000_0000;
            8'b01010100: err_vector = 72'h00_0000_0040_0000_0000;
            8'b01011000: err_vector = 72'h00_0000_0080_0000_0000;
            8'b10100001: err_vector = 72'h00_0000_0100_0000_0000;
            8'b10100010: err_vector = 72'h00_0000_0200_0000_0000;
            8'b10100100: err_vector = 72'h00_0000_0400_0000_0000;
            8'b10101000: err_vector = 72'h00_0000_0800_0000_0000;
            8'b00110001: err_vector = 72'h00_0000_1000_0000_0000;
            8'b00110010: err_vector = 72'h00_0000_2000_0000_0000;
            8'b00110100: err_vector = 72'h00_0000_4000_0000_0000;
            8'b00111000: err_vector = 72'h00_0000_8000_0000_0000;
            8'b11000001: err_vector = 72'h00_0001_0000_0000_0000;
            8'b11000010: err_vector = 72'h00_0002_0000_0000_0000;
            8'b11000100: err_vector = 72'h00_0004_0000_0000_0000;
            8'b11001000: err_vector = 72'h00_0008_0000_0000_0000;
            8'b01100001: err_vector = 72'h00_0010_0000_0000_0000;
            8'b01100010: err_vector = 72'h00_0020_0000_0000_0000;
            8'b01100100: err_vector = 72'h00_0040_0000_0000_0000;
            8'b01101000: err_vector = 72'h00_0080_0000_0000_0000;
            8'b10010001: err_vector = 72'h00_0100_0000_0000_0000;
            8'b10010010: err_vector = 72'h00_0200_0000_0000_0000;
            8'b10010100: err_vector = 72'h00_0400_0000_0000_0000;
            8'b10011000: err_vector = 72'h00_0800_0000_0000_0000;
            8'b11100000: err_vector = 72'h00_1000_0000_0000_0000;
            8'b11101100: err_vector = 72'h00_2000_0000_0000_0000;
            8'b11011100: err_vector = 72'h00_4000_0000_0000_0000;
            8'b11010000: err_vector = 72'h00_8000_0000_0000_0000;
            8'b00000001: err_vector = 72'h01_0000_0000_0000_0000;
            8'b00000010: err_vector = 72'h02_0000_0000_0000_0000;
            8'b00000100: err_vector = 72'h04_0000_0000_0000_0000;
            8'b00001000: err_vector = 72'h08_0000_0000_0000_0000;
            8'b00010000: err_vector = 72'h10_0000_0000_0000_0000;
            8'b00100000: err_vector = 72'h20_0000_0000_0000_0000;
            8'b01000000: err_vector = 72'h40_0000_0000_0000_0000;
            8'b10000000: err_vector = 72'h80_0000_0000_0000_0000;
            default: err_vector = 0; // No error or uncorrectable
        endcase
        return err_vector;
    end
endfunction

// Function to perform ECC with a given syndrome and data 
function automatic logic [71:0] ECC_correction(input logic [71:0] data_in, input logic [7:0] syndrome);
    logic [71:0] corrected_data, error_vector;
    begin
        // Determine error position from syndrome
        error_vector = syndrome_to_err_vector(syndrome);
        // Correct the data by flipping the erroneous bit
        corrected_data = data_in ^ error_vector;
        
        return corrected_data;
    end
    endfunction

endpackage
