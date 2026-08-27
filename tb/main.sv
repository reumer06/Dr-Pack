`timescale 1ns/1ps
`include "interface.sv"

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

    `include "verification.sv"

    initial begin
        $dumpfile("sim/mesh.vcd");
        $dumpvars(0, main);

        inf.reset   = 1'b1;
        inf.isValid = 1'b0;
        #20; // delay 20 nanoseconds
        inf.reset   = 1'b0;

        fork 
            runMonitor();
        join_none

        runDriver(50);

        #100;

        if (errors == 0) begin
            $display("TESTS PASSED SUCCESSFULLY");
        end else begin
            $display("TEST FAILED: %0d ERRORS", errors);
        end

        $finish;
    end
endmodule