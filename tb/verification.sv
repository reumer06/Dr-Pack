`include "packet.sv"

class Env;
    virtual router vif;

    bit [7:0] queues[4][$];
    int errors = 0;
endclass;