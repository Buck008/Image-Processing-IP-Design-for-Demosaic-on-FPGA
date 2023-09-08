module Gaussian_filter(
    input clk,
    input [7:0] D,
    // input SW,
    output [7:0] G
	 
);

reg[7:0] D11,D12;
wire [7:0] D13;
reg[7:0] D21,D22;
wire [7:0] D23;
reg[7:0] D31,D32;
wire [7:0] D33;

linebuffer_3 u_linebuffer( 
    .clock(clk),
    .shiftin(D),
    .shiftout(),
    .taps0x(D13),
    .taps1x(D23),
    .taps2x(D33)
);

always @(posedge clk ) begin
    D12<=D13;
    D11<=D12;
end

always @(posedge clk ) begin
    D22<=D23;
    D21<=D22;
end
always @(posedge clk ) begin
    D32<=D33;
    D31<=D32;
end

wire [8:0] G_t; 


assign G_t = (D11[7:4] + D12[7:3] + D13[7:4] 
           + D21[7:3] + D22[7:2] + D23[7:3] 
           + D31[7:4] + D32[7:3] + D33[7:4]);


//assign G_t = D22;

assign G = G_t[8] ? 8'd255 : G_t[7:0];




/*
//wire [7:0] lineOut0;
//wire [7:0] lineOut1;
//wire [7:0] lineOut2;
wire [7:0] lineOut0;
wire [7:0] lineOut1;
wire [7:0] lineOut2;   
    linebuffer_3 line_inst( 
    .clock(clk),
    .shiftin(value),
    .shiftout(),
    .taps0x(lineOut0),
    .taps1x(lineOut1),
    .taps2x(lineOut2)
    );
    reg  rst =1'b1;
    reg  clk_en = 1'b1;
    wire [7:0] lineOut0_w = clk_en ? lineOut0 : 8'd0;
    wire [7:0] lineOut1_w = clk_en ? lineOut1 : 8'd0;
    wire [7:0] lineOut2_w = clk_en ? lineOut2 : 8'd0;

    wire[7:0] R1,R2,R3,R4,R5,R6,R7,R8,R9;

 

    register_20 #(.N(8)) u_register_20_r1 (.CLK(clk),.RESET(rst),.in(lineOut2),.CLK_en(clk_en),.out(R1));
    register_20 #(.N(8)) u_register_20_r2 (.CLK(clk),.RESET(rst),.in(R1),.CLK_en(clk_en),.out(R2));
    register_20 #(.N(8)) u_register_20_r3 (.CLK(clk),.RESET(rst),.in(R2),.CLK_en(clk_en),.out(R3));

    register_20 #(.N(8)) u_register_20_r4 (.CLK(clk),.RESET(rst),.in(lineOut1),.CLK_en(clk_en),.out(R4));
    register_20 #(.N(8)) u_register_20_r5 (.CLK(clk),.RESET(rst),.in(R4),.CLK_en(clk_en),.out(R5));
    register_20 #(.N(8)) u_register_20_r6 (.CLK(clk),.RESET(rst),.in(R5),.CLK_en(clk_en),.out(R6));

    register_20 #(.N(8)) u_register_20_r7 (.CLK(clk),.RESET(rst),.in(lineOut0),.CLK_en(clk_en),.out(R7));
    register_20 #(.N(8)) u_register_20_r8 (.CLK(clk),.RESET(rst),.in(R7),.CLK_en(clk_en),.out(R8));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
    register_20 #(.N(8)) u_register_20_r9 (.CLK(clk),.RESET(rst),.in(R8),.CLK_en(clk_en),.out(R9));
 

    wire [7:0] G1,G2,G3,G4,G5,G6,G7,G8,G9;

    assign G1 = {4'd0,R1[7:4]};
    assign G3 = {4'd0,R3[7:4]};
    assign G7 = {4'd0,R7[7:4]};
    assign G9 = {4'd0,R9[7:4]};

    assign G2 = {3'd0,R2[7:3]};
    assign G4 = {3'd0,R4[7:3]};
    assign G6 = {3'd0,R6[7:3]};
    assign G8 = {3'd0,R8[7:3]};

    assign G5 = {2'd0,R5[7:2]};

    assign value_Gau = G1 + G2 + G3 + G4 + G5 + G6 + G7 + G8 + G9;
*/
endmodule
