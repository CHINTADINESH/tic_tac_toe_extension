// cdineshrdy@gmail.com
module tttg(
     input clk, // clock of the game 
     input reset, // reset button to reset the game 
     input play1, // play1 button to enable player 1 to play 
     input play2, // play2 button to enable player2 to play 
     input [8:0] button,
     output wire [1:0] pos1,pos2,pos3,
     pos4,pos5,pos6,pos7,pos8,pos9,
     output wire[1:0]who 
     );

	 reg [15:0] PL_en2;// player2 enable signals 
	 reg [15:0] PL_en1; // Player enable signals 
	 //wire [1:0] pos1,pos2,pos3,pos4,pos5,pos6,pos7,pos8,pos9;// positions stored
	 wire win; // win signal 
	 wire player_play2; // player2 enabling signal 
	 wire player_play; // player 1 enabling signal 
	 wire no_space; // no space signal 
	 wire [1:0] next_state ;
     	 wire illegal_move;
     	 wire[1:0] present_state; 
	 // position registers    
	 position_registers position_reg_unit(
	      clk, // clock of the game 
	      reset, // reset the game 
	      illegal_move, // disable writing when an illegal move is detected 
	      PL_en2[8:0], // player2 enable signals 
	      PL_en1[8:0], // Player enable signals 
	      pos1,pos2,pos3,pos4,pos5,pos6,pos7,pos8,pos9// positions stored
	      );
	 // winner detector 
	 winner_detector win_detect_unit(pos1,pos2,pos3,pos4,pos5,pos6,pos7,pos8,pos9,win,who);
	 // position decoder for player2 
	 always @ (posedge clk ) begin

		 PL_en2 <= (player_play2==1'b1) ?{7'b0,button}: 16'b0;
		 PL_en1 <= (player_play1==1'b1) ?{7'b0,button}: 16'b0;
	 end
	 
	 // illegal move detector
	 illegal_move_detector imd_unit(
	   pos1,pos2,pos3,pos4,pos5,pos6,pos7,pos8,pos9, 
	   PL_en2[8:0], PL_en1[8:0], 
	   illegal_move
	   );
	 // no space detector 
	nospace_detector nsd_unit(
	   pos1,pos2,pos3,pos4,pos5,pos6,pos7,pos8,pos9, 
	   no_space
	    ); 
	currentstate cs (clk, next_state, present_state, reset);
	output_controller oc (present_state,player_play2, player_play1  );
	state_controller sc (play1,play2, illegal_move, no_space, win,present_state,next_state);

     endmodule

