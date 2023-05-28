
interface my_busif (input logic clk, rst_n);

    logic        en;
    logic        we;
    logic [11:0] addr;
    logic [ 7:0] wdata;
    logic [ 7:0] rdata;

endinterface

