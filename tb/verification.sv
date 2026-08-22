`include "packet.sv"

class Env;
    virtual router vif;

    bit [7:0] queues[4][$];
    int errors = 0;

    function new(virtual router vif);
        this.vif = vif;
    endfunction

    task runDriver(int packetCount);
        Packet pkt;
        for(int i = 0;i < packetCount;++i) begin
            pkt = new();
            if(!pkt.randomize()) $fatal("Randomization failed");

            @(posedge vif.clk);
            vif.isValid <= 1'b1;
            vif.inAddr <= pkt.destination;
            vif.inData <= pkt.payload;

            queues[pkt.destination].push_back(pkt.payload);
            pkt.display("DRIVER SEND");

            @(posedge vif.clk);
            vif.isValid <= 1'b0; 
        end
    endtask
endclass