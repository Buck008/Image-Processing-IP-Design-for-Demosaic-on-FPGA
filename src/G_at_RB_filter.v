module G_at_RB_filter (
    input [9:0] D11,D12,D13,D14,D15,
    input [9:0] D21,D22,D23,D24,D25,
    input [9:0] D31,D32,D33,D34,D35,
    input [9:0] D41,D42,D43,D44,D45,
    input [9:0] D51,D52,D53,D54,D55,

    output [9:0] G 
);

wire [11:0] G_;

assign G_ = +{2'b0,D23[9:2]} +{2'b0,D32[9:2]} +{2'b0,D43[9:2]} +{2'b0,D34[9:2]} 
           +{1'b0,D33[9:1]}
           -({3'b0,D13[9:3]} +{3'b0,D31[9:3]} +{3'b0,D35[9:3]} + {3'b0,D53[9:3]});

assign G = (G_[11] == 1)?10'd0:((G_[10]==1)?10'h3FF:G_[9:0]);

endmodule //G_at_R_filter