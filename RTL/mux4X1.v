// FILE NAME: mux4X1.v
// TYPE: module
// DEPARTMENT: communication and electronics department
// AUTHOR: Mina Hanna
// AUTHOR EMAIL: mina.hannaone@gmail.com
//------------------------------------------------
// Release history
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 1/9/2022 Mina Hanna final version
//------------------------------------------------
// KEYWORDS: mux, 4x1
//------------------------------------------------
// PURPOSE: this is a 4 input multiplexer\
///////////inputs and outputs ports declaration//////////////
module mux4X1 #(parameter WIDTH =32) (
  input    wire    [1:0]               sel,
  input    wire    [WIDTH-1:0]         IN_1,
  input    wire    [WIDTH-1:0]         IN_2,
  input    wire    [WIDTH-1:0]         IN_3,
  input    wire    [WIDTH-1:0]         IN_4,
  output   reg     [WIDTH-1:0]         OUT
  );
  
  always@(*)
  begin
    case(sel)
      2'b00        :begin
                     OUT = IN_1;
                    end
      2'b01        :begin
                     OUT = IN_2;
                    end
      2'b10        :begin
                     OUT = IN_3;
                    end
      2'b11        :begin
                     OUT = IN_4;
                    end
    endcase
  end
  
endmodule
