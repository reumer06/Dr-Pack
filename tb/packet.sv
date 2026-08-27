class Packet;
    bit [1:0] destination;
    bit [7:0] payload;

    function void randomizePkt();
        this.destination = $urandom_range(0, 3);
        this.payload     = $urandom();
    endfunction

    function void display(string tag);
        $display("[%s] Destination port: %0d | Payload: 0x%0h", tag, destination, payload);
    endfunction
endclass