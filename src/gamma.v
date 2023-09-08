module gamma (
	input clk,
	input rst_n,
	input [7:0] R, 
	input [7:0] G,
	input [7:0] B,
    // input SW,
	
	// output [7:0] R_GAMMA,
	// output [7:0] G_GAMMA,
	// output [7:0] B_GAMMA
    output [7:0] R_sqrt,
    output [7:0] G_sqrt,
    output [7:0] B_sqrt,
    output [7:0] R_square,
    output [7:0] G_square,
    output [7:0] B_square

	);

    // wire [7:0] R_sqrt;
    // wire [7:0] G_sqrt;
    // wire [7:0] B_sqrt;

    // wire [7:0] R_square;
    // wire [7:0] G_square;
    // wire [7:0] B_square;


    //==========================================================================
    //==    gamma sqrt 图像变亮
    //==========================================================================
    ROM_sqrt u_R_sqrt
    (
        .address                (R        ),
        .clock                  (clk      ),
        .q                      (R_sqrt   )
    );

    ROM_sqrt u_G_sqrt
    (
        .address                (G        ),
        .clock                  (clk      ),
        .q                      (G_sqrt   )
    );

    ROM_sqrt u_B_sqrt
    (
        .address                (B        ),
        .clock                  (clk      ),
        .q                      (B_sqrt   )
    );

    //==========================================================================
    //==    gamma square 图像变暗
    //==========================================================================
    ROM_square u_R_square
    (
        .address                (R         ),
        .clock                  (clk       ),
        .q                      (R_square  )
    );
        

    ROM_square u_G_square
    (
        .address                (G         ),
        .clock                  (clk       ),
        .q                      (G_square  )
    );

    ROM_square u_B_square
    (
        .address                (B         ),
        .clock                  (clk       ),
        .q                      (B_square  )
    );


    // assign R_GAMMA = SW[5]? (SW[4] ? R_square : R_sqrt) : R;
    // assign G_GAMMA = SW[5]? (SW[4] ? G_square : G_sqrt) : G;
    // assign B_GAMMA = SW[5]? (SW[4] ? B_square : B_sqrt) : B;

endmodule
