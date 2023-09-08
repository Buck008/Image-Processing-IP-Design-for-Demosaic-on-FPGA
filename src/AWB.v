module AWB (
    input           CLK,
    input           RST_n,
    input           iLVAL,
    input           iFVAL,
    input   [15:0]  X_Cont,
    input   [15:0]  Y_Cont,
    input   [7:0]   iR,
    input   [7:0]   iG,
    input   [7:0]   iB,
    // input   [9:0]   SW,
    
    output  [7:0]   oR,
    output  [7:0]   oG,
    output  [7:0]   oB
);

    // end of frame detection
    // reg Pre_FVAL;
    // reg Pre_LVAL;

    // always @(posedge CLK) begin
    //     Pre_FVAL <= iFVAL;
    //     Pre_LVAL <= iLVAL;
    // end
    reg [19:0] cnt;
    parameter size = 20'h4_B000;
    parameter size_plus = 20'h4_B010;

    always @(posedge CLK) begin
        if (!iFVAL || cnt >= size_plus) begin
            cnt <= 0;
        end
        else if (iLVAL && iFVAL) begin
            cnt <= cnt + 1;
        end
        
    end

    wire f_end;
    // assign f_end = (Y_Cont == 480);
    assign f_end = (cnt >= size);
    // assign f_end = (Pre_FVAL & !iFVAL);

    // // sampling
    wire pix_en;
    // assign pix_en = (X_Cont<=640) && (Y_Cont<=480);
    assign pix_en = (cnt < size);
    // assign pix_en = (iLVAL && iFVAL);
    // assign pix_en = ((X_Cont<=640) && (Y_Cont<=480)) ? ((X_Cont[0] == 1'b1) && (Y_Cont[0] == 1'b1)) : 1'b0;


    // add Gray Sum
    reg [31:0] R_sum;
    reg [31:0] G_sum;
    reg [31:0] B_sum;

    always @ (posedge CLK or negedge RST_n) begin
        if(!RST_n) begin
                R_sum <= 32'd0;
                G_sum <= 32'd0;
                B_sum <= 32'd0;
        end
        else begin
            if(pix_en) begin
                    R_sum <= R_sum + iR;
                    G_sum <= G_sum + iG;
                    B_sum <= B_sum + iB;
            end
            else if(f_end) begin
                    R_sum <= 32'd0;
                    G_sum <= 32'd0;
                    B_sum <= 32'd0;
            end
            else begin
                    R_sum <= R_sum;
                    G_sum <= G_sum;
                    B_sum <= B_sum;
            end
        end
    end
    
    parameter IamgeSize = 32'h00001B48;     // 1/ImageSize = 0.000003255208333... (precision = 31)

    wire [63:0]  AverageR_temp;
    wire [63:0]  AverageG_temp;  
    wire [63:0]  AverageB_temp;  

    reg [7:0]    AverageR;       //Average of R Channel
    reg [7:0]    AverageG;       //Average of B Channel
    reg [7:0]    AverageB;       //Average of B Channel

    assign AverageR_temp = f_end ? (R_sum * IamgeSize) : 64'd0;           
    assign AverageG_temp = f_end ? (G_sum * IamgeSize) : 64'd0;
    assign AverageB_temp = f_end ? (B_sum * IamgeSize) : 64'd0;

    always @ (posedge CLK or negedge RST_n) // cahche in reg
        begin
            if(!RST_n)
                begin
                    AverageR <= 8'd0;
                    AverageG <= 8'd0;
                    AverageB <= 8'd0;
                end
            else
                begin
                    AverageR <= AverageR_temp[38:31];       // extract int 
                    AverageG <= AverageG_temp[38:31];       // (p = 31)
                    AverageB <= AverageB_temp[38:31];
                end
        end

    wire[31:0]  AverageR_recip; // recip of R
    wire[31:0]  AverageG_recip; // recip of G
    wire[31:0]  AverageB_recip; // recip of B

    // (1/R_ave) refer recip LUT

    Recip Reciprocal_R(
        .address(AverageR),
        .clock(CLK),
        .q(AverageR_recip)
    );

    Recip Reciprocal_G(
        .address(AverageG),
        .clock(CLK),
        .q(AverageG_recip)
    );

    Recip Reciprocal_B(
        .address(AverageB),
        .clock(CLK),
        .q(AverageB_recip)
    );

    // Recip_LUT Reciprocal_R(
    //     .Average(AverageR),
    //     .Recip(AverageR_recip)
    // );
    // Recip_LUT Reciprocal_G(
    //     .Average(AverageG),
    //     .Recip(AverageG_recip)
    // );
    // Recip_LUT Reciprocal_B(
    //     .Average(AverageB),
    //     .Recip(AverageB_recip)
    // );

    // calculate gain in 3 channels

    reg [38:0] Rgain; // p = 31: 8-bit(int).31-bit(decimal) 
    reg [38:0] Ggain;
    reg [38:0] Bgain;

    always @ (posedge CLK or negedge RST_n)
        begin
            if(!RST_n) begin
                Rgain <= 39'h00_8000_0000;
                Ggain <= 39'h00_8000_0000;
                Bgain <= 39'h00_8000_0000;
            end
            else begin
                if(f_end) begin
                    Rgain <= {AverageR_recip[31:0], 7'd0}; // R_gain = (1/R_ave)*128
                    Ggain <= {AverageG_recip[31:0], 7'd0};
                    Bgain <= {AverageB_recip[31:0], 7'd0};
                end
                else begin
                    Rgain <= Rgain;
                    Ggain <= Ggain;
                    Bgain <= Bgain;
                end
            end
        end
    
    wire [40:0]  oR_temp; // p = 31 -> p = 16
    wire [40:0]  oG_temp; // int: 8bit*8bit = 16bit
    wire [40:0]  oB_temp;

    assign oR_temp = iR * Rgain[38:6];
    assign oG_temp = iG * Ggain[38:6];
    assign oB_temp = iB * Bgain[38:6]; 

    // assign oR = (SW[2])? (oR_temp[31:21] >= 1 ? 8'hFF : oR_temp[23:16]) : iR;
    // assign oG = (SW[2])? (oG_temp[31:21] >= 1 ? 8'hFF : oG_temp[23:16]) : iG;
    // assign oB = (SW[2])? (oB_temp[31:21] >= 1 ? 8'hFF : oB_temp[23:16]) : iB;

    assign oR = oR_temp[40:33] >= 1 ? 8'hFF : oR_temp[32:25];
    assign oG = oG_temp[40:33] >= 1 ? 8'hFF : oG_temp[32:25];
    assign oB = oB_temp[40:33] >= 1 ? 8'hFF : oB_temp[32:25];

endmodule