// FILE NAME: Decode_Unit.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 4/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: pipeline mips, Decode instruction
//------------------------------------------------
// PURPOSE: this is the Decode unit of the mips\
///////////inputs and outputs ports declaration/////////////
module Decode_Unit #(parameter WIDTH =32) (
  input     wire    [WIDTH-1:0]    DU_InstrF,
  input     wire    [WIDTH-1:0]    DU_PCPLUS4F,
  input     wire    [WIDTH-1:0]    DU_ALUOUTM,
  input     wire    [WIDTH-1:0]    DU_ResultW,
  input     wire    [4:0]          DU_WriteRegW,
  input     wire                   DU_RegWriteW,
  input     wire                   DU_StallD,
  input     wire                   DU_ForwardAD,
  input     wire                   DU_ForwardBD,
  input     wire                   DU_CLK,
  input     wire                   DU_RST,
  output    wire    [4:0]          DU_RsD,
  output    wire    [4:0]          DU_RtD,
  output    wire    [4:0]          DU_RdD,
  output    wire    [WIDTH-1:0]    DU_PcBranchD,
  output    wire    [WIDTH-1:0]    DU_PcJumpD,
  output    wire    [1:0]          DU_PcSrc,
  output    wire    [WIDTH-1:0]    DU_R1,
  output    wire    [WIDTH-1:0]    DU_R2,
  output    wire    [WIDTH-1:0]    DU_SignImmD,
  output    wire                   DU_RegWriteD,
  output    wire                   DU_MemWriteD,
  output    wire                   DU_MemToRegD,
  output    wire    [2:0]          DU_ALuControlD,
  output    wire                   DU_AluSrcD,
  output    wire                   DU_JumpD,
  output    wire                   DU_BranchD,
  output    wire                   DU_RegDstD
  );
  //////////////////wires definitions //////////////////////
  wire      [WIDTH-1:0]     InstrD;
  wire      [WIDTH-1:0]     PCPLUS4D;
  wire      [WIDTH-1:0]     RD1;
  wire      [WIDTH-1:0]     RD2;
  wire      [WIDTH-1:0]     signImmDSLT;
  wire      [27:0]          InstrDSLT;
  wire                      EqualD;
  
  assign DU_PcSrc = {DU_JumpD,(EqualD&DU_BranchD)};
  assign DU_PcJumpD ={PCPLUS4D[31:28],InstrDSLT};
  assign DU_RsD = InstrD[25:21];
  assign DU_RtD = InstrD[20:16];
  assign DU_RdD = InstrD[15:11];
  /////////modules instantiations////////////////////
  /////////////////////input FF ////////////////////////////
  FTODFF #(.WIDTH(WIDTH)) U0_FTODFF(
  .FTODFF_InstrF(DU_InstrF),
  .FTODFF_PCPLUS4F(DU_PCPLUS4F),
  .FTODFF_CLK(DU_CLK),
  .FTODFF_RST(DU_RST),
  .FTODFF_EN(~DU_StallD),
  .FTODFF_CLR(DU_PcSrc[1] | DU_PcSrc[0]),
  .FTODFF_InstrD(InstrD),
  .FTODFF_PCPLUS4D(PCPLUS4D)
  );
  ////////////////////////Register File////////////////////
  Register_File #(.ADDR_Nbits(5)) U0_Register_File(
  .RegisterFile_A1(InstrD[25:21]),
  .RegisterFile_A2(InstrD[20:16]),
  .RegisterFile_A3(DU_WriteRegW),
  .RegisterFile_WD3(DU_ResultW),
  .RegisterFile_WE3(DU_RegWriteW),
  .RegisterFile_CLK(DU_CLK),
  .RegisterFile_RST(DU_RST),
  .RegisterFile_RD1(RD1),
  .RegisterFile_RD2(RD2)
  );
  /////////////////////////control unit /////////////////////
  Control_Unit U0_Control_Unit(
  .ControlUnit_Opcode(InstrD[31:26]),
  .ControlUnit_Funct(InstrD[5:0]),
  .ControlUnit_MemtoReg(DU_MemToRegD),
  .ControlUnit_MemWrite(DU_MemWriteD),
  .ControlUnit_Branch(DU_BranchD),
  .ControlUnit_ALUSrc(DU_AluSrcD),
  .ControlUnit_RegDst(DU_RegDstD),
  .ControlUnit_RegWrite(DU_RegWriteD),
  .ControlUnit_Jump(DU_JumpD),
  .ControlUnit_ALUControl(DU_ALuControlD)
  );
 ////////////////////////2x1 multiplexers//////////////////// 
  MUX #(.WIDTH(WIDTH)) U0_MUX(
  .MUX_IN1(RD1),
  .MUX_IN2(DU_ALUOUTM),
  .MUX_SelectionBit(DU_ForwardAD),
  .MUX_OUT(DU_R1)
  );
  MUX #(.WIDTH(WIDTH)) U1_MUX(
  .MUX_IN1(RD2),
  .MUX_IN2(DU_ALUOUTM),
  .MUX_SelectionBit(DU_ForwardBD),
  .MUX_OUT(DU_R2)
  );
  /////////////////////Adder and equal checker///////////////////
  Check_Equal #(.WIDTH(WIDTH)) U0_Check_Equal(
  .IN_1(DU_R1),
  .IN_2(DU_R2),
  .OUT(EqualD)
  );
  Adder #(.WIDTH(WIDTH)) U0_Adder(
  .Adder_IN1(signImmDSLT),
  .Adder_IN2(PCPLUS4D),
  .Adder_OUT(DU_PcBranchD)
  );
  ////////////////////sign extend and shifter////////////////////
  Shift_LeftTwice #(.WIDTH(26)) U0_Shift_LeftTwice(
  .SLT_in(InstrD[25:0]),
  .SLT_out(InstrDSLT)
  );
  Shift_LeftTwice #(.WIDTH(WIDTH)) U1_Shift_LeftTwice(
  .SLT_in(DU_SignImmD),
  .SLT_out(signImmDSLT)
  );
  Sign_Extend U0_Sign_Extend(
  .SignExtend_in(InstrD[15:0]),
  .SignExtend_out(DU_SignImmD)
  );
endmodule