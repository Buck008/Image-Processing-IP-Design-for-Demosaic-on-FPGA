module Line_Buffer_J (	
input         		CCD_PIXCLK,
input         		mCCD_LVAL , 	
input  [9:0]   		mCCD_DATA , 
input  [15:0]  		X_Cont    , 
input         		VGA_CLK, 
input         		READ_Request ,	
input  [12:0] 		READ_Cont , 
output [9:0]  		taps0x,
output [9:0]  		taps1x,
output [9:0]  		taps2x,
output [9:0]  		taps3x,
output [9:0]  		taps4x,
output [9:0]  		taps5x,
output [9:0]  		taps6x
						);
						
						
//====== WIRE /REG  ==== 					
wire [9:0] T0 ; 	
wire [9:0] T1 ; 	
wire [9:0] T2 ; 
wire [9:0] T3 ; 	
wire [9:0] T4 ; 	
wire [9:0] T5 ;
wire [9:0] T6 ; 	
wire [9:0] T7 ; 	 					
reg  [3:0] WR; 				
wire   WR0, WR1, WR2, WR3, WR4, WR5, WR6, WR7; 
//====== WIRE /REG  ==== 	

//----6 SRAM BUFFER  WRITE ENABLE  COUNTER -----
always @( posedge mCCD_LVAL )  
	if ( WR >= 7) 
		WR<=0; 
	else  
		WR<= WR +1 ; 	
	
//----8 SRAM BUFFER  WRITE ENABLE  -----	
assign WR0 = ( WR==0)?1:0 ;  
assign WR1 = ( WR==1)?1:0 ;  
assign WR2 = ( WR==2)?1:0 ;  
assign WR3 = ( WR==3)?1:0 ;  
assign WR4 = ( WR==4)?1:0 ;  
assign WR5 = ( WR==5)?1:0 ;  
assign WR6 = ( WR==6)?1:0 ;  
assign WR7 = ( WR==7)?1:0 ;  

//--- OUT0  SELECTION--- 
assign taps0x = (READ_Request )  ? (  (
   ( WR==0)? T1: (  
   ( WR==1)? T2: (  
   ( WR==2)? T3: (
   ( WR==3)? T4: (
   ( WR==4)? T5: (
   ( WR==5)? T6: (
   ( WR==6)? T7: (
   ( WR==7)? T0:T0
   ))))))))) :0 ;
	
//--- OUT1  SELECTION--- 
assign taps1x = (READ_Request )  ? (  (
   ( WR==0)? T2: (  
   ( WR==1)? T3: (  
   ( WR==2)? T4: (
   ( WR==3)? T5: (
   ( WR==4)? T6: (
   ( WR==5)? T7: (
   ( WR==6)? T0: (
   ( WR==7)? T1:T1
   ))))))))) :0 ;

//--- OUT2  SELECTION--- 
assign taps2x = (READ_Request )  ? (  (
   ( WR==0)? T3: (  
   ( WR==1)? T4: (  
   ( WR==2)? T5: (
   ( WR==3)? T6: (
   ( WR==4)? T7: (
   ( WR==5)? T0: (
   ( WR==6)? T1: (
   ( WR==7)? T2:T2
   ))))))))) :0 ;


//--- OUT3  SELECTION--- 
assign taps3x = (READ_Request )  ? (  (
   ( WR==0)? T4: (  
   ( WR==1)? T5: (  
   ( WR==2)? T6: (
   ( WR==3)? T7: (
   ( WR==4)? T0: (
   ( WR==5)? T1: (
   ( WR==6)? T2: (
   ( WR==7)? T3:T3
   ))))))))) :0 ;

//--- OUT4  SELECTION--- 
assign taps4x = (READ_Request )  ? (  (
   ( WR==0)? T5: (  
   ( WR==1)? T6: (  
   ( WR==2)? T7: (
   ( WR==3)? T0: (
   ( WR==4)? T1: (
   ( WR==5)? T2: (
   ( WR==6)? T3: (
   ( WR==7)? T4:T4
   ))))))))) :0 ;

