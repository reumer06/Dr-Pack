`timescale 1ns/1ps
`include "interface.sv"
`include "verification.sv"

module main;

    bit clk; 
    always #5 clk = ~clk;
    router_if inf(clk); 

    router dut ( 
        .clk(inf.clk),
        .reset(inf.reset),
        .isValid(inf.isValid),
        .inAddr(inf.inAddr),
        .inData(inf.inData),
        .outData0(inf.outData[0]), .outValid0(inf.outValid[0]),
        .outData1(inf.outData[1]), .outValid1(inf.outValid[1]),
        .outData2(inf.outData[2]), .outValid2(inf.outValid[2]),
        .outData3(inf.outData[3]), .outValid3(inf.outValid[3])
    );  

    Env env;

    intial begin
        $dumpfile("sim/mesh.vcd");
        $dumpvars(0, main);

        inf.reset = 1'b1;
        inf.isValid = 1'b0;
        #20;
        inf.reset = 1'b0;

        env = new(inf);
endmodule