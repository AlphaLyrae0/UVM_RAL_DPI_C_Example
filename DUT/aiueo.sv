
module aiueo
(
    input               clk, rst_n,
    input               en , we   ,
    input        [4:0]  addr  ,
    input        [7:0]  wdata ,
    output logic [7:0]  rdata ,
    output logic [7:0]  csr[8]
);


    always_ff @(posedge clk, negedge rst_n)
        if ( !rst_n )   rdata <= '0;
        else if ( en ) begin
            if ( we )   csr[addr[4:2]] <= wdata; // write
            else        rdata          <= csr[addr[4:2]]; // read
        end

endmodule
