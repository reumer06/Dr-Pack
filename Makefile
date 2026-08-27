SIM := iverilog
VVP := vvp
FLAGS := -g2012 -I tb

ROV := src/router.v
SRC := tb/main.sv
INCLUDE := tb/interface.sv tb/packet.sv tb/verification.sv

TARGET := sim/program.vvp

..PHONY: all run waves clean
all: run

$(TARGET): $(SRC) $(ROV) $(INCLUDE)
	@mkdir -p sim
	$(SIM) $(FLAGS) -o $(TARGET) $(ROV) $(SRC)

run: $(TARGET)
	$(VVP) $(TARGET)

waves:
	@if [ -f sim/mesh.vcd ]; then \
		gtkwave sim/mesh.vcd & \
	else \
		echo "ERROR: sim/mesh.vcd not found	"; \
	fi
clean:
	rm -rf sim program.vvp program
