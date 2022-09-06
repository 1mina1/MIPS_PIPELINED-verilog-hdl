// FILE NAME: DTOEFF.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 4/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: pipeline mips, decode and execute instruction
//------------------------------------------------
// PURPOSE: this a FF to decompose instruction into decode and execute\
///////////inputs and outputs ports declaration//////////////
module DTOEFF #(parameter WIDTH = 32) (
  input    wire    [WIDTH-1:0]     DTOEFF_RD1D,
  input    wire    [WIDTH-1:0]     DTOEFF_RD2D,
  input    wire    [4:0]           DTOEFF_RsD,
  input    wire    [4:0]           DTOEFF_RtD,
  input    wire    [4:0]           DTOEFF_RdD,
  input    wire    [WIDTH-1:0]     DTOEFF_SignImmD,
  input    wire                    DTOEFF_RegWriteD,
  input    wire                    DTOEFF_MemWriteD,
  input    wire                    DTOEFF_MemToRegD,
  input    wire    [2:0]           DTOEFF_ALuControlD,
  input    wire                    DTOEFF_AluSrcD,
  input    wire                    DTOEFF_RegDstD,
  input    wire                    DTOEFF_CLK,
  input    wire                    DTOEFF_RST,
  input    wire                    DTOEFF_CLR,
  output   reg     [WIDTH-1:0]     DTOEFF_RD1E,
  output   reg     [WIDTH-1:0]     DTOEFF_RD2E,
  output   reg     [4:0]           DTOEFF_RsE,
  output   reg     [4:0]           DTOEFF_RtE,
  output   reg     [4:0]           DTOEFF_RdE,
  output   reg     [WIDTH-1:0]     DTOEFF_SignImmE,
  output   reg                     DTOEFF_RegWriteE,
  output   reg                     DTOEFF_MemWriteE,
  output   reg                     DTOEFF_MemToRegE,
  output   reg     [2:0]           DTOEFF_ALuControlE,
  output   reg                     DTOEFF_AluSrcE,
  output   reg                     DTOEFF_RegDstE
  );
  
  always@(posedge DTOEFF_CLK or negedge DTOEFF_RST)
  begin
    if(!DTOEFF_RST)
      begin
        DTOEFF_RD1E <= 'b0;
        DTOEFF_RD2E <= 'b0;
        DTOEFF_RsE  <= 'b0;
        DTOEFF_RtE  <= 'b0;
        DTOEFF_RdE  <= 'b0;
        DTOEFF_SignImmE <= 'b0;
        DTOEFF_RegWriteE <= 1'b0;
        DTOEFF_MemWriteE <= 1'b0;
        DTOEFF_MemToRegE <= 1'b0;
        DTOEFF_AluSrcE <= 1'b0;
        DTOEFF_RegDstE <= 1'b0;
        DTOEFF_ALuControlE <= 3'b0;
      end
    else if(DTOEFF_CLR)
      begin
        DTOEFF_RD1E <= 'b0;
        DTOEFF_RD2E <= 'b0;
        DTOEFF_RsE  <= 'b0;
        DTOEFF_RtE  <= 'b0;
        DTOEFF_RdE  <= 'b0;
        DTOEFF_SignImmE <= 'b0;
        DTOEFF_RegWriteE <= 1'b0;
        DTOEFF_MemWriteE <= 1'b0;
        DTOEFF_MemToRegE <= 1'b0;
        DTOEFF_AluSrcE <= 1'b0;
        DTOEFF_RegDstE <= 1'b0;
        DTOEFF_ALuControlE <= 3'b0;
      end
    else
      begin
        DTOEFF_RD1E <= DTOEFF_RD1D;
        DTOEFF_RD2E <= DTOEFF_RD2D;
        DTOEFF_RsE  <= DTOEFF_RsD;
        DTOEFF_RtE  <= DTOEFF_RtD;
        DTOEFF_RdE  <= DTOEFF_RdD;
        DTOEFF_SignImmE <= DTOEFF_SignImmD;
        DTOEFF_RegWriteE <= DTOEFF_RegWriteD;
        DTOEFF_MemWriteE <= DTOEFF_MemWriteD;
        DTOEFF_MemToRegE <= DTOEFF_MemToRegD;
        DTOEFF_AluSrcE <= DTOEFF_AluSrcD;
        DTOEFF_RegDstE <= DTOEFF_RegDstD;
        DTOEFF_ALuControlE <= DTOEFF_ALuControlD;
      end
  end
  
endmodule