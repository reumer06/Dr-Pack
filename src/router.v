module router (
    input wire clk,
    input wire reset,
    input wire inValid,

    input wire [1:0] inAddr,
    input wire [7:0] inData,

    output reg [7:0] outData0,
    output reg outValid0,

    output reg[7:0] outData1,
    output reg outValid1,

    output reg[7:0] outData2,
    output reg outValid2,

    output reg[7:0] outData3,
    output reg outValid3,
);