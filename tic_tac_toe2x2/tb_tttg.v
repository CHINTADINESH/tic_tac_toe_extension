`timescale 1ns / 1ps
// fpga4student.com: FPGA projects, Verilog projects, VHDL projects
// Verilog testbench code for TIC TAC TOE GAME 

module tb_tttg;

 // Inputs
 reg clk;
 reg reset;
 reg play1;
 reg play2;
 reg [3:0] button;

 // Outputs
 wire [1:0] pos_led1;
 wire [1:0] pos_led2;
 wire [1:0] pos_led3;
 wire [1:0] pos_led4;
 wire [1:0] who;
 wire [1:0] current_state;
 // Instantiate the Unit Under Test (UUT)
   tttg uut (
  .clk(clk), 
  .reset(reset), 
  .play1(play1), 
  .play2(play2), 
  .button(button), 
  .pos1(pos_led1), 
  .pos2(pos_led2), 
  .pos3(pos_led3), 
  .pos4(pos_led4), 
  .who(who),
  .present_state(current_state)
 );
 // clk
 initial begin
 clk = 0;
 forever #1 clk = ~clk;
 end
 initial begin
  // Initialize Inputs
  reset = 1;
  play1 = 0;
  play2 = 0;
  #200;
  reset = 0;
  #200;
  play1 = 1;
  play2 = 0;
  #200;
  button =  9'b1000;
  #200;
  button =  9'b0000;
  play2 = 0;
  play1 = 0;
  #200;
  play2 = 1;
  play1 = 0;
  #200;
  button = 9'b0100 ;
  #200;
  button =  9'b0000;
  play2 = 0;
  play1 = 0;
  #200;
  play1 = 1;
  play2 = 0;
  #200;
  button = 9'b0010 ;
  #200;
  button =  9'b0000;
  play2 = 0;
  play1 = 0;
  #200;
  play2 = 1;
  play1 = 0;  
  #200;
  button = 9'b0000 ;
  #200;
  button =  9'b0000;
  play2 = 0;
  play1 = 0;
  #200;
  end

  initial begin
	  $monitor("\ntime = %3d \n %d %d  \n %d %d \n current_state = %d \n  winner = %d \n play2 = %d play1 = %d \n", $time, pos_led1, pos_led2, pos_led3, pos_led4,current_state, who, play2, play1);
  end


endmodule
