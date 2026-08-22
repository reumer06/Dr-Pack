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

    task runMonitor();
        forever begin
            @(posedge vif.clk);
            // check all 4 output channel every clock cycle
            for(int port = 0;port < 4;port++) begin
                if(vif.outValid[port]) begin
                    bit[7:0] captured_payload = vif.outData[port];
                    $display("MONITOR CATCH || CAPTURED 0x%0h on PORT %0d", captured_payload, port);
                    checkData(port,captured_payload);
                end 
            end
        end
    endtask

    function void checkData(int port,bit [7:0] actual);
        bit [7:0] expected;

        // if queue is empty
        if(queues[port].size() == 0) begin
            $display("ERROR: UNEXPECTED DATA 0x%0h RECIEVED ON PORT %0d",actual,port);
            errors++;
            return;
        end

        // pop the oldest expected value 
        expected = queues[port].pop_front();

        if (acutal !== expected) begin
            $display("ERROR: Port %0d Mismatch | Expected 0x%0h, Got 0x%0h",port,expected,actual);
        end else begin
            $display("SUCCESS: Port %0d Match found (0x%0h)",port,actual);
        end 
    endfunction
endclass