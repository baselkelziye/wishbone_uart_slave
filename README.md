# UART Wishbone Slave

This project implements a **UART Wishbone Slave** with the following features:
- **Baud Rate**: Fixed at **19200 bps**.
- **Configurable Data Bits**: Supports 5, 6, 7, or 8 bits.
- **Configurable Stop Bits**: 1 or 2 bits.
- TX and RX FIFO buffer

## Design Overview
The UART Wishbone Slave enables UART communication within a Wishbone-compliant system. It is tested and verified on real hardware using the **Basys3 FPGA**, with the provided constraint file tailored for this board.

### Key Registers
| Register Name | Address | Description                  |
|---------------|---------|------------------------------|
| `CTRL`        | 0x00    | Configure baud rate          |
| `STATUS`      | 0x04    | Monitor TX and RX fifo status|
| `TX_DATA`     | 0x08    | Transmit data.               |
| `RX_DATA`     | 0x0C    | Receive data.                |

## Getting Started
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/uart-wishbone-slave.git
