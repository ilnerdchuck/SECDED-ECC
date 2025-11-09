import SECDED_ECC_pkg::*;

module SECDED_Decoder(
    input logic clk,
    input logic rst_n,
    input logic [71:0] data_in,
    output logic [63:0] data_out,
    output logic error_detected,
    output logic single_error,
    output logic double_error
);

// Internal signals
logic [71:0] BUFFER_DATA;
logic [7:0] SYNDROME;
logic [7:0] received_parity;
logic [7:0] calculated_parity;

assign received_parity = data_in[71:64];
assign calculated_parity = mega_xor(data_in[63:0]);

// Output assignments
assign error_detected = |SYNDROME;
assign single_error = ^SYNDROME & error_detected;
assign double_error = ~^SYNDROME & error_detected;
assign data_out = ECC_correction(BUFFER_DATA, SYNDROME);

assign data_out = BUFFER_DATA;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        BUFFER_DATA <= '0;
        SYNDROME <= '0;
    end else begin
        BUFFER_DATA <= data_in;
        SYNDROME <= received_parity ^ calculated_parity;
    end
end


endmodule