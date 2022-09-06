// FILE NAME: MIPS_PIPELINED_TOP_tb.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 4/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: pipeline mips
//------------------------------------------------
// PURPOSE: this is asimple testbench for the top module for the pipelined mips\
///////////inputs and outputs ports declaration//////////////
`timescale 1ns/1ps
module MIPS_PIPELINED_TOP_tb ();
  parameter CLK_HALF_CYCLE = 25;
  
  reg    CLK_tb;
  reg    RST_tb;
  
  initial
  begin
    CLK_tb = 1'b0;
    RST_tb = 1'b1;
    #5
    RST_tb = 1'b0;
    #5
    RST_tb = 1'b1;
    #10000
    $finish;
  end
  
  ///////////////////clock definitions//////////////////
  always #CLK_HALF_CYCLE CLK_tb =~CLK_tb;
  MIPS_PIPELINED_TOP DUT(
  .CLK(CLK_tb),
  .RST(RST_tb)
  );
endmodule
