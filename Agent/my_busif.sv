
interface my_busif (input logic clk, rst_n);

    logic        en;
    logic        we;
    logic [11:0] addr;
    logic [31:0] wdata;
    logic [31:0] rdata;

    task wait_reset_release();
        @(posedge rst_n);
    endtask

endinterface

