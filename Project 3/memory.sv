// Sample memory module

module memory #(
    parameter INIT_FILE = ""
)(
    input logic     clk,
    input logic     [6:0] read_address, //change to 218
    output logic    [9:0] read_data
);

    // change to 218
    logic [9:0] sample_memory [0:217];

    initial if (INIT_FILE) begin
        $readmemh(INIT_FILE, sample_memory);
    end

    always_ff @(posedge clk) begin
        read_data <= sample_memory[read_address];
    end

endmodule




