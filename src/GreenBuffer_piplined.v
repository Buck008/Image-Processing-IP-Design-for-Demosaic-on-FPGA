module GreenBuffer_piplined (
    input [9:0] G13_tmp,
    input [9:0] G23_tmp,
    input [9:0] G33_tmp,
    input       clk,

    output reg [9:0] G11,
    output reg [9:0] G12,
    output reg [9:0] G13,

    output reg [9:0] G21,
    output reg [9:0] G22,
    output reg [9:0] G23,
    
    output reg [9:0] G31,
    output reg [9:0] G32,
    output reg [9:0] G33
    
);

always @(posedge clk) begin
    G13<=G13_tmp;
    G12<=G13;
    G11<=G12;
end


always @(posedge clk) begin
    G23<=G23_tmp;
    G22<=G23;
    G21<=G22;
end


always @(posedge clk) begin
    G33<=G33_tmp;
    G32<=G33;
    G31<=G32;
end

endmodule //GreenBuffer