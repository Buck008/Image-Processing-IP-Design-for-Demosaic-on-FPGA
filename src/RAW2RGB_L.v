
module RAW2RGB_L(	
//---ccd 
input	  [9:0]	     CCD_DATA,
input			     CCD_PIXCLK ,
input		         CCD_FVAL,
input		         CCD_LVAL,
input	  [15:0]	 X_Cont,
input	  [15:0]	 Y_Cont,
input			     DVAL,
input			     RST,
input                VGA_CLK, // 25M 
input                READ_EN ,
input                VGA_VS ,	
input   [12:0]       READ_Cont ,
input   [12:0]       V_Cont , 
input   [9:0]        SW,

output	 [7:0]       oRed,
output 	 [7:0]       oGreen,
output	 [7:0]       oBlue,
output	   	         oDVAL

);
parameter D8M_VAL_LINE_MAX  = 2 + 800;//620; 
parameter D8M_VAL_LINE_MIN  = 2;//2; 

//----- WIRE /REG 
wire	    [9:0]	mDAT0_0;
wire	    [9:0]	mDAT0_1;
wire	    [9:0]	mDAT0_2;
wire	    [9:0]	mDAT0_3;
wire	    [9:0]	mDAT0_4;
wire	    [9:0]	mDAT0_5;
wire	    [9:0]	mDAT0_6;

wire 	    [7:0]	mCCD_R;
wire 	    [7:0]	mCCD_G; 
wire 	    [7:0]	mCCD_B;

wire 	    [9:0]	BIN_mCCD_R;
wire 	    [9:0]	BIN_mCCD_G; 
wire 	    [9:0]	BIN_mCCD_B;

wire 	    [9:0]	HQL_mCCD_R;
wire 	    [9:0]	HQL_mCCD_G; 
wire 	    [9:0]	HQL_mCCD_B;

wire 	    [9:0]	Hamilton_mCCD_R;
wire 	    [9:0]	Hamilton_mCCD_G; 
wire 	    [9:0]	Hamilton_mCCD_B;

wire 	    [7:0]	mCCD_R_Gaussian;
wire 	    [7:0]	mCCD_G_Gaussian; 
wire 	    [7:0]	mCCD_B_Gaussian;

wire 	    [7:0]	mCCD_R_Gaussian_out;
wire 	    [7:0]	mCCD_G_Gaussian_out;
wire 	    [7:0]	mCCD_B_Gaussian_out;

wire 	    [7:0]	mCCD_R_AWB;
wire 	    [7:0]	mCCD_G_AWB;
wire 	    [7:0]	mCCD_B_AWB;

wire 	    [7:0]	mCCD_R_AWB_out;
wire 	    [7:0]	mCCD_G_AWB_out; 
wire 	    [7:0]	mCCD_B_AWB_out;

wire 	    [7:0]	mCCD_R_GAMMA_sqrt;
wire 	    [7:0]	mCCD_G_GAMMA_sqrt; 
wire 	    [7:0]	mCCD_B_GAMMA_sqrt;

wire 	    [7:0]	mCCD_R_GAMMA_square;
wire 	    [7:0]	mCCD_G_GAMMA_square; 
wire 	    [7:0]	mCCD_B_GAMMA_square;

wire 	    [7:0]	mCCD_R_GAMMA;
wire 	    [7:0]	mCCD_G_GAMMA;
wire 	    [7:0]	mCCD_B_GAMMA;


