`timescale 1ns / 1ps

module uart_tb;

  // Testbench Parameters
  parameter c_CLOCK_PERIOD_NS = 10;   // 100 MHz clock = 10 ns period
  parameter c_BIT_PERIOD      = 52083; // 19200 baud = 52.083 us in ns

  // Testbench Signals
  reg clk = 0;
  reg reset = 1;
  reg rx = 1;             // UART RX line, starts idle
  reg rd_uart = 0;        // Read request for RX FIFO
  reg wr_uart = 0;        // Write request for TX FIFO
  reg [7:0] w_data = 8'h00; // Data to write to TX FIFO
  wire tx;                // UART TX line
  wire [7:0] rd_data;     // Data read from RX FIFO
  wire tx_full, tx_empty, rx_full, rx_empty;

  // Instantiate the UART module
  uart uut (
    .clk(clk),
    .reset(reset),
    .rd_uart(rd_uart),
    .wr_uart(wr_uart),
    .rx(rx),
    .w_data(w_data),
    .tx_full(tx_full),
    .rx_empty(rx_empty),
    .tx(tx),
    .tx_empty(tx_empty),
    .rx_full(rx_full),
    .rd_data(rd_data)
  );

  // Clock Generation
  always #(c_CLOCK_PERIOD_NS / 2) clk = ~clk;

  // UART Task: Simulates RX by sending a byte serially
  task UART_WRITE_BYTE;
    input [7:0] i_Data;
    integer ii;
    begin
      // Send Start Bit (low)
      rx <= 1'b0;
      #(c_BIT_PERIOD);

      // Send Data Bits (LSB first)
      for (ii = 0; ii < 8; ii = ii + 1) begin
        rx <= i_Data[ii];
        #(c_BIT_PERIOD);
      end

      // Send Stop Bit (high)
      rx <= 1'b1;
      #(c_BIT_PERIOD);
    end
  endtask

  // Testbench Procedure
  initial begin
    // Reset the system
    clk = 0;
    reset = 1;
    rd_uart = 0;
    wr_uart = 0;
    rx = 1; // RX idle state
    w_data = 8'h00;

    // Apply reset
    #100;
    reset = 0;

    // Transmitter Test: Write data to TX FIFO
    @(posedge clk);
    w_data = 8'hA5; // First byte to transmit
    wr_uart = 1;
    @(posedge clk);
    wr_uart = 0;

    // Wait for TX FIFO to empty
    wait (tx_empty == 1);

    // Receiver Test: Send data over RX line
    @(posedge clk);
    UART_WRITE_BYTE(8'h3C); // Send byte 0x3C
    wait (rx_empty == 0);   // Wait for RX FIFO to fill

    // Read the received data
    @(posedge clk);
    rd_uart = 1;
    @(posedge clk);
    rd_uart = 0;

    // Verify received data
    if (rd_data !== 8'h3C)
      $display("Test Failed - Received: %h, Expected: 3C", rd_data);
    else
      $display("Test Passed - Correct Byte Received: %h", rd_data);

    // End of simulation
    $stop;
  end

endmodule
