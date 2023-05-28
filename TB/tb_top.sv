//`timescale 1ns/10ps
module tb_top;
//timeunit 1ns;
//timeprecision 10ps;

  import uvm_pkg::*;
  import test_lib_pkg::*;

  bit  clk, rst_n;

  my_busif m_if(.clk, .rst_n);

  aiueo dut
  (
    .clk    ,
    .rst_n  ,
    .en     (m_if.en   ),
    .we     (m_if.we   ),
    .addr   (m_if.addr ),
    .wdata  (m_if.wdata),
    .rdata  (m_if.rdata),
    .csr    ()
  );

  always #10 clk = !clk;

  initial begin
    repeat(100) @(negedge clk);
    rst_n = 1;
  end

  initial begin
    uvm_config_db#(virtual my_busif)::set( null , "*", "v_my_busif" , m_if);
    uvm_pkg::run_test();
  end

endmodule : tb_top
