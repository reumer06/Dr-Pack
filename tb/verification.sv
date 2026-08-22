`include "packet.sv"

class Env;
    virtual router vif;

    bit [7:0] queues[4][$];
    int errors = 0;

    function new(virtual router vif);
        this.vif = vif;
    endfunction;
endclass;