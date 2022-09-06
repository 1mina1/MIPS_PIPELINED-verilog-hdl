// FILE NAME: ETOMFF.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 4/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: pipeline mips, execute and memory instruction
//------------------------------------------------
// PURPOSE: this a FF to decompose instruction into execute and memory\
///////////inputs and outputs ports declaration//////////////
module ETOMFF #(parameter WIDTH=32) (
  input    wire    [WIDTH-1:0]    ETOMFF_AluOutE,
  input    wire    [WIDTH-1:0]    ETOMFF_WriteDataE,
  input    wire    [4:0]          ETOMFF_WriteRegE,
  input    wire                   ETOMFF_RegWriteE,
  input    wire                   ETOMFF_MemWriteE,
  input    wire                   ETOMFF_MemToRegE,
  input    wire                   ETOMFF_CLK,
  input    wire                   ETOMFF_RST,
  output   reg     [WIDTH-1:0]    ETOMFF_AluOutM,
  output   reg     [WIDTH-1:0]    ETOMFF_WriteDataM,
  output   reg     [4:0]          ETOMFF_WriteRegM,
  output   reg                    ETOMFF_RegWriteM,
  output   reg                    ETOMFF_MemWriteM,
  output   reg                    ETOMFF_MemToRegM
  );
  
  always@(posedge ETOMFF_CLK or negedge ETOMFF_RST)
  begin
    if(!ETOMFF_RST)
      begin
        ETOMFF_AluOutM <='b0;
        ETOMFF_WriteDataM <='b0;
        ETOMFF_WriteRegM <=5'b0;
        ETOMFF_RegWriteM <= 1'b0;
        ETOMFF_MemWriteM <= 1'b0;
        ETOMFF_MemToRegM <= 1'b0;
      end
    else
      begin
        ETOMFF_AluOutM <=ETOMFF_AluOutE;
        ETOMFF_WriteDataM <=ETOMFF_WriteDataE;
        ETOMFF_WriteRegM <=ETOMFF_WriteRegE;
        ETOMFF_RegWriteM <= ETOMFF_RegWriteE;
        ETOMFF_MemWriteM <= ETOMFF_MemWriteE;
        ETOMFF_MemToRegM <= ETOMFF_MemToRegE;
      end
  end
  
endmodule