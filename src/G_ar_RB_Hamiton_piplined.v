module G_at_RB_Hamilton_piplined (
    input [9:0] D22,D23,D24,D25,D26,
    input [9:0] D32,D33,D34,D35,D36,
    input [9:0] D42,D43,D44,D45,D46,
    input [9:0] D52,D53,D54,D55,D56,
    input [9:0] D62,D63,D64,D65,D66,
    
    input [9:0] G11,G12,G13, 
    input [9:0] G21,G22,G23, 
    input [9:0] G31,G32,G33, //第二级绿色
    output [9:0] G
);
/* 
    wire [10:0] H_cor, V_cor;
    wire [11:0] H_cor_full, V_cor_full;
    wire [11:0] H_operator, V_operator;
    wire [9:0] H_G_difference, V_G_difference;
    wire [10:0] H_R_sum, V_R_sum;
    wire [10:0] H_sum_G, V_sum_G;
    wire [11:0] G_full;

    assign H_cor_full = {1'b0, D44, 1'b0} - ({2'b0, D42} + {2'b0, D46});
    assign V_cor_full = {1'b0, D44, 1'b0} - ({2'b0, D24} + {2'b0, D64});

    assign H_cor = {H_cor_full[11], H_cor_full[11:2]};
    assign V_cor = {V_cor_full[11], V_cor_full[11:2]};

    assign H_G_difference = (D43 > D45) ? (D43 - D45) : (D45 - D43);
    assign V_G_difference = (D34 > D54) ? (D34 - D54) : (D54 - D34);

    wire [11:0] temp_H_cor_full = -H_cor_full;
    wire [11:0] temp_V_cor_full = -V_cor_full;

    assign H_R_sum = (H_cor_full[11]) ? temp_H_cor_full[10:0] : H_cor_full[10:0];
    assign V_R_sum = (V_cor_full[11]) ? temp_V_cor_full[10:0] : V_cor_full[10:0];

    assign H_operator = {2'b0, H_G_difference} + {1'b0, H_R_sum};
    assign V_operator = {2'b0, V_G_difference} + {1'b0, V_R_sum};

    assign H_sum_G = {1'b0, D43} + {1'b0, D45};
    assign V_sum_G = {1'b0, D34} + {1'b0, D54};

    assign G_full =  (H_operator < V_operator) ? ({1'b0, H_sum_G[10:1]} + H_cor) : 
                ((H_operator > V_operator) ?     ({1'b0, V_sum_G[10:1]} + V_cor) : 
                (H_sum_G[10:2] + H_cor[10:1] + V_sum_G[10:2] + V_cor[10:1]));


    //wire [12:0] G_full_2;

 // assign G_full =  (H_operator < V_operator) ? ({1'b0, H_sum_G[10:1]} + H_cor) :  ({1'b0, V_sum_G[10:1]} + V_cor) ;
//  assign G_full_2 = {G_full, 1'b0};

  assign G =  (G_full[11]) ? 10'd0 : (G_full[10] ? 10'h3FF : G_full[9:0]);
*/

/*
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
*/
assign G = G22;
endmodule