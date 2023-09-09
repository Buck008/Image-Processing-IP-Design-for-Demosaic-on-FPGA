module GreenBuffer (
    input [9:0] G13,
    input [9:0] G23,
    input [9:0] G33,
    input       clk,

    output reg [9:0] G11,
    output reg [9:0] G12,
    output reg [9:0] G21,
    output reg [9:0] G22,
    output reg [9:0] G31,
    output reg [9:0] G32
    
);

always @(posedge clk) begin
    G12<=G13;
    G11<=G12;
end


always @(posedge clk) begin
    G22<=G23;
    G21<=G22;
end


always @(posedge clk) begin
    G32<=G33;
    G31<=G32;
end

endmodule //GreenBuffer