//--- OUT5  SELECTION--- 
assign taps5x = (READ_Request )  ? (  (
   ( WR==0)? T6: (  
   ( WR==1)? T7: (  
   ( WR==2)? T0: (
   ( WR==3)? T1: (
   ( WR==4)? T2: (
   ( WR==5)? T3: (
   ( WR==6)? T4: (
   ( WR==7)? T5:T5
   ))))))))) :0 ;

//--- OUT6  SELECTION--- 
assign taps6x = (READ_Request )  ? (  (
   ( WR==0)? T7: (  
   ( WR==1)? T0: (  
   ( WR==2)? T1: (
   ( WR==3)? T2: (
   ( WR==4)? T3: (
   ( WR==5)? T4: (
   ( WR==6)? T5: (
   ( WR==7)? T6:T6
   ))))))))) :0 ;



//---0 : 2PORT LINE BUFFER 	
int_line d1(
	.wrclock    (CCD_PIXCLK),
	.data       (mCCD_DATA ),
	.wraddress  (X_Cont),
	.wren       (WR0 & mCCD_LVAL),
	.rdclock    (VGA_CLK),	
	.rdaddress  (READ_Cont),
	.q          (T0)
	);
	
//---1 : 2PORT LINE BUFFER 						
int_line d2(
	.wrclock    (CCD_PIXCLK),
	.data       (mCCD_DATA),
	.wraddress  (X_Cont),
	.wren       (WR1 & mCCD_LVAL),
	.rdclock    (VGA_CLK),	
	.rdaddress  (READ_Cont),
	.q          (T1)
	);
	
//---2 : 2PORT LINE BUFFER 		
int_line d3(
	.wrclock    (CCD_PIXCLK),
	.data       (mCCD_DATA ),
	.wraddress  (X_Cont),
	.wren       (WR2 & mCCD_LVAL),
	.rdclock    (VGA_CLK),	
	.rdaddress  (READ_Cont),
	.q          (T2)
	);

   //---3 : 2PORT LINE BUFFER 		
int_line d4(
	.wrclock    (CCD_PIXCLK),
	.data       (mCCD_DATA ),
	.wraddress  (X_Cont),
	.wren       (WR3 & mCCD_LVAL),
	.rdclock    (VGA_CLK),	
	.rdaddress  (READ_Cont),
	.q          (T3)
	);

   //---4 : 2PORT LINE BUFFER 		
int_line d5(
	.wrclock    (CCD_PIXCLK),
	.data       (mCCD_DATA ),
	.wraddress  (X_Cont),
	.wren       (WR4 & mCCD_LVAL),
	.rdclock    (VGA_CLK),	
	.rdaddress  (READ_Cont),
	.q          (T4)
	);

   //---5 : 2PORT LINE BUFFER 		
int_line d6(
	.wrclock    (CCD_PIXCLK),
	.data       (mCCD_DATA ),
	.wraddress  (X_Cont),
	.wren       (WR5 & mCCD_LVAL),
	.rdclock    (VGA_CLK),	
	.rdaddress  (READ_Cont),
	.q          (T5)
	);

   //---6 : 2PORT LINE BUFFER 		
int_line d7(
	.wrclock    (CCD_PIXCLK),
	.data       (mCCD_DATA ),
	.wraddress  (X_Cont),
	.wren       (WR6 & mCCD_LVAL),
	.rdclock    (VGA_CLK),	
	.rdaddress  (READ_Cont),
	.q          (T6)
	);


   //---7 : 2PORT LINE BUFFER 		
int_line d8(
	.wrclock    (CCD_PIXCLK),
	.data       (mCCD_DATA ),
	.wraddress  (X_Cont),
	.wren       (WR7 & mCCD_LVAL),
	.rdclock    (VGA_CLK),	
	.rdaddress  (READ_Cont),
	.q          (T7)
	);
endmodule 	
						