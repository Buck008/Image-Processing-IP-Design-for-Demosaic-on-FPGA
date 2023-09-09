module Register_Nbits 
#(parameter N=10 )
(
    input               clk,
    input               reset_n,
    input  [N-1:0]      d,

    output reg [N-1:0]  q
);

always @(posedge clk or negedge reset_n) begin
    if(~reset_n)
        q<=0;
    else 
        q<=d;
end


endmodule //RegisterNbits