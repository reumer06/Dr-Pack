SIM = iverilog
TARGET = program
SRC = src/router.v

all: run

$(TARGET): $(SRC)
	$(SIM) -o $(TARGET) $(SRC)

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET)

.PHONY: all run clean