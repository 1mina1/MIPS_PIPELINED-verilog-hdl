// FILE NAME: MTOWBFF.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 4/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: pipeline mips, write back and memory instruction
//------------------------------------------------
// PURPOSE: this a FF to decompose instruction into memory and write back\
///////////inputs and outputs ports declaration//////////////
module MTOWBFF #(parameter WIDTH=32) (
  input    wire    [WIDTH-1:0]    MTOWBFF_AluOutM,
  input    wire    [WIDTH-1:0]    MTOWBFF_ReadDataM,
  input    wire    [4:0]          MTOWBFF_WriteRegM,
  input    wire                   MTOWBFF_RegWriteM,
  input    wire                   MTOWBFF_MemToRegM,
  input    wire                   MTOWBFF_CLK,
  input    wire                   MTOWBFF_RST,
  output   reg     [WIDTH-1:0]    MTOWBFF_AluOutW,
  output   reg     [WIDTH-1:0]    MTOWBFF_ReadDataW,
  output   reg     [4:0]          MTOWBFF_WriteRegW,
  output   reg                    MTOWBFF_RegWriteW,
  output   reg                    MTOWBFF_MemToRegW
  );
always@(posedge MTOWBFF_CLK or negedge MTOWBFF_RST)
  begin
    if(!MTOWBFF_RST)
      begin
        MTOWBFF_AluOutW <='b0;
        MTOWBFF_ReadDataW <='b0;
        MTOWBFF_WriteRegW <=5'b0;
        MTOWBFF_RegWriteW <= 1'b0;
        MTOWBFF_MemToRegW <= 1'b0;
      end
    else
      begin
        MTOWBFF_AluOutW <=MTOWBFF_AluOutM;
        MTOWBFF_ReadDataW <=MTOWBFF_ReadDataM;
        MTOWBFF_WriteRegW <=MTOWBFF_WriteRegM;
        MTOWBFF_RegWriteW <= MTOWBFF_RegWriteM;
        MTOWBFF_MemToRegW <= MTOWBFF_MemToRegM;
      end
  end
  
endmodule