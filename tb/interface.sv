interface router_if(input bit clk);
    logic        reset       ;
    logic        isValid     ;
    logic [1: 0] inAddr      ;
    logic  [7:0] inData      ;

    logic  [7:0] outData  [4];
    logic        outValid [4];
endinterface