module router (
    input wire clk,
    input wire reset,
    input wire in_valid,

    input wire [1:0] in_addr,
    input wire [7:0] in_data,

    output reg [7:0] out_data_0,
)