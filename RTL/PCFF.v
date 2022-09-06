// FILE NAME: PCFF.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 4/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: PC, program counter ,32 bit mips
//------------------------------------------------
// PURPOSE: this is the PC flip flop of the mips\
///////////inputs and outputs ports declaration//////////////
module PCFF #(parameter WIDTH =32) (
  input     wire     [WIDTH-1:0]    PC_IN,
  input     wire                    PC_EN,
  input     wire                    PC_CLK,
  input     wire                    PC_RST,
  output    reg      [WIDTH-1:0]    PC_OUT
  );
  
  ///////////////////FF squentional logic ///////////////////
  always@(posedge PC_CLK or negedge PC_RST)
  begin
    if(!PC_RST)
      begin
        PC_OUT <= 'b0;
      end
    else if(PC_EN)
      begin
        PC_OUT <= PC_IN;
      end
  end
endmodule