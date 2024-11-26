`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2024 09:42:07 AM
// Design Name: 
// Module Name: uart_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_test(
    input wire clk, reset,
    input wire rx,
    output wire tx
    );


    wire tx_full, rx_empty, btn_tick;
    wire [7:0] rec_data, rec_data1;
    reg rd_uart;

    always @(*) begin
        if(~rx_empty)
            rd_uart = 1'b1;
        else
            rd_uart = 1'b0;
        


    end
    

    uart uart_unit(
        .clk(clk), .reset(reset), .rd_uart(rd_uart), .wr_uart(rd_uart), .rx(rx), .w_data(rec_data1), .tx_full(tx_full), .rx_empty(rx_empty), 
        .rd_data(rec_data), .tx(tx)
    );


        assign rec_data1 = rec_data;

     
endmodule