//-------- RGB OUT ---- 
// assign   oRed    = SW[5]? Hamilton_mCCD_R_GAMMA :(SW[6]? Hamilton_mCCD_R_AWB :(SW[7]? Hamilton_mCCD_R_Gaussian :(SW[8]? Hamilton_mCCD_R[9:2] :(SW[9]? HQL_mCCD_R[9:2] :mCCD_R[9:2]))));
// assign  oGreen   = SW[5]? Hamilton_mCCD_G_GAMMA :(SW[6]? Hamilton_mCCD_G_AWB :(SW[7]? Hamilton_mCCD_G_Gaussian :(SW[8]? Hamilton_mCCD_G[9:2] :(SW[9]? HQL_mCCD_G[9:2] :mCCD_G[9:2]))));
// assign	oBlue    = SW[5]? Hamilton_mCCD_B_GAMMA :(SW[6]? Hamilton_mCCD_B_AWB :(SW[7]? Hamilton_mCCD_B_Gaussian :(SW[8]? Hamilton_mCCD_B[9:2] :(SW[9]? HQL_mCCD_B[9:2] :mCCD_B[9:2]))));

assign mCCD_R = (SW[8]? Hamilton_mCCD_R[9:2] :(SW[9]? HQL_mCCD_R[9:2] : BIN_mCCD_R[9:2]));
assign mCCD_G = (SW[8]? Hamilton_mCCD_G[9:2] :(SW[9]? HQL_mCCD_G[9:2] : BIN_mCCD_G[9:2]));
assign mCCD_B = (SW[8]? Hamilton_mCCD_B[9:2] :(SW[9]? HQL_mCCD_B[9:2] : BIN_mCCD_B[9:2]));


//----3 2-PORT-LINE-BUFFER----  
Line_Buffer_J 	u0(	
	.CCD_PIXCLK  ( CCD_PIXCLK ),
    .mCCD_LVAL   ( CCD_LVAL) , 	
	.X_Cont      ( X_Cont) , 
	.mCCD_DATA   ( CCD_DATA),
	.VGA_CLK     ( VGA_CLK), 
    .READ_Request( READ_EN ),
    .READ_Cont   ( READ_Cont),
	.taps0x      ( mDAT0_0),
	.taps1x      ( mDAT0_1),
    .taps2x      ( mDAT0_2),
    .taps3x      ( mDAT0_3),
    .taps4x      ( mDAT0_4),
    .taps5x      ( mDAT0_5),
    .taps6x      ( mDAT0_6)
	);					

	
wire    RD_EN ; 
assign RD_EN = (( READ_Cont > D8M_VAL_LINE_MIN ) && ( READ_Cont < D8M_VAL_LINE_MAX ))?1:0 ; 			

	
						
RAW_RGB_BIN  bin(
      .CLK  ( VGA_CLK ), 
      .RST_N( RD_EN  ) , 
      .D0   ( mDAT0_1),
      .D1   ( mDAT0_2),
      .X    ( READ_Cont[0]) ,
      .Y    ( V_Cont[0]),
      .R    ( BIN_mCCD_R),
      .G    ( BIN_mCCD_G), 
      .B    ( BIN_mCCD_B)
); 

RAW_RGB_HQL HQL(
    .CLK(VGA_CLK ),
    .RST_N(RD_EN), 
    .D0(mDAT0_0),
    .D1(mDAT0_1),
    .D2(mDAT0_2),
    .D3(mDAT0_3),
    .D4(mDAT0_4),
    .X(READ_Cont[0]),
    .Y(V_Cont[0]),
    .R(HQL_mCCD_R),
    .G(HQL_mCCD_G), 
    .B(HQL_mCCD_B)
);

// RAW_RGB_Hamilton_advanced u_RAW_RGB_Hamilton_advanced(
//     .CLK(VGA_CLK ),
//     .RST_N(RD_EN), 
//     .D0(mDAT0_0),
//     .D1(mDAT0_1),
//     .D2(mDAT0_2),
//     .D3(mDAT0_3),
//     .D4(mDAT0_4),
//     .D5(mDAT0_5),
//     .D6(mDAT0_6),
//     .X( READ_Cont[0]),
//     .Y(V_Cont[0]),
//     .R(Hamilton_mCCD_R),
//     .G(Hamilton_mCCD_G), 
//     .B(Hamilton_mCCD_B)
// );

