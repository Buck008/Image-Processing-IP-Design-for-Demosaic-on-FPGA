module RAW_RGB_Hamilton_advanced(
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


reg [9:0] G13_w, G23_w, G33_w;
wire [9:0] G13_G, G23_G, G33_G; 
wire [9:0] G13_RB, G23_RB, G33_RB;


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


wire [9:0] G11,G12,G21,G22,G31,G32;
GreenBuffer u_GreenBuffer(
    .G13(G13_w),
    .G23(G23_w),
    .G33(G33_w),
    .clk(CLK),
 
    .G11(G11),
    .G12(G12),
    .G21(G21),
    .G22(G22),
    .G31(G31),
    .G32(G32)
);



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

RB_at_BR_Hamilton_advanced u_RB_at_BR_Hamilton_advanced(
    .D11(D11),.D12(D12),.D13(D13),.D14(D14),.D15(D15),.D16(D16),.D17(D17),
    .D21(D21),.D22(D22),.D23(D23),.D24(D24),.D25(D25),.D26(D26),.D27(D27),
    .D31(D31),.D32(D32),.D33(D33),.D34(D34),.D35(D35),.D36(D36),.D37(D37),
    .D41(D41),.D42(D42),.D43(D43),.D44(D44),.D45(D45),.D46(D46),.D47(D47),
    .D51(D51),.D52(D52),.D53(D53),.D54(D54),.D55(D55),.D56(D56),.D57(D57),
    .D61(D61),.D62(D62),.D63(D63),.D64(D64),.D65(D65),.D66(D66),.D67(D67),
    .D71(D71),.D72(D72),.D73(D73),.D74(D74),.D75(D75),.D76(D76),.D77(D77),
    .g44(g),
    .G11(G11),.G12(G12),.G21(G21),.G22(G22),.G31(G31),.G32(G32),
    .G13(G13_RB),.G23(G23_RB),.G33(G33_RB),
    .RB(rb_at_BR)
);

G_at_RB_Hamilton u_G_at_RB_Hamilton(
    .D22(D22),.D23(D23),.D24(D24),.D25(D25),.D26(D26),
    .D32(D32),.D33(D33),.D34(D34),.D35(D35),.D36(D36),
    .D42(D42),.D43(D43),.D44(D44),.D45(D45),.D46(D46),
    .D52(D52),.D53(D53),.D54(D54),.D55(D55),.D56(D56),
    .D62(D62),.D63(D63),.D64(D64),.D65(D65),.D66(D66),
    .G(g)
);


RB_at_G_Hamilton_advanced u_RB_at_G_Hamilton_advanced(
    .D11(D11),.D12(D12),.D13(D13),.D14(D14),.D15(D15),.D16(D16),.D17(D17),
    .D21(D21),.D22(D22),.D23(D23),.D24(D24),.D25(D25),.D26(D26),.D27(D27),
    .D31(D31),.D32(D32),.D33(D33),.D34(D34),.D35(D35),.D36(D36),.D37(D37),
    .D41(D41),.D42(D42),.D43(D43),.D44(D44),.D45(D45),.D46(D46),.D47(D47),
    .D51(D51),.D52(D52),.D53(D53),.D54(D54),.D55(D55),.D56(D56),.D57(D57),
    .D61(D61),.D62(D62),.D63(D63),.D64(D64),.D65(D65),.D66(D66),.D67(D67),
    .D71(D71),.D72(D72),.D73(D73),.D74(D74),.D75(D75),.D76(D76),.D77(D77),
    .G11(G11),.G12(G12),.G21(G21),.G22(G22),.G31(G31),.G32(G32),
    .G13(G13_G),.G23(G23_G),.G33(G33_G),
    .out_r(r_at_G),
    .out_b(b_at_G)
);

always @(posedge CLK) begin
    if(!RST_N)begin
		R <= 0;
		G <= 0;
		B <= 0;
	end
	else begin
        case ({Y ,X })
        1:begin
            G<=D44;
            R<=b_at_G;
            B<=r_at_G;
        end
        0:begin
            G<=g;
            R<=D44;
            B<=rb_at_BR;
        end
        3:begin
            G<=g;
            R<=rb_at_BR;
            B<=D44;
        end
        2:begin
            G<=D44;
            R<=r_at_G;
            B<=b_at_G;
        end
        endcase
    end
end
endmodule