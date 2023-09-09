module RAW_RGB_Hamilton_piplined(
    input                   CLK , 
    input                   RST_N , 
    input [9:0]             D0,
    input [9:0]             D1,
    input [9:0]             D2,
    input [9:0]             D3,
    input [9:0]             D4,
    input [9:0]             D5,
    input [9:0]             D6,

    input                   X,
    input                   Y,

    output reg		[9:0]	R,
    output reg		[9:0]	G, 
    output reg		[9:0]	B
);

//7X7
reg  [9:0] D11,D12,D13,D14,D15,D16; 
reg  [9:0] D21,D22,D23,D24,D25,D26; 
reg  [9:0] D31,D32,D33,D34,D35,D36;
reg  [9:0] D41,D42,D43,D44,D45,D46;
reg  [9:0] D51,D52,D53,D54,D55,D56;
reg  [9:0] D61,D62,D63,D64,D65,D66; 
reg  [9:0] D71,D72,D73,D74,D75,D76; 

wire  [9:0] D17; 
wire  [9:0] D27; 
wire  [9:0] D37;
wire  [9:0] D47;
wire  [9:0] D57;
wire  [9:0] D67; 
wire  [9:0] D77; 

wire [9:0] g;
wire [9:0] r_at_G;
wire [9:0] b_at_G;
wire [9:0] rb_at_BR;

assign D17 = D0;
assign D27 = D1;
assign D37 = D2;
assign D47 = D3;
assign D57 = D4;
assign D67 = D5;
assign D77 = D6;

reg  [9:0] D11_nd,D12_nd,D13_nd,D14_nd,D15_nd,D16_nd,D17_nd; 
reg  [9:0] D21_nd,D22_nd,D23_nd,D24_nd,D25_nd,D26_nd,D27_nd; 
reg  [9:0] D31_nd,D32_nd,D33_nd,D34_nd,D35_nd,D36_nd,D37_nd;
reg  [9:0] D41_nd,D42_nd,D43_nd,D44_nd,D45_nd,D46_nd,D47_nd;
reg  [9:0] D51_nd,D52_nd,D53_nd,D54_nd,D55_nd,D56_nd,D57_nd;
reg  [9:0] D61_nd,D62_nd,D63_nd,D64_nd,D65_nd,D66_nd,D67_nd; 
reg  [9:0] D71_nd,D72_nd,D73_nd,D74_nd,D75_nd,D76_nd,D77_nd; 

always @(posedge CLK) begin
    D11_nd <= D11;
    D21_nd <= D21;
    D31_nd <= D31;
    D41_nd <= D41;
    D51_nd <= D51;
    D61_nd <= D61;
    D71_nd <= D71;

    D12_nd <= D12;
    D22_nd <= D22;
    D32_nd <= D32;
    D42_nd <= D42;
    D52_nd <= D52;
    D62_nd <= D62;
    D72_nd <= D72;

    D13_nd <= D13;
    D23_nd <= D23;
    D33_nd <= D33;
    D43_nd <= D43;
    D53_nd <= D53;
    D63_nd <= D63;
    D73_nd <= D73;

    D14_nd <= D14;
    D24_nd <= D24;
    D34_nd <= D34;
    D44_nd <= D44;
    D54_nd <= D54;
    D64_nd <= D64;
    D74_nd <= D74;

    D15_nd <= D15;
    D25_nd <= D25;
    D35_nd <= D35;
    D45_nd <= D45;
    D55_nd <= D55;
    D65_nd <= D65;
    D75_nd <= D75;
    
    D16_nd <= D16;
    D26_nd <= D26;
    D36_nd <= D36;
    D46_nd <= D46;
    D56_nd <= D56;
    D66_nd <= D66;
    D76_nd <= D76;

    D17_nd <= D17;
    D27_nd <= D27;
    D37_nd <= D37;
    D47_nd <= D47;
    D57_nd <= D57;
    D67_nd <= D67;
    D77_nd <= D77;
    
end



wire [9:0] G11,G12,G13;
wire [9:0] G21,G22,G23;
wire [9:0] G31,G32,G33;
reg [9:0] G13_w, G23_w, G33_w;
wire [9:0] G13_G, G23_G, G33_G;
wire [9:0] G13_RB, G23_RB, G33_RB;
assign G23_RB = D45;
assign G13_G = D35;
assign G33_G = D55;




