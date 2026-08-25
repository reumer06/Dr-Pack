SIM := iverilog
VVP := vvp
FLAGS := -g2012 -I tb

ROV := src/router.v
SRC := tb/main.sv
INCLUDE := tb/interface.sv tb/packet.sv tb/verification.sv

TARGET := sim/program.vvp

all: run

$(TARGET): $(SRC)
	$(SIM) -o $(TARGET) $(SRC)

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET)

.PHONY: all run clean