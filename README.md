# Dr-Pack

Dr-Pack is a 1-to-4 hardware packet router.
It routes 8-bit input payloads to one of four output ports based on a 2-bit destination address and single-cycle valid handshaking signals.

It verifies whether all packets reach their destination failing the test if packet loss occurs and passing if none is detected.

> **Note:** This is an educational project to demonstrate fundamental RTL design.

## System Architecture

```text
                  +-----------------------+
                  |   Packet Generator    |
                  +-----------+-----------+
                              |
                              v
   +--------------------------+--------------------------+
   |                       TESTBENCH                     |
   |                                                     |
   |  +--------------+            +-------------------+  |
   |  | Driver Task  +----------->|     INTERFACE     |  |
   |  +------+-------+            |                   |  |
   |         |                    +---+-----------+---+  |
   |         |                        |           ^      |
   |         |                        |           |      |
   |         v                        v           |      |
   |  +------+-------+            +---+-----------+      |
   |  |  Scoreboard  |            |   DUT Router  |      |
   |  | (Queue Mem)  |            +-------+-------+      |
   |  +------+-------+                    |              |
   |         ^                            |              |
   |         |                            |    (Demux)   |
   |         |                            v              |
   |  +------+-------+            +-------+-------+      |
   |  | Monitor Task |<-----------| Output Ports  |      |
   |  +--------------+  (Capture) |     [0..3]    |      |
   |                              +---------------+      |
   +-----------------------------------------------------+
                              |
                              v
                  +-----------+-----------+
                  |        Result         |
                  +-----------------------+
```

---

## Quick Start

### Prerequisites

- **Icarus Verilog** (`iverilog` / `vvp`)
- **GTKWave** (waveform inspection)

### Build and Run

```bash
git clone https://github.com/reumer06/Dr-Pack
cd Dr-Pack
make all
make waves
```