RAW_RGB_Hamilton_piplined u_RAW_RGB_Hamilton_piplined(
    .CLK(VGA_CLK ),
    .RST_N(RD_EN), 
    .D0(mDAT0_0),
    .D1(mDAT0_1),
    .D2(mDAT0_2),
    .D3(mDAT0_3),
    .D4(mDAT0_4),
    .D5(mDAT0_5),
    .D6(mDAT0_6),
    .X(READ_Cont[0]),
    .Y(V_Cont[0]),
    .R(Hamilton_mCCD_R),
    .G(Hamilton_mCCD_G), 
    .B(Hamilton_mCCD_B)
);


Gaussian_filter  u_Gaussian_filter_R (
    .clk(VGA_CLK),
    .D(mCCD_R),
    // .SW(SW[7]),
    .G(mCCD_R_Gaussian)
);

Gaussian_filter  u_Gaussian_filter_G (
    .clk(VGA_CLK),
    .D(mCCD_G),
	// .SW(SW[7]),
    .G(mCCD_G_Gaussian)
);

Gaussian_filter  u_Gaussian_filter_B (
    .clk(VGA_CLK),
    .D(mCCD_B),
    // .SW(SW[7]),
    .G(mCCD_B_Gaussian)
);

assign mCCD_R_Gaussian_out = SW[7] ? mCCD_R_Gaussian : mCCD_R;
assign mCCD_G_Gaussian_out = SW[7] ? mCCD_G_Gaussian : mCCD_G;
assign mCCD_B_Gaussian_out = SW[7] ? mCCD_B_Gaussian : mCCD_B;

AWB u_AWB(
    .CLK(VGA_CLK),
    .RST_n(RD_EN),
    .iLVAL(CCD_LVAL),
    .iFVAL(CCD_FVAL),
    .X_Cont(X_Cont),
    .Y_Cont(Y_Cont),
    .iR(mCCD_R_Gaussian_out),
    .iG(mCCD_G_Gaussian_out),
    .iB(mCCD_B_Gaussian_out),
    // .SW(SW),
    .oR(mCCD_R_AWB),
    .oG(mCCD_G_AWB),
    .oB(mCCD_B_AWB)
);

assign mCCD_R_AWB_out = SW[6] ? mCCD_R_AWB : mCCD_R_Gaussian_out;
assign mCCD_G_AWB_out = SW[6] ? mCCD_G_AWB : mCCD_G_Gaussian_out;
assign mCCD_B_AWB_out = SW[6] ? mCCD_B_AWB : mCCD_B_Gaussian_out;

gamma u_gamma (
	.clk(VGA_CLK),
	.rst_n(RD_EN),
	.R(mCCD_R_AWB_out), 
	.G(mCCD_G_AWB_out),
	.B(mCCD_B_AWB_out),
    // .SW(SW),
    // .R_GAMMA(mCCD_R_GAMMA),
    // .G_GAMMA(mCCD_G_GAMMA),
    // .B_GAMMA(mCCD_B_GAMMA)
    .R_sqrt(mCCD_R_GAMMA_sqrt),
    .G_sqrt(mCCD_G_GAMMA_sqrt),
    .B_sqrt(mCCD_B_GAMMA_sqrt),
    .R_square(mCCD_R_GAMMA_square),
    .G_square(mCCD_G_GAMMA_square),
    .B_square(mCCD_B_GAMMA_square)
);

assign mCCD_R_GAMMA = SW[5]? (SW[4]? mCCD_R_GAMMA_square : mCCD_R_GAMMA_sqrt) : mCCD_R_AWB_out;
assign mCCD_G_GAMMA = SW[5]? (SW[4]? mCCD_G_GAMMA_square : mCCD_G_GAMMA_sqrt) : mCCD_G_AWB_out;
assign mCCD_B_GAMMA = SW[5]? (SW[4]? mCCD_B_GAMMA_square : mCCD_B_GAMMA_sqrt) : mCCD_B_AWB_out;
    
assign   oRed    = mCCD_R_GAMMA;
assign  oGreen   = mCCD_G_GAMMA;
assign	oBlue    = mCCD_B_GAMMA;

endmodule
