module RAW_RGB_HQL (
    input                   CLK , 
    input                   RST_N , 
    input [9:0]             D0,
    input [9:0]             D1,
    input [9:0]             D2,
    input [9:0]             D3,
    input [9:0]             D4,

    input                   X,
    input                   Y,

    output reg		[9:0]	R,
    output reg		[9:0]	G, 
    output reg		[9:0]	B
);

//5X5
reg  [9:0] D11,D12,D13,D14; 
reg  [9:0] D21,D22,D23,D24; 
reg  [9:0] D31,D32,D33,D34; 
reg  [9:0] D41,D42,D43,D44; 
reg  [9:0] D51,D52,D53,D54; 

wire [9:0] D15;
wire [9:0] D25;
wire [9:0] D35;
wire [9:0] D45;
wire [9:0] D55;

wire [9:0] G_1;
wire [9:0] RB_1;
wire [9:0] RB_2;
wire [9:0] RB_3;

assign D15 = D0;
assign D25 = D1;
assign D35 = D2;
assign D45 = D3;
assign D55 = D4;

//5X5第一行
always @(posedge CLK ) begin
//    if(~RST_N)begin
//        D14<=0;
//        D13<=0;
//        D12<=0;
//        D11<=0;
//    end
//    else begin
        D14<=D15;
        D13<=D14;
        D12<=D13;
        D11<=D12;
//    end
end

//5X5第二行
always @(posedge CLK ) begin
//    if(~RST_N)begin
//        D24<=0;
//        D23<=0;
//        D22<=0;
//        D21<=0;
//    end
//    else begin
        D24<=D25;
        D23<=D24;
        D22<=D23;
        D21<=D22;
//    end
end


//5X5第三行
always @(posedge CLK ) begin
//    if(~RST_N)begin
//        D34<=0;
//        D33<=0;
//        D32<=0;
//        D31<=0;
//    end
//    else begin
        D34<=D35;
        D33<=D34;
        D32<=D33;
        D31<=D32;
//    end
end

//5X5第四行
always @(posedge CLK ) begin
//    if(~RST_N)begin
//        D44<=0;
//        D43<=0;
//        D42<=0;
//        D41<=0;
//    end
//    else begin
        D44<=D45;
        D43<=D44;
        D42<=D43;
        D41<=D42;
//    end
end

//5X5第五行
always @(posedge CLK ) begin
//    if(~RST_N)begin
//        D54<=0;
//        D53<=0;
//        D52<=0;
//        D51<=0;
//    end
//    else begin
        D54<=D55;
        D53<=D54;
        D52<=D53;
        D51<=D52;
//    end
end

//一共四种卷积核
R_at_G_in_Rrow_Bcolumn u_R_at_G_in_Rrow_Bcolumn(
    .D11(D11),.D12(D12),.D13(D13),.D14(D14),.D15(D15),
    .D21(D21),.D22(D22),.D23(D23),.D24(D24),.D25(D25),
    .D31(D31),.D32(D32),.D33(D33),.D34(D34),.D35(D35),
    .D41(D41),.D42(D42),.D43(D43),.D44(D44),.D45(D45),
    .D51(D51),.D52(D52),.D53(D53),.D54(D54),.D55(D55),
    .R(RB_1)
);

R_at_G_in_Brow_Rcolumn u_R_at_G_in_Brow_Rcolumn(
    .D11(D11),.D12(D12),.D13(D13),.D14(D14),.D15(D15),
    .D21(D21),.D22(D22),.D23(D23),.D24(D24),.D25(D25),
    .D31(D31),.D32(D32),.D33(D33),.D34(D34),.D35(D35),
    .D41(D41),.D42(D42),.D43(D43),.D44(D44),.D45(D45),
    .D51(D51),.D52(D52),.D53(D53),.D54(D54),.D55(D55),
    .R(RB_2)
);

R_at_B_in_Brow_Bcolumn u_R_at_B_in_Brow_Bcolumn(
    .D11(D11),.D12(D12),.D13(D13),.D14(D14),.D15(D15),
    .D21(D21),.D22(D22),.D23(D23),.D24(D24),.D25(D25),
    .D31(D31),.D32(D32),.D33(D33),.D34(D34),.D35(D35),
    .D41(D41),.D42(D42),.D43(D43),.D44(D44),.D45(D45),
    .D51(D51),.D52(D52),.D53(D53),.D54(D54),.D55(D55),
    .R(RB_3)
); 

G_at_RB_filter u_G_at_RB_filter(
    .D11(D11),.D12(D12),.D13(D13),.D14(D14),.D15(D15),
    .D21(D21),.D22(D22),.D23(D23),.D24(D24),.D25(D25),
    .D31(D31),.D32(D32),.D33(D33),.D34(D34),.D35(D35),
    .D41(D41),.D42(D42),.D43(D43),.D44(D44),.D45(D45),
    .D51(D51),.D52(D52),.D53(D53),.D54(D54),.D55(D55),
    .G(G_1)
);



always @(posedge CLK) begin
    if(!RST_N)begin
		R <= 0;
		G <= 0;
		B <= 0;
	end
	else begin
        case ({Y ,X })
        2:begin
            G<=D33;
            R<=RB_1;
            B<=RB_2;
        end
        3:begin
            G<=G_1;
            R<=D33;
            B<=RB_3;
        end
        0:begin
            G<=G_1;
            R<=RB_3;
            B<=D33;
        end
        1:begin
            G<=D33;
            R<=RB_2;
            B<=RB_1;
        end
        endcase
    end
end


endmodule //RAW_RGB_HQL