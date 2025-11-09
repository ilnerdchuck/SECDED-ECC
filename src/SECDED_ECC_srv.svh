package SECDED_ECC_pkg;

// The SECDED encoding process is based on the M. Y Hsiao second table 
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
        //TODO: fix bit positions according to Hsiao's matrix
        // Compute each parity bit based on the defined mega XOR pattern
        // P0
        result[0] = ^{  data_in[1], data_in[2],
                        data_in[5], data_in[7],
                        data_in[10], data_in[11],
                        data_in[14], data_in[15],
                        data_in[18], data_in[19],
                        data_in[22], data_in[23],
                        data_in[26], data_in[27],
                        data_in[30], data_in[31],
                        data_in[34], data_in[35],
                        data_in[38], data_in[39],
                        data_in[41], data_in[43],
                        data_in[45], data_in[47],
                        data_in[49], data_in[51],
                        data_in[53], data_in[55],
                        data_in[57], data_in[59],
                        data_in[61], data_in[63]};
        // P1
        result[1] = ^{  data_in[1], data_in[2],
                        data_in[5], data_in[7],
                        data_in[10], data_in[11],
                        data_in[14], data_in[15],
                        data_in[18], data_in[19],
                        data_in[22], data_in[23],
                        data_in[26], data_in[27],
                        data_in[30], data_in[31],
                        data_in[34], data_in[35],
                        data_in[38], data_in[39],
                        data_in[41], data_in[43],
                        data_in[45], data_in[47],
                        data_in[49], data_in[51],
                        data_in[53], data_in[55],
                        data_in[57], data_in[59],
                        data_in[61], data_in[63]};
        // P2
        result[2] = ^{  data_in[1], data_in[2],
                        data_in[5], data_in[7],
                        data_in[10], data_in[11],
                        data_in[14], data_in[15],
                        data_in[18], data_in[19],
                        data_in[22], data_in[23],
                        data_in[26], data_in[27],
                        data_in[30], data_in[31],
                        data_in[34], data_in[35],
                        data_in[38], data_in[39],
                        data_in[41], data_in[43],
                        data_in[45], data_in[47],
                        data_in[49], data_in[51],
                        data_in[53], data_in[55],
                        data_in[57], data_in[59],
                        data_in[61], data_in[63]};
        // P3
        result[3] = ^{  data_in[1], data_in[2],
                        data_in[5], data_in[7],
                        data_in[10], data_in[11],
                        data_in[14], data_in[15],
                        data_in[18], data_in[19],
                        data_in[22], data_in[23],
                        data_in[26], data_in[27],
                        data_in[30], data_in[31],
                        data_in[34], data_in[35],
                        data_in[38], data_in[39],
                        data_in[41], data_in[43],
                        data_in[45], data_in[47],
                        data_in[49], data_in[51],
                        data_in[53], data_in[55],
                        data_in[57], data_in[59],
                        data_in[61], data_in[63]};
        // P4
        result[4] = ^{  data_in[1], data_in[2],
                        data_in[5], data_in[7],
                        data_in[10], data_in[11],
                        data_in[14], data_in[15],
                        data_in[18], data_in[19],
                        data_in[22], data_in[23],
                        data_in[26], data_in[27],
                        data_in[30], data_in[31],
                        data_in[34], data_in[35],
                        data_in[38], data_in[39],
                        data_in[41], data_in[43],
                        data_in[45], data_in[47],
                        data_in[49], data_in[51],
                        data_in[53], data_in[55],
                        data_in[57], data_in[59],
                        data_in[61], data_in[63]};
        // P5
        result[5] = ^{  data_in[1], data_in[2],
                            data_in[5], data_in[7],
                            data_in[10], data_in[11],
                            data_in[14], data_in[15],
                            data_in[18], data_in[19],
                            data_in[22], data_in[23],
                            data_in[26], data_in[27],
                            data_in[30], data_in[31],
                            data_in[34], data_in[35],
                            data_in[38], data_in[39],
                            data_in[41], data_in[43],
                            data_in[45], data_in[47],
                            data_in[49], data_in[51],
                            data_in[53], data_in[55],
                            data_in[57], data_in[59],
                            data_in[61], data_in[63]};
        // P6
        result[6] = ^{  data_in[1], data_in[2],
                        data_in[5], data_in[7],
                        data_in[10], data_in[11],
                        data_in[14], data_in[15],
                        data_in[18], data_in[19],
                        data_in[22], data_in[23],
                        data_in[26], data_in[27],
                        data_in[30], data_in[31],
                        data_in[34], data_in[35],
                        data_in[38], data_in[39],
                        data_in[41], data_in[43],
                        data_in[45], data_in[47],
                        data_in[49], data_in[51],
                        data_in[53], data_in[55],
                        data_in[57], data_in[59],
                        data_in[61], data_in[63]};
        // P7
        result[7] = ^{  data_in[1], data_in[2],
                        data_in[5], data_in[7],
                        data_in[10], data_in[11],
                        data_in[14], data_in[15],
                        data_in[18], data_in[19],
                        data_in[22], data_in[23],
                        data_in[26], data_in[27],
                        data_in[30], data_in[31],
                        data_in[34], data_in[35],
                        data_in[38], data_in[39],
                        data_in[41], data_in[43],
                        data_in[45], data_in[47],
                        data_in[49], data_in[51],
                        data_in[53], data_in[55],
                        data_in[57], data_in[59],
                        data_in[61], data_in[63]};
        return result;
    end
    endfunction
    
// Function to map syndrome to error position
function automatic [71:0] syndrome_to_err_vector(input logic [7:0] syndrome);
    logic [71:0] err_vector;
    begin
        // Map syndrome to bit err_vector (0-71)
        //TODO: Complete the mapping according to Hsiao's matrix
        case (syndrome)
            8'b00000001: err_vector = 0;
            8'b00000010: err_vector = 1;
            8'b00000100: err_vector = 2;
            8'b00001000: err_vector = 3;
            8'b00010000: err_vector = 4;
            8'b00100000: err_vector = 5;
            8'b01000000: err_vector = 6;
            8'b10000000: err_vector = 7;
            default: err_vector = 0; // No error or uncorrectable
        endcase
        return err_vector;
    end
endfunction

// Function to perform ECC with a given syndrome and data 
function automatic logic [71:0] correct_data(input logic [71:0] data_in, input logic [7:0] syndrome);
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