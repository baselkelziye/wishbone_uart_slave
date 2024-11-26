# UART Wishbone Slave

This project implements a **UART Wishbone Slave** with the following features:
- **Baud Rate**: Fixed at **19200 bps**.
- **Configurable Data Bits**: Supports 5, 6, 7, or 8 bits.
- **Configurable Stop Bits**: 1 or 2 bits.

## Design Overview
The UART Wishbone Slave enables UART communication within a Wishbone-compliant system. It is tested and verified on real hardware using the **Basys3 FPGA**, with the provided constraint file tailored for this board.

### Key Registers
| Register Name | Address | Description                  |
|---------------|---------|------------------------------|
| `CTRL`        | 0x00    | Configure data/stop bits.    |
| `STATUS`      | 0x04    | Monitor UART status/errors.  |
| `RX_BUFFER`   | 0x08    | Read received data.          |
| `TX_BUFFER`   | 0x0C    | Load data to transmit.       |

## TODO
- **Configurable Baud Rate**: 
  - Add support for runtime configuration of the UART baud rate via Wishbone registers.
  - Implement a divider or clock adjustment mechanism to allow dynamic baud rate changes.
  - Update the `CTRL` register to include a field for specifying the desired baud rate.

## Testing
The `uart_test.v` Creates a loopback from the received Character and re-sends it. The design is tested on the `BASYS3` FPGA and on `PuTTY` software on the PC.


