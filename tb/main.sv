`timescale 1ns/1ps
`include "interface.sv"
`include "verification.sv"

module main;

    bit clk; 
    always #5 clk = ~clk;

    endmodule