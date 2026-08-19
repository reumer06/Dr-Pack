class Packet;
    rand bit [1:0] destination;
    rand bit [7:0] payload;

    constraint validDest {
        destination inside {[0:3]};
    }

    function void display(string tag);
        $display("[%s] Destination port: %0d | Payload: 0x%0h", tag, destination, payload);
    endfunction
endclass