// Position registers 
// to store player 1 or player2 positions 
module position_registers(
      input clk, // clock of the game 
      input reset, // reset the game 
      input illegal_move, // disable writing when an illegal move is detected 
      input [8:0] PL_en2, // player2 enable signals 
      input [8:0] PL_en1, // Player enable signals 
      output reg[1:0] pos1,pos2,pos3,pos4,pos5,pos6,pos7,pos8,pos9// positions stored
      );
 	// Position 1 
		always @(posedge clk or posedge reset)
			begin
				if(reset) 
					pos1 <= 2'b00;
				else begin
					if(illegal_move==1'b1)
						pos1 <= pos1;// keep previous position
					else if(PL_en2[0]==1'b1)
						pos1 <= 2'b10; // store player2 data 
					else if (PL_en1[0]==1'b1)
						pos1 <= 2'b01;// store player 1 data 
					else 
						pos1 <= pos1;// keep previous position
				end 
			end 
		 // Position 2 
		always @(posedge clk or posedge reset)
			begin
				if(reset) 
					pos2 <= 2'b00;
				else begin
					if(illegal_move==1'b1)
						pos2 <= pos2;// keep previous position
					else if(PL_en2[1]==1'b1)
						pos2 <= 2'b10; // store player2 data 
					else if (PL_en1[1]==1'b1)
						pos2 <= 2'b01;// store player 1 data 
					else 
						pos2 <= pos2;// keep previous position
				end 
			end 
		// Position 3 
		always @(posedge clk or posedge reset)
			begin
			if(reset) 
				pos3 <= 2'b00;
			else begin
				if(illegal_move==1'b1)
					pos3 <= pos3;// keep previous position
				else if(PL_en2[2]==1'b1)
					pos3 <= 2'b10; // store player2 data 
				else if (PL_en1[2]==1'b1)
					pos3 <= 2'b01;// store player 1 data 
				else 
					pos3 <= pos3;// keep previous position
				end 
			end  
		// Position 4 
		always @(posedge clk or posedge reset)
			begin
				if(reset) 
					pos4 <= 2'b00;
				else begin
					if(illegal_move==1'b1)
						pos4 <= pos4;// keep previous position
					else if(PL_en2[3]==1'b1)
						pos4 <= 2'b10; // store player2 data 
					else if (PL_en1[3]==1'b1)
						pos4 <= 2'b01;// store player 1 data 
					else 
						pos4 <= pos4;// keep previous position
					end 
			end 
		 // Position 5 
		always @(posedge clk or posedge reset)
			begin
				if(reset) 
					pos5 <= 2'b00;
				else begin
					if(illegal_move==1'b1)
						pos5 <= pos5;// keep previous position
					else if(PL_en2[4]==1'b1)
						pos5 <= 2'b10; // store player2 data 
					else if (PL_en1[4]==1'b1)
						pos5 <= 2'b01;// store player 1 data 
					else 
						pos5 <= pos5;// keep previous position
					end 
			end 
		 // Position 6 
		always @(posedge clk or posedge reset)
			begin
				if(reset) 
					pos6 <= 2'b00;
				else begin
					if(illegal_move==1'b1)
						pos6 <= pos6;// keep previous position
					else if(PL_en2[5]==1'b1)
						pos6 <= 2'b10; // store player2 data 
					else if (PL_en1[5]==1'b1)
						pos6 <= 2'b01;// store player 1 data 
					else 
						pos6 <= pos6;// keep previous position
					end 
			end 
		 // Position 7 
		always @(posedge clk or posedge reset)
			begin
				if(reset) 
					pos7 <= 2'b00;
				else begin
					if(illegal_move==1'b1)
						pos7 <= pos7;// keep previous position
					else if(PL_en2[6]==1'b1)
						pos7 <= 2'b10; // store player2 data 
					else if (PL_en1[6]==1'b1)
						pos7 <= 2'b01;// store player 1 data 
					else 
						pos7 <= pos7;// keep previous position
					end 
			end 
		 // Position 8 
		always @(posedge clk or posedge reset)
			begin
				if(reset) 
					pos8 <= 2'b00;
				else begin
					if(illegal_move==1'b1)
						pos8 <= pos8;// keep previous position
					else if(PL_en2[7]==1'b1)
						pos8 <= 2'b10; // store player2 data 
					else if (PL_en1[7]==1'b1)
						pos8 <= 2'b01;// store player 1 data 
					else 
						pos8 <= pos8;// keep previous position
					end 
			end 
		 // Position 9 
		always @(posedge clk or posedge reset)
			begin
				if(reset) 
					pos9 <= 2'b00;
				else begin
					if(illegal_move==1'b1)
						pos9 <= pos9;// keep previous position
					else if(PL_en2[8]==1'b1)
						pos9 <= 2'b10; // store player2 data 
					else if (PL_en1[8]==1'b1)
						pos9 <= 2'b01;// store player 1 data 
					else 
						pos9 <= pos9;// keep previous position
					end 
			end  
		endmodule 

		
module state_controller(
	input play1,play2, illegal_move, no_space, win,
	input [1:0] present_state,
	output reg [1:0] next_state
	);
	parameter IDLE=2'b00;
	parameter PLAYER1=2'b01;
	parameter PLAYER2=2'b10;
	parameter GAME_DONE=2'b11;

	always @(*) begin
		case(present_state)
			IDLE: begin
			if(no_space == 1 || win == 1 ) next_state <= GAME_DONE;
			else if (illegal_move == 1) next_state <= present_state;
			else if (play2 ==1 && play1 ==0) next_state <= PLAYER2;
			else if (play2 ==0 && play1 ==1) next_state <= PLAYER1;
			else next_state <= present_state;
			end	
			
			PLAYER1: begin
			if(no_space == 1 || win == 1 ) next_state <= GAME_DONE;
			else if (illegal_move == 1) next_state <= present_state;
			else if (play2 ==1 && play1 ==0) next_state <= PLAYER2;
			else if (play2 ==0 && play1 ==1) next_state <= PLAYER1;
			else next_state <= present_state;
			end	
			
			PLAYER2: begin
			if(no_space == 1 || win == 1 ) next_state <= GAME_DONE;
			else if (illegal_move == 1) next_state <= present_state;
			else if (play2 ==1 && play1 ==0) next_state <= PLAYER2;
			else if (play2 ==0 && play1 ==1) next_state <= PLAYER1;
			else next_state <= present_state;
			end	
			GAME_DONE: begin
			next_state <= present_state;
			end
		endcase
	end
	endmodule
module currentstate(clk, nextstate, presentstate, reset);
	input clk, reset;
	input [1:0] nextstate;
	output [1:0] presentstate;
	reg we;

	initial begin
	we =1;
	end
		
	reg1bit tow(we, presentstate[1], nextstate[1], clk, reset);
	reg1bit one(we, presentstate[0], nextstate[0], clk, reset);
	endmodule

module dflipflop(d, clk, reset, q );
	input clk, reset,d ;
	output q;
	reg q;
	initial begin q <=0;
	end
	always @(posedge clk or posedge reset)begin
		if(reset ==1'b1)
			q <= 0;
		else
			q = d;
	end
	endmodule

module reg1bit(writeEn, outbit, inbit, clk, reset);
	input writeEn, inbit, clk, reset;
	output outbit;
	wire in1, in2;
	and  and1(in1, writeEn, inbit);
	and and2(in2, ~writeEn, outbit);
	or  or1(d, in1, in2);
	dflipflop dff1(.d(d),.clk(clk),.reset(reset),.q(outbit));
	endmodule
module output_controller(
	input [1:0] present_state,	
     	output reg player_play2, // enable player2 to play 
     	player_play1 // enable player 1 to play 
	);
	parameter IDLE=2'b00;
	parameter PLAYER1=2'b01;
	parameter PLAYER2=2'b10;
	parameter GAME_DONE=2'b11;
	
	always @(present_state) begin
		case(present_state) 
			IDLE: begin
				player_play2 <= 0;
				player_play1 <= 0;
			end
			PLAYER1: begin
				player_play2 <= 0;
				player_play1 <= 1;
			end
			PLAYER2: begin
				player_play2 <= 1;
				player_play1 <= 0;
			end
			GAME_DONE: begin
				player_play2 <= 0;
				player_play1 <= 0;
			end
	
		endcase
	end

	endmodule

// to detect if no more spaces to play 
module nospace_detector(
   input [1:0] pos1,pos2,pos3,pos4,pos5,pos6,pos7,pos8,pos9, 
   output wire no_space
    );
	wire temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9;
	// detect no more space     
	assign temp1 = pos1[1] | pos1[0];
	assign temp2 = pos2[1] | pos2[0];
	assign temp3 = pos3[1] | pos3[0];
	assign temp4 = pos4[1] | pos4[0];
	assign temp5 = pos5[1] | pos5[0];
	assign temp6 = pos6[1] | pos6[0];
	assign temp7 = pos7[1] | pos7[0];
	assign temp8 = pos8[1] | pos8[0];
	assign temp9 = pos9[1] | pos9[0];
	// output
	assign no_space =((((((((temp1 & temp2) & temp3) & temp4) & temp5) & temp6) & temp7) & temp8) & temp9);
	endmodule 

// to detect if a player plays on an exist position 
module illegal_move_detector(
	input [1:0] pos1,pos2,pos3,pos4,pos5,pos6,pos7,pos8,pos9, 
	input [8:0] PL_en2, PL_en1, 
	output wire illegal_move
	);
	wire temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9;
	wire temp11,temp12,temp13,temp14,temp15,temp16,temp17,temp18,temp19;
	wire temp21,temp22;
	// player 1 : illegal moving    
	assign temp1 = (pos1[1] | pos1[0]) & PL_en1[0];
	assign temp2 = (pos2[1] | pos2[0]) & PL_en1[1];
	assign temp3 = (pos3[1] | pos3[0]) & PL_en1[2];
	assign temp4 = (pos4[1] | pos4[0]) & PL_en1[3];
	assign temp5 = (pos5[1] | pos5[0]) & PL_en1[4];
	assign temp6 = (pos6[1] | pos6[0]) & PL_en1[5];
	assign temp7 = (pos7[1] | pos7[0]) & PL_en1[6];
	assign temp8 = (pos8[1] | pos8[0]) & PL_en1[7];
	assign temp9 = (pos9[1] | pos9[0]) & PL_en1[8];
	// player2 : illegal moving  
	assign temp11 = (pos1[1] | pos1[0]) & PL_en2[0];
	assign temp12 = (pos2[1] | pos2[0]) & PL_en2[1];
	assign temp13 = (pos3[1] | pos3[0]) & PL_en2[2];
	assign temp14 = (pos4[1] | pos4[0]) & PL_en2[3];
	assign temp15 = (pos5[1] | pos5[0]) & PL_en2[4];
	assign temp16 = (pos6[1] | pos6[0]) & PL_en2[5];
	assign temp17 = (pos7[1] | pos7[0]) & PL_en2[6];
	assign temp18 = (pos8[1] | pos8[0]) & PL_en2[7];
	assign temp19 = (pos9[1] | pos9[0]) & PL_en2[8];
	// intermediate signals 
	assign temp21 =((((((((temp1 | temp2) | temp3) | temp4) | temp5) | temp6) | temp7) | temp8) | temp9);
	assign temp22 =((((((((temp11 | temp12) | temp13) | temp14) | temp15) | temp16) | temp17) | temp18) | temp19);
	// output illegal move 
	assign illegal_move = temp21 | temp22 ;
	endmodule 
// to detect who the winner is 
// We will win when we have 3 similar (x) or (O) in the following pairs: 
// (1,2,3); (4,5,6);(7,8,9); (1,4,7); (2,5,8);(3,6,9); (1,5,9);(3,5,7); 
module winner_detector(input [1:0] pos1,pos2,pos3,pos4,pos5,pos6,pos7,pos8,pos9, output wire winner, output wire [1:0]who);
	wire win1,win2,win3,win4,win5,win6,win7,win8;
	wire [1:0] who1,who2,who3,who4,who5,who6,who7,who8;
	winner_detect_3 u1(pos1,pos2,pos3,win1,who1);// (1,2,3);
	winner_detect_3 u2(pos4,pos5,pos6,win2,who2);// (4,5,6);
	winner_detect_3 u3(pos7,pos8,pos9,win3,who3);// (7,8,9);
	winner_detect_3 u4(pos1,pos4,pos7,win4,who4);// (1,4,7);
	winner_detect_3 u5(pos2,pos5,pos8,win5,who5);// (2,5,8);
	winner_detect_3 u6(pos3,pos6,pos9,win6,who6);// (3,6,9);
	winner_detect_3 u7(pos1,pos5,pos9,win7,who7);// (1,5,9);
	winner_detect_3 u8(pos3,pos5,pos6,win8,who8);// (3,5,7);
	assign winner = (((((((win1 | win2) | win3) | win4) | win5) | win6) | win7) | win8);
	assign who = (((((((who1 | who2) | who3) | who4) | who5) | who6) | who7) | who8);
	endmodule

// winner detection for 3 positions && determine who the winner is 
// Player1: 01
// player2: 10
module winner_detect_3(input [1:0] pos0,pos1,pos2, output wire winner, output wire [1:0]who);
	wire [1:0] temp0,temp1,temp2;
	wire temp3;
	assign temp0[1] = !(pos0[1]^pos1[1]);
	assign temp0[0] = !(pos0[0]^pos1[0]);
	assign temp1[1] = !(pos2[1]^pos1[1]);
	assign temp1[0] = !(pos2[0]^pos1[0]);
	assign temp2[1] = temp0[1] & temp1[1];
	assign temp2[0] = temp0[0] & temp1[0];
	assign temp3 = pos0[1] | pos0[0];
	// winner if 3 positions are similar && should be 01 or 10 
	assign winner = temp3 & temp2[1] & temp2[0];
	// determine who the winner is 
	assign who[1] = winner & pos0[1];
	assign who[0] = winner & pos0[0];
	endmodule
