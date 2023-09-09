module RB_at_BR_Hamilton (
    input [9:0] D11,D12,D13,D14,D15,D16,D17,
    input [9:0] D21,D22,D23,D24,D25,D26,D27,
    input [9:0] D31,D32,D33,D34,D35,D36,D37,
    input [9:0] D41,D42,D43,D44,D45,D46,D47,
    input [9:0] D51,D52,D53,D54,D55,D56,D57,
    input [9:0] D61,D62,D63,D64,D65,D66,D67,
    input [9:0] D71,D72,D73,D74,D75,D76,D77,
    input  [9:0] g44,
    output [9:0] RB 
);
//wire [9:0] g44_;
wire [9:0] g35;
wire [9:0] g53;
wire [9:0] g33;
wire [9:0] g55;

wire [11:0] temp_D_45_half;//signed
wire [11:0] temp_D_135_half;//signed
wire [11:0] Delta_45;//unsigned
wire [11:0] Delta_135;//unsigned
assign temp_D_45_half = {g44,1'b0}-g35-g53;
assign temp_D_135_half = {g44,1'b0}-g33-g55;
assign Delta_45 = ((D35>D53)?(D35-D53):(D53-D35)) + (temp_D_45_half[11]? -temp_D_45_half : temp_D_45_half);
assign Delta_135 = ((D33>D55)?(D33-D55):(D55-D33)) + (temp_D_135_half[11]? -temp_D_135_half : temp_D_135_half);

wire [11:0] result_1;//signed
wire [11:0] result_2;//signed
wire [11:0] result_3;//signed
wire [11:0] result_;//signed
assign result_1 = D35[9:1]+D53[9:1]+g44-g35[9:1]-g53[9:1];
assign result_2 = D33[9:1]+D55[9:1]+g44-g33[9:1]-g55[9:1];
assign result_3 = D33[9:2]+D55[9:2]+D35[9:2]+D53[9:2]+g44-g35[9:2]-g53[9:2]-g33[9:2]-g55[9:2];

assign result_= (Delta_45<Delta_135)?result_1:(
                (Delta_45>Delta_135)?result_2:
                                     result_3);
assign RB = result_[11]?0:(result_[10]?10'h3FF:result_);
//等等其实好像没有频率优先
//频率优先的话就在这里例化，面积优先的话g44外面给进来
//G_at_RB_Hamilton u1_G_at_RB_Hamilton(
//    .D22(D22),.D23(D23),.D24(D24),.D25(D25),.D26(D26),
//    .D32(D32),.D33(D33),.D34(D34),.D35(D35),.D36(D36),
//    .D42(D42),.D43(D43),.D44(D44),.D45(D45),.D46(D46),
//    .D52(D52),.D53(D53),.D54(D54),.D55(D55),.D56(D56),
//    .D62(D62),.D63(D63),.D64(D64),.D65(D65),.D66(D66),
//    .G(g44_)
//); 

G_at_RB_Hamilton u1_G_at_RB_Hamilton(
    .D22(D13),.D23(D14),.D24(D15),.D25(D16),.D26(D17),
    .D32(D23),.D33(D24),.D34(D25),.D35(D26),.D36(D27),
    .D42(D33),.D43(D34),.D44(D35),.D45(D36),.D46(D37),
    .D52(D43),.D53(D44),.D54(D45),.D55(D46),.D56(D47),
    .D62(D53),.D63(D54),.D64(D55),.D65(D56),.D66(D57),
    .G(g35)
);

G_at_RB_Hamilton u2_G_at_RB_Hamilton(
    .D22(D31),.D23(D32),.D24(D33),.D25(D34),.D26(D35),
    .D32(D41),.D33(D42),.D34(D43),.D35(D44),.D36(D45),
    .D42(D51),.D43(D52),.D44(D53),.D45(D54),.D46(D55),
    .D52(D61),.D53(D62),.D54(D63),.D55(D64),.D56(D65),
    .D62(D71),.D63(D72),.D64(D73),.D65(D74),.D66(D75),
    .G(g53)
);

G_at_RB_Hamilton u3_G_at_RB_Hamilton(
    .D22(D11),.D23(D12),.D24(D13),.D25(D14),.D26(D15),
    .D32(D21),.D33(D22),.D34(D23),.D35(D24),.D36(D25),
    .D42(D31),.D43(D32),.D44(D33),.D45(D34),.D46(D35),
    .D52(D41),.D53(D42),.D54(D43),.D55(D44),.D56(D45),
    .D62(D51),.D63(D52),.D64(D53),.D65(D54),.D66(D55),
    .G(g33)
);

G_at_RB_Hamilton u4_G_at_RB_Hamilton(
    .D22(D33),.D23(D34),.D24(D35),.D25(D36),.D26(D37),
    .D32(D43),.D33(D44),.D34(D45),.D35(D46),.D36(D47),
    .D42(D53),.D43(D54),.D44(D55),.D45(D56),.D46(D57),
    .D52(D63),.D53(D64),.D54(D65),.D55(D66),.D56(D67),
    .D62(D73),.D63(D74),.D64(D75),.D65(D76),.D66(D77),
    .G(g55)
);

endmodule //RB_at_BR_Hamilton