G_at_ALL g_at_all(
    .D11(D11),.D12(D12),.D13(D13),.D14(D14),.D15(D15),.D16(D16),.D17(D17),
    .D21(D21),.D22(D22),.D23(D23),.D24(D24),.D25(D25),.D26(D26),.D27(D27),
    .D31(D31),.D32(D32),.D33(D33),.D34(D34),.D35(D35),.D36(D36),.D37(D37),
    .D41(D41),.D42(D42),.D43(D43),.D44(D44),.D45(D45),.D46(D46),.D47(D47),
    .D51(D51),.D52(D52),.D53(D53),.D54(D54),.D55(D55),.D56(D56),.D57(D57),
    .D61(D61),.D62(D62),.D63(D63),.D64(D64),.D65(D65),.D66(D66),.D67(D67),
    .D71(D71),.D72(D72),.D73(D73),.D74(D74),.D75(D75),.D76(D76),.D77(D77),
    .G13_RB(G13_RB),
    .G23_G (G23_G),
    .G33_RB(G33_RB)
);


always @(*) begin
    case ({Y ,X })
        1: begin
            G13_w=G13_G;
            G23_w=G23_G;
            G33_w=G33_G;
        end
        0: begin
            G13_w=G13_RB;
            G23_w=G23_RB;
            G33_w=G33_RB;
        end
        3: begin
            G13_w=G13_RB;
            G23_w=G23_RB;
            G33_w=G33_RB;
        end
        2: begin
            G13_w=G13_G;
            G23_w=G23_G;
            G33_w=G33_G;
        end
    endcase
end



GreenBuffer_piplined green_regs(
    .G13_tmp(G13_w),
    .G23_tmp(G23_w),
    .G33_tmp(G33_w),
    .clk(CLK),
 
    .G11(G11),
    .G12(G12),
    .G13(G13),

    .G21(G21),
    .G22(G22),
    .G23(G23),

    .G31(G31),
    .G32(G32),
    .G33(G33)
);



wire [9:0] G11_nd;
wire [9:0] G12_nd;
wire [9:0] G13_nd;
wire [9:0] G21_nd;
wire [9:0] G22_nd;
wire [9:0] G23_nd;
wire [9:0] G31_nd;
wire [9:0] G32_nd;
wire [9:0] G33_nd;

assign G11_nd = G11;
assign G12_nd = G12;
assign G13_nd = G13;
assign G21_nd = G21;
assign G22_nd = G22;
assign G23_nd = G23;
assign G31_nd = G31;
assign G32_nd = G32;
assign G33_nd = G33;



RB_at_BR_Hamilton_piplined u_RB_at_BR_Hamilton_piplined(
    .D11(D11_nd),.D12(D12_nd),.D13(D13_nd),.D14(D14_nd),.D15(D15_nd),.D16(D16_nd),.D17(D17_nd),
    .D21(D21_nd),.D22(D22_nd),.D23(D23_nd),.D24(D24_nd),.D25(D25_nd),.D26(D26_nd),.D27(D27_nd),
    .D31(D31_nd),.D32(D32_nd),.D33(D33_nd),.D34(D34_nd),.D35(D35_nd),.D36(D36_nd),.D37(D37_nd),
    .D41(D41_nd),.D42(D42_nd),.D43(D43_nd),.D44(D44_nd),.D45(D45_nd),.D46(D46_nd),.D47(D47_nd),
    .D51(D51_nd),.D52(D52_nd),.D53(D53_nd),.D54(D54_nd),.D55(D55_nd),.D56(D56_nd),.D57(D57_nd),
    .D61(D61_nd),.D62(D62_nd),.D63(D63_nd),.D64(D64_nd),.D65(D65_nd),.D66(D66_nd),.D67(D67_nd),
    .D71(D71_nd),.D72(D72_nd),.D73(D73_nd),.D74(D74_nd),.D75(D75_nd),.D76(D76_nd),.D77(D77_nd),
    .g44(G22_nd),
    .G11(G11_nd),.G12(G12_nd),.G13(G13_nd),
    .G21(G21_nd),.G22(G22_nd),.G23(G23_nd),
    .G31(G31_nd),.G32(G32_nd),.G33(G33_nd),
    .RB(rb_at_BR)
);



assign g = G22_nd;


RB_at_G_Hamilton_piplined u_RB_at_G_Hamilton_piplined(
    .D11(D11_nd),.D12(D12_nd),.D13(D13_nd),.D14(D14_nd),.D15(D15_nd),.D16(D16_nd),.D17(D17_nd),
    .D21(D21_nd),.D22(D22_nd),.D23(D23_nd),.D24(D24_nd),.D25(D25_nd),.D26(D26_nd),.D27(D27_nd),
    .D31(D31_nd),.D32(D32_nd),.D33(D33_nd),.D34(D34_nd),.D35(D35_nd),.D36(D36_nd),.D37(D37_nd),
    .D41(D41_nd),.D42(D42_nd),.D43(D43_nd),.D44(D44_nd),.D45(D45_nd),.D46(D46_nd),.D47(D47_nd),
    .D51(D51_nd),.D52(D52_nd),.D53(D53_nd),.D54(D54_nd),.D55(D55_nd),.D56(D56_nd),.D57(D57_nd),
    .D61(D61_nd),.D62(D62_nd),.D63(D63_nd),.D64(D64_nd),.D65(D65_nd),.D66(D66_nd),.D67(D67_nd),
    .D71(D71_nd),.D72(D72_nd),.D73(D73_nd),.D74(D74_nd),.D75(D75_nd),.D76(D76_nd),.D77(D77_nd),
    .G11(G11_nd),.G12(G12_nd),.G13(G13_nd),
    .G21(G21_nd),.G22(G22_nd),.G23(G23_nd),
    .G31(G31_nd),.G32(G32_nd),.G33(G33_nd),
    .out_r(r_at_G),
    .out_b(b_at_G)
);













// GreenBuffer u_GreenBuffer(
//     .G13(G13_w),
//     .G23(G23_w),
//     .G33(G33_w),
//     .clk(CLK),
 
//     .G11(G11),
//     .G12(G12),
//     .G21(G21),
//     .G22(G22),
//     .G31(G31),
//     .G32(G32)
// );


always @(posedge CLK) begin
    D16<=D17;
    D15<=D16;
    D14<=D15;
    D13<=D14;
    D12<=D13;
    D11<=D12;
end


always @(posedge CLK) begin
    D26<=D27;
    D25<=D26;
    D24<=D25;
    D23<=D24;
    D22<=D23;
    D21<=D22;
end

always @(posedge CLK) begin
    D36<=D37;
    D35<=D36;
    D34<=D35;
    D33<=D34;
    D32<=D33;
    D31<=D32;
end


always @(posedge CLK) begin
    D46<=D47;
    D45<=D46;
    D44<=D45;
    D43<=D44;
    D42<=D43;
    D41<=D42;
end

always @(posedge CLK) begin
    D56<=D57;
    D55<=D56;
    D54<=D55;
    D53<=D54;
    D52<=D53;
    D51<=D52;
end


always @(posedge CLK) begin
    D66<=D67;
    D65<=D66;
    D64<=D65;
    D63<=D64;
    D62<=D63;
    D61<=D62;
end

always @(posedge CLK) begin
    D76<=D77;
    D75<=D76;
    D74<=D75;
    D73<=D74;
    D72<=D73;
    D71<=D72;
end

reg X_nd, Y_nd;

always @(posedge CLK) begin
    X_nd <= X;
    Y_nd <= Y;
end



always @(posedge CLK) begin
    if(!RST_N)begin
		R <= 0;
		G <= 0;
		B <= 0;
	end
	else begin
        case ({Y_nd, X_nd})
        1:begin
            G<=D44_nd;
            R<=b_at_G;
            B<=r_at_G;
        end
        0:begin
            G<=g;
            R<=D44_nd;
            B<=rb_at_BR;
        end
        3:begin
            G<=g;
            R<=rb_at_BR;
            B<=D44_nd;
        end
        2:begin
            G<=D44_nd;
            R<=r_at_G;
            B<=b_at_G;
        end
        endcase
    end
end
endmodule