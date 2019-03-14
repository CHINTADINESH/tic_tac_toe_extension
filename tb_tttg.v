`timescale 1ns / 1ps
// fpga4student.com: FPGA projects, Verilog projects, VHDL projects
// Verilog testbench code for TIC TAC TOE GAME 

module tb_tttg;

 // Inputs
 reg clk;
 reg reset;
 reg play;
 reg pc;
 reg [8:0] button;

 // Outputs
 wire [1:0] pos_led1;
 wire [1:0] pos_led2;
 wire [1:0] pos_led3;
 wire [1:0] pos_led4;
 wire [1:0] pos_led5;
 wire [1:0] pos_led6;
 wire [1:0] pos_led7;
 wire [1:0] pos_led8;
 wire [1:0] pos_led9;
 wire [1:0] who;

 // Instantiate the Unit Under Test (UUT)
   tttg uut (
  .clk(clk), 
  .reset(reset), 
  .play(play), 
  .pc(pc), 
  .button(button), 
  .pos1(pos_led1), 
  .pos2(pos_led2), 
  .pos3(pos_led3), 
  .pos4(pos_led4), 
  .pos5(pos_led5), 
  .pos6(pos_led6), 
  .pos7(pos_led7), 
  .pos8(pos_led8), 
  .pos9(pos_led9), 
  .who(who)
 );
 // clk
 initial begin
 clk = 0;
 forever #1 clk = ~clk;
 end
 initial begin
  // Initialize Inputs
  reset = 1;
  play = 0;
  pc = 0;
  #200;
  reset = 0;
  #200;
  play = 1;
  pc = 0;
  button =  9'b100000000;
  #200;
  pc = 0;
  play = 0;
  #200;
  pc = 1;
  play = 0;
  button = 9'b010000000 ;
  #200;
  pc = 0;
  play = 0;
  #200;
  pc = 0;
  play = 0;
  #200;
  play = 1;
  pc = 0;
  button = 9'b001000000 ;
  #200;
  pc = 1;
  play = 0;  
  button = 9'b000000010 ;
  #200;
  pc = 0;
  play = 0;
  #200;
  pc = 0;
  play = 0;
  #200;
  play = 1;
  pc = 0;
  button = 9'b000100000 ;
  #200;
  pc = 0;
  play = 0;
  #200;
  pc = 0;
  play = 0;
  #200;
  pc = 1;
  play = 0; 
  button = 9'b000000100 ;
  #200;
  pc = 0;
  play = 0;
  #200;
  pc = 0;
  play = 0;
  #200;
  pc = 0;
  play = 1; 
  button = 9'b000010000 ;
  #200;
  pc = 0;
  play = 0;
  #200;
  pc = 0;
  play = 0;
  #200;
  pc = 1;
  play = 0; 
  button = 9'b000000001 ;
  #200;
  pc = 0;
  play = 0;   
  end

  initial begin
	  $monitor("\ntime = %3d \n %d %d %d \n %d %d %d \n %d %d %d \n winner = %d\n", $time, pos_led1, pos_led2, pos_led3, pos_led4, pos_led5, pos_led6, pos_led7, pos_led8, pos_led9, who);
  end


endmodule
