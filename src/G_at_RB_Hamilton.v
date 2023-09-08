module G_at_RB_Hamilton (
    input [9:0] D22,D23,D24,D25,D26,
    input [9:0] D32,D33,D34,D35,D36,
    input [9:0] D42,D43,D44,D45,D46,
    input [9:0] D52,D53,D54,D55,D56,
    input [9:0] D62,D63,D64,D65,D66,

    output [9:0] G
);

wire [10:0] deltaH;//无符号数
wire [10:0] deltaV;//无符号数

wire [9:0] deltaH_G;//无符号数
assign  deltaH_G = (D43>D45)?(D43-D45):(D45-D43);

wire [9:0] deltaV_G;//无符号数
assign  deltaV_G = (D34>D54)?(D34-D54):(D54-D34);

wire [11:0] t_deltaH_R;//有符号数
assign t_deltaH_R = {D44, 1'b0}-(D42+D46);

wire [11:0] t_deltaV_R;//有符号数
assign t_deltaV_R = {D44, 1'b0}-(D24+D64);

wire [11:0] deltaH_R;//无符号数
assign deltaH_R=t_deltaH_R[11]?-t_deltaH_R:t_deltaH_R;

wire [11:0] deltaV_R;//无符号数
assign deltaV_R=t_deltaV_R[11]?-t_deltaV_R:t_deltaV_R;

assign deltaH = deltaH_G +  deltaH_R;
assign deltaV = deltaV_G +  deltaV_R;

wire [12:0] G_full;
assign G_full=(deltaH<deltaV)?  D43[9:1]+D45[9:1] + {{3{t_deltaH_R[11]}},t_deltaH_R[11:2]}:
         ((deltaH>deltaV)? D34[9:1]+D54[9:1] + {{3{t_deltaV_R[11]}}, t_deltaV_R[11:2]}:
        D43[9:2]+D45[9:2]+ D34[9:2]+D54[9:2] + {{4{t_deltaH_R[11]}}, t_deltaH_R[11:3]} + {{4{t_deltaV_R[11]}}, t_deltaV_R[11:3]});

assign G = (G_full[12])?10'b0:
          ((G_full[11] | G_full[10])?10'h3FF:
          G_full[9:0]);
endmodule