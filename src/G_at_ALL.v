module G_at_ALL (
    input [9:0] D11,D12,D13,D14,D15,D16,D17,
    input [9:0] D21,D22,D23,D24,D25,D26,D27,
    input [9:0] D31,D32,D33,D34,D35,D36,D37,
    input [9:0] D41,D42,D43,D44,D45,D46,D47,
    input [9:0] D51,D52,D53,D54,D55,D56,D57,
    input [9:0] D61,D62,D63,D64,D65,D66,D67,
    input [9:0] D71,D72,D73,D74,D75,D76,D77,
    output [9:0] G13_RB,G23_G,G33_RB
);
//This module is used to compute all the green outputs that need to be computed and is the first level of the pipeline
G_at_RB_Hamilton g_23_G(
.D22(D23),.D23(D24),.D24(D25),.D25(D26),.D26(D27),
.D32(D33),.D33(D34),.D34(D35),.D35(D36),.D36(D37),
.D42(D43),.D43(D44),.D44(D45),.D45(D46),.D46(D47),
.D52(D53),.D53(D54),.D54(D55),.D55(D56),.D56(D57),
.D62(D63),.D63(D64),.D64(D65),.D65(D66),.D66(D67),
.G(G23_G)
);

G_at_RB_Hamilton g_33_RB(
    .D22(D33),.D23(D34),.D24(D35),.D25(D36),.D26(D37),
    .D32(D43),.D33(D44),.D34(D45),.D35(D46),.D36(D47),
    .D42(D53),.D43(D54),.D44(D55),.D45(D56),.D46(D57),
    .D52(D63),.D53(D64),.D54(D65),.D55(D66),.D56(D67),
    .D62(D73),.D63(D74),.D64(D75),.D65(D76),.D66(D77),
    .G(G33_RB)
);

G_at_RB_Hamilton u1_G_at_RB_Hamilton(
    .D22(D13),.D23(D14),.D24(D15),.D25(D16),.D26(D17),
    .D32(D23),.D33(D24),.D34(D25),.D35(D26),.D36(D27),
    .D42(D33),.D43(D34),.D44(D35),.D45(D36),.D46(D37),
    .D52(D43),.D53(D44),.D54(D45),.D55(D46),.D56(D47),
    .D62(D53),.D63(D54),.D64(D55),.D65(D56),.D66(D57),
    .G(G13_RB)
);

endmodule