
module aiueo #( parameter p_BASE_ADDR = 'hF_00) 
(
    input                     clk, rst_n,
    input                     en , we   ,
    input             [11:0]  addr  ,
    input             [31:0]  wdata ,
    output logic      [31:0]  rdata ,
    output logic [7:0][31:0]  csr   
);


    always_ff @(posedge clk, negedge rst_n)
        if ( !rst_n ) begin
               csr   <= '0;
               rdata <= '0;
        end
        else if ( en && ({addr[11:5],5'b00000} == p_BASE_ADDR)) begin
            if ( we)   csr[addr[4:2]] <= wdata         ; // write
            if (!we)   rdata          <= csr[addr[4:2]]; // read
        end

endmodule
