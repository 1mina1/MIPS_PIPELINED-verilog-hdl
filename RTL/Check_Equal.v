// FILE NAME: Check_Equal.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 4/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: equal check if equal
//------------------------------------------------
// PURPOSE: this is module to check equality of two inputs\
///////////inputs and outputs ports declaration//////////////
module Check_Equal #(parameter WIDTH =32) (
  input    wire    [WIDTH-1:0]    IN_1,
  input    wire    [WIDTH-1:0]    IN_2,
  output   wire                   OUT
  );
  
  assign OUT = &(~(IN_1 ^ IN_2));
endmodule