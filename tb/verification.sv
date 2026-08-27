`include "packet.sv"

bit [7:0] queueMem [0:3][0:255];
int writePtr [0:3];
int readPtr [0:3];
int count  [0:3];

int errors = 0;

task automatic runDriver(input int packetCount);
    Packet pkt;
    int port;

    // Reset pointers
    for (int k = 0; k < 4; k++) begin
        writePtr[k] = 0;
        readPtr[k]  = 0;
        count[k]    = 0;
    end

    for (int i = 0; i < packetCount; ++i) begin
        pkt     = new();
        pkt.randomizePkt();
        port    = pkt.destination;

        @(posedge inf.clk); // wait for clock to synchronize signal
        inf.isValid <= 1'b1;
        inf.inAddr  <= pkt.destination;
        inf.inData  <= pkt.payload;

        // Push into array memory
        queueMem[port][writePtr[port]] = pkt.payload;
        writePtr[port] = writePtr[port] + 1;
        count[port]    = count[port] + 1;

        pkt.display("DRIVER SEND");

        @(posedge inf.clk); 
        inf.isValid <= 1'b0;
    end
endtask

task automatic runMonitor();
    forever begin
        @(posedge inf.clk);
        for (int port = 0; port < 4; port++) begin
            if (inf.outValid[port]) begin
                bit [7:0] captured = inf.outData[port];
                $display("Monitor Catch: CAPTURED 0x%0h on PORT %0d", captured, port);
                checkData(port, captured);
            end
        end
    end
endtask

function automatic void checkData(int port, bit [7:0] actual);
    bit [7:0] expected;

    if (count[port] == 0) begin
        $display("ERROR: Unexpected Data 0x%0h Recieved on Port %0d", actual, port);
        errors++;
        return;
    end

    expected      = queueMem[port][readPtr[port]]; // Fetch oldest data byte from reference queue 

    // Update reference queue indices
    readPtr[port] = readPtr[port] + 1;
    count[port]   = count[port] - 1;

    if (actual !== expected) begin
        $display("ERROR: Port %0d Mismatch | Expected 0x%0h, Got 0x%0h", port, expected, actual);
        errors++;
    end else begin
        $display("SUCCESS: Port %0d Match found (0x%0h)", port, actual);
    end
endfunction