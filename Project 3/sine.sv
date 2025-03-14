`include "memory.sv"

// Sine top-level module

module top(
    input logic     clk, 
    output logic    _9b,    // D0
    output logic    _6a,    // D1
    output logic    _4a,    // D2
    output logic    _2a,    // D3
    output logic    _0a,    // D4
    output logic    _5a,    // D5
    output logic    _3b,    // D6
    output logic    _49a,   // D7
    output logic    _45a,   // D8
    output logic    _48b    // D9
);

    logic [8:0] address = 0;
    logic [9:0] data;
    logic [6:0] quarter_address; // 2^7
    logic [1:0] quarter; //2^2 for 4 parts
    logic [9:0] quarter_data; 


    assign quarter = address[8:7];

    always_comb begin
        case(quarter)
            2'b00, 2'b01: data = quarter_data; 
            2'b10, 2'b11: data = ~quarter_data + 1; // Invert
        endcase
    end

    always_comb begin
        case(quarter)
            2'b00: quarter_address = address[6:0]; //q1
            2'b01: quarter_address = 7'd127 - address[6:0]; //flip q1
            2'b10: quarter_address = address[6:0]; //invert q1
            2'b11: quarter_address = 7'd127 - address[6:0]; //flip inverted q1
        endcase
    end

    memory #(
        .INIT_FILE      ("sine.txt")
    ) u1 (
        .clk            (clk), 
        .read_address   (quarter_address), 
        .read_data      (quarter_data)
    );

    always_ff @(posedge clk) begin
        address <= address + 1;
    end

    assign {_48b, _45a, _49a, _3b, _5a, _0a, _2a, _4a, _6a, _9b} = data;

endmodule



    
    // always_comb begin
    //     case(quarter)
    //         2'b00, 2'b01: data = quarter_data; 
    //         2'b10, 2'b11: data = 10'd1023 - quarter_data; // Invert
    //     endcase
    // end





