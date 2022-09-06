// FILE NAME: FTODFF.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 4/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: pipeline mips, fetch and decode instruction
//------------------------------------------------
// PURPOSE: this a FF to decompose instruction into fetch and decode\
///////////inputs and outputs ports declaration//////////////
module FTODFF #(parameter WIDTH = 32) (
  input    wire    [WIDTH-1:0]    FTODFF_InstrF,
  input    wire    [WIDTH-1:0]    FTODFF_PCPLUS4F,
  input    wire                   FTODFF_CLK,
  input    wire                   FTODFF_RST,
  input    wire                   FTODFF_EN,
  input    wire                   FTODFF_CLR,
  output   reg     [WIDTH-1:0]    FTODFF_InstrD,
  output   reg     [WIDTH-1:0]    FTODFF_PCPLUS4D
  );
  
  always@(posedge FTODFF_CLK or negedge FTODFF_RST)
  begin
    if(!FTODFF_RST)
      begin
        FTODFF_InstrD <= 'b0;
        FTODFF_PCPLUS4D <= 'b0;
      end
    else if(FTODFF_CLR)
      begin
        FTODFF_InstrD <= 'b0;
        FTODFF_PCPLUS4D <= 'b0;
      end
    else if(FTODFF_EN)
      begin
        FTODFF_InstrD <= FTODFF_InstrF;
        FTODFF_PCPLUS4D <= FTODFF_PCPLUS4F;
      end
  end
  
endmodule