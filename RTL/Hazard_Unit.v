// FILE NAME: Hazard_Unit.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 4/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: pipeline mips, Write back instruction
//------------------------------------------------
// PURPOSE: this is the Hazrad unit to avoid data and control hazards\
///////////inputs and outputs ports declaration/////////////
module Hazard_Unit (
  input    wire             HU_BranchD,
  input    wire             HU_JumpD,
  input    wire    [4:0]    HU_RsD,
  input    wire    [4:0]    HU_RtD,
  input    wire    [4:0]    HU_RsE,
  input    wire    [4:0]    HU_RtE,
  input    wire    [4:0]    HU_WriteRegE,
  input    wire             HU_MemtoRegE,
  input    wire             HU_RegWriteE,
  input    wire    [4:0]    HU_WriteRegM,
  input    wire    [4:0]    HU_WriteRegW,
  input    wire             HU_RegWriteM,
  input    wire             HU_RegWriteW,
  output   wire             HU_StallF,
  output   wire             HU_StallD,
  output   wire             HU_ForwardAD,
  output   wire             HU_ForwardBD,
  output   wire             HU_FlushE,
  output   reg     [1:0]    HU_ForwardAE,
  output   reg     [1:0]    HU_ForwardBE
  );
  wire             lwstall;
  wire             branchstall;
  //////////////////Forwarding logic////////////////////////
  always@(*)//with rs
  begin
    if((HU_RsE !=0) && ((HU_RsE == HU_WriteRegM)&&(HU_RegWriteM)))
      begin
       HU_ForwardAE = 2'b10; 
      end
    else if((HU_RsE !=0) && ((HU_RsE == HU_WriteRegW)&&(HU_RegWriteW)))
      begin
        HU_ForwardAE = 2'b01;
      end
    else
      begin
        HU_ForwardAE = 2'b00;
      end
  end
  always@(*)//with rt
  begin
    if((HU_RtE !=0) && ((HU_RtE == HU_WriteRegM)&&(HU_RegWriteM)))
      begin
       HU_ForwardBE = 2'b10; 
      end
    else if((HU_RtE !=0) && ((HU_RtE == HU_WriteRegW)&&(HU_RegWriteW)))
      begin
        HU_ForwardBE = 2'b01;
      end
    else
      begin
        HU_ForwardBE = 2'b00;
      end
  end
  ////////////////////stalling and branch prediction logic//////////////////////////
  assign HU_ForwardAD = (HU_RsD != 0) && (HU_RsD == HU_WriteRegM) && HU_RegWriteM;
  assign HU_ForwardBD = (HU_RtD != 0) && (HU_RtD == HU_WriteRegM) && HU_RegWriteM;
  assign lwstall = ((HU_RsD == HU_RtE) || (HU_RtE == HU_RtD)) && (HU_MemtoRegE);
  assign branchstall = (HU_BranchD && HU_RegWriteE &&(((HU_RsD == HU_WriteRegE)&&(HU_RsD != 0)) || ((HU_RtD == HU_WriteRegE)&&(HU_RtD != 0)) )) || (HU_BranchD && HU_RegWriteM &&(((HU_RsD == HU_WriteRegM)&&(HU_RsD != 0)) || ((HU_RtD == HU_WriteRegM)&&(HU_RtD != 0)) ));
  assign HU_StallF =  (lwstall | branchstall);
  assign HU_StallD = lwstall | branchstall;
  assign HU_FlushE = lwstall | branchstall;
endmodule