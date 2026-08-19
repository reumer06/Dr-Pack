module router(
    input  wire       clk      ,
    input  wire       reset    ,
    input  wire       isValid  ,

    input  wire [1:0] inAddr   ,
    input  wire [7:0] inData   ,

    output reg  [7:0] outData0 ,
    output reg        outValid0,

    output reg  [7:0] outData1 ,
    output reg        outValid1,

    output reg  [7:0] outData2 ,
    output reg        outValid2,

    output reg  [7:0] outData3 ,
    output reg        outValid3
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // clear all data registers and valid flags
            outData0 <= 8'h00; outValid0 <= 1'b0;
            outData1 <= 8'h00; outValid1 <= 1'b0;
            outData2 <= 8'h00; outValid2 <= 1'b0;
            outData3 <= 8'h00; outValid3 <= 1'b0;
        end else begin
            // lower all valid flags
            outValid0 <= 1'b0;
            outValid1 <= 1'b0;
            outValid2 <= 1'b0;
            outValid3 <= 1'b0;

            if (isValid) begin
                case(inAddr)
                    2'b00 : begin
                        outData0  <= inData;
                        outValid0 <= 1'b1;
                    end
                    2'b01 : begin
                        outData1  <= inData;
                        outValid1 <= 1'b1;
                    end
                    2'b10 : begin
                        outData2  <= inData;
                        outValid2 <= 1'b1;
                    end
                    2'b11 : begin
                        outData3  <= inData;
                        outValid3 <= 1'b1;
                    end
                endcase
            end
        end
    end
endmodule