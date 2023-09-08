module RB_at_G_Hamilton (
    input [9:0] D11,D12,D13,D14,D15,D16,D17,
    input [9:0] D21,D22,D23,D24,D25,D26,D27,
    input [9:0] D31,D32,D33,D34,D35,D36,D37,
    input [9:0] D41,D42,D43,D44,D45,D46,D47,
    input [9:0] D51,D52,D53,D54,D55,D56,D57,
    input [9:0] D61,D62,D63,D64,D65,D66,D67,
    input [9:0] D71,D72,D73,D74,D75,D76,D77,
    output [9:0] out_r, 
    output [9:0] out_b
);


wire [9:0] g_i_m1_j;
wire [9:0] g_i_p1_j;
wire [9:0] g_i_j_m1;
wire [9:0] g_i_j_p1;


G_at_RB_Hamilton G_i_m1_j(
.D22(D12),.D23(D13),.D24(D14),.D25(D15),.D26(D16),
.D32(D22),.D33(D23),.D34(D24),.D35(D25),.D36(D26),
.D42(D32),.D43(D33),.D44(D34),.D45(D35),.D46(D36),
.D52(D42),.D53(D43),.D54(D44),.D55(D45),.D56(D46),
.D62(D52),.D63(D53),.D64(D54),.D65(D55),.D66(D56),
.G(g_i_m1_j));

G_at_RB_Hamilton G_i_p1_j(
.D22(D32),.D23(D33),.D24(D34),.D25(D35),.D26(D36),
.D32(D42),.D33(D43),.D34(D44),.D35(D45),.D36(D46),
.D42(D52),.D43(D53),.D44(D54),.D45(D55),.D46(D56),
.D52(D62),.D53(D63),.D54(D64),.D55(D65),.D56(D66),
.D62(D72),.D63(D73),.D64(D74),.D65(D75),.D66(D76),
.G(g_i_p1_j)
);



G_at_RB_Hamilton G_i_j_m1(
.D22(D21),.D23(D22),.D24(D23),.D25(D24),.D26(D25),
.D32(D31),.D33(D32),.D34(D33),.D35(D34),.D36(D35),
.D42(D41),.D43(D42),.D44(D43),.D45(D44),.D46(D45),
.D52(D51),.D53(D52),.D54(D53),.D55(D54),.D56(D55),
.D62(D61),.D63(D62),.D64(D63),.D65(D64),.D66(D65),
.G(g_i_j_m1)
);


G_at_RB_Hamilton G_i_j_p1(
.D22(D23),.D23(D24),.D24(D25),.D25(D26),.D26(D27),
.D32(D33),.D33(D34),.D34(D35),.D35(D36),.D36(D37),
.D42(D43),.D43(D44),.D44(D45),.D45(D46),.D46(D47),
.D52(D53),.D53(D54),.D54(D55),.D55(D56),.D56(D57),
.D62(D63),.D63(D64),.D64(D65),.D65(D66),.D66(D67),
.G(g_i_j_p1)
);


// wire [10:0] delta_H_G_b_left ;
// wire [10:0] delta_H_G_b_right;
// wire [10:0] delta_H_G_r_up ;
// wire [10:0] delta_H_G_r_down ;
// wire [10:0] delta_H_B_b_left ;
// wire [10:0] delta_H_B_b_right;
// wire [10:0] delta_H_R_r_up ;
// wire [10:0] delta_H_R_r_down ;
// wire [10:0] delta_H_left ;
// wire [10:0] delta_H_right;
// wire [10:0] delta_H_up;
// wire [10:0] delta_H_down;

// wire [10:0] delta_G_row_b_left;
// //LEFT HALF OF DELTA H
// assign delta_H_G_b_left = (D44 > D42)?({1'b0,D44}-{1'b0,D42}):({1'b0,D42}-{1'b0,D44});
// assign delta_H_G_b_right = (D44 > D46)?({1'b0,D44}-{1'b0,D46}):({1'b0,D46}-{1'b0,D44});
// assign delta_H_G_r_up = (D33 > D35)?({1'b0,D33}-{1'b0,D35}):({1'b0,D35}-{1'b0,D33});
// assign delta_H_G_r_down = (D53 > D55)?({1'b0,D53}-{1'b0,D55}):({1'b0,D55}-{1'b0,D53});


// //RIGHT HALF OF DELTA H

// assign delta_H_B_b_left = ({D43,1'b0} > ({1'b0,D41}+{1'b0,D45}))?({D43,1'b0}-({1'b0,D41}+{1'b0,D45})):(({1'b0,D41}+{1'b0,D45})-{D43,1'b0});
// assign delta_H_B_b_right = ({D45,1'b0} > ({1'b0,D43}+{1'b0,D47}))?({D45,1'b0}-({1'b0,D43}+{1'b0,D47})):(({1'b0,D43}+{1'b0,D47})-{D45,1'b0});


// assign delta_H_R_r_up = ({D34,1'b0} > ({1'b0,D32}+{1'b0,D36}))?({D34,1'b0}-({1'b0,D32}+{1'b0,D36})):(({1'b0,D32}+{1'b0,D36})-{D45,1'b0});
// assign delta_H_R_r_down = ({D54,1'b0} > ({1'b0,D52}+{1'b0,D56}))?({D54,1'b0}-({1'b0,D52}+{1'b0,D56})):(({1'b0,D52}+{1'b0,D56})-{D54,1'b0});





// assign delta_H_left = delta_H_G_b_left + delta_H_B_b_left;
// assign delta_H_right= delta_H_G_b_right + delta_H_B_b_right;
// assign delta_H_up = delta_H_G_r_up + delta_H_R_r_up;
// assign delta_H_down = delta_H_R_r_down + delta_H_G_r_down;





wire [11:0] r;
wire [11:0] b;

assign b = {1'b0,D43[9:1]} + {1'b0,D45[9:1]} + D44 - {1'b0, g_i_m1_j[9:1]} - {1'b0, g_i_p1_j[9:1]};
assign r = {1'b0,D34[9:1]} + {1'b0,D54[9:1]} + D44 - {1'b0, g_i_j_m1[9:1]} - {1'b0, g_i_j_p1[9:1]};

assign out_r =  r[11]?0:((r[10]) ? 10'h3FF : r[9:0]);
assign out_b =  b[11]?0:((b[10]) ? 10'h3FF : b[9:0]);



// assign R = {4'b0,D13[9:4]} + {4'b0,D53[9:4]}
//           +{1'b0,D32[9:1]} + {1'b0,D34[9:1]}
//           +5*{3'b0,D33[9:3]}
//           -{3'b0,D22[9:3]} - {3'b0,D24[9:3]} - {3'b0,D44[9:3]} - {3'b0,D42[9:3]} - {3'b0,D31[9:3]} - {3'b0,D35[9:3]} ;
endmodule //R_at_G_in_Rrow_Bcolumn