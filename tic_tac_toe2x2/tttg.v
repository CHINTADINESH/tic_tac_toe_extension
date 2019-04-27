// cdineshrdy@gmail.com 
module tttg(
     input clk, // clock of the game 
     input reset, // reset button to reset the game 
     input play1, // play1 button to enable player to play 
     input play2, // play2 button to enable player 2 to play 
     input [3:0] button,
     output wire [1:0] pos1,pos2,pos3,
     pos4,
     output wire[1:0]who, present_state 
     );

	 reg [3:0] PL_en2;// player 2 enable signals 
	 reg [3:0] PL_en1; // Player enable signals 
	 wire illegal_move; // disable writing when an illegal move is detected 
	 wire win; // win signal 
	 wire player_play2; // player 2 enabling signal 
	 wire player_play1; // player enabling signal 
	 wire no_space; // no space signal 
	 wire [1:0] next_state ;
	 // position registers    
	 position_registers position_reg_unit(
	      clk, // clock of the game 
	      reset, // reset the game 
	      illegal_move, // disable writing when an illegal move is detected 
	      PL_en2[3:0], // player 2 enable signals 
	      PL_en1[3:0], // Player enable signals 
	      pos1,pos2,pos3,pos4// positions stored
	      );
	 // winner detector 
	 winner_detector win_detect_unit(pos1,pos2,pos3,pos4,win, who);
	 // position decoder for player 2 
	 always @ (posedge clk ) begin

		 PL_en2 <= (player_play2==1'b1) ?button: 4'b0;
		 PL_en1 <= (player_play1==1'b1) ?button: 4'b0;
	 end
	 
	 // illegal move detector
	 illegal_move_detector imd_unit(
	   pos1,pos2,pos3,pos4, 
	   PL_en2[3:0], PL_en1[3:0], 
	   illegal_move
	   );
	 // no space detector 
	nospace_detector nsd_unit(
	   pos1,pos2,pos3,pos4,
	   no_space
	    ); 

	currentstate cs (clk, next_state, present_state, reset);
	output_controller oc (present_state,player_play2, player_play1  );
	state_controller sc (play1,play2, illegal_move, no_space, win,present_state,next_state);
	
     endmodule

// to store player or computer positions 
// when enabling by the FSM controller 
module position_registers(
      input clk, // clock of the game 
      input reset, // reset the game 
      input illegal_move, // disable writing when an illegal move is detected 
      input [3:0] PL_en2, // player 2 enable signals 
      input [3:0] PL_en1, // Player enable signals 
      output reg[1:0] pos1,pos2,pos3,pos4// positions stored
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
						pos1 <= 2'b10; // store player 2 data 
					else if (PL_en1[0]==1'b1)
						pos1 <= 2'b01;// store player data 
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
						pos2 <= 2'b10; // store player 2 data 
					else if (PL_en1[1]==1'b1)
						pos2 <= 2'b01;// store player data 
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
					pos3 <= 2'b10; // store player 2 data 
				else if (PL_en1[2]==1'b1)
					pos3 <= 2'b01;// store player data 
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
						pos4 <= 2'b10; // store player 2 data 
					else if (PL_en1[3]==1'b1)
						pos4 <= 2'b01;// store player data 
					else 
						pos4 <= pos4;// keep previous position
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
     	output reg player_play2, // enable player 2 to play 
     	player_play1 // enable player to play 
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
   input [1:0] pos1,pos2,pos3,pos4,
   output wire no_space
    );
	wire temp1,temp2,temp3,temp4;
	// detect no more space     
	assign temp1 = pos1[1] | pos1[0];
	assign temp2 = pos2[1] | pos2[0];
	assign temp3 = pos3[1] | pos3[0];
	assign temp4 = pos4[1] | pos4[0];
	// output
	assign no_space =(((temp1 & temp2) & temp3) & temp4);
	endmodule 

// to detect if a player plays on an exist position 
module illegal_move_detector(
	input [1:0] pos1,pos2,pos3,pos4, 
	input [3:0] PL_en2, PL_en1, 
	output wire illegal_move
	);
	wire temp1,temp2,temp3,temp4;
	wire temp11,temp12,temp13,temp14;
	wire temp21,temp22;
	// player : illegal moving    
	assign temp1 = (pos1[1] | pos1[0]) & PL_en1[0];
	assign temp2 = (pos2[1] | pos2[0]) & PL_en1[1];
	assign temp3 = (pos3[1] | pos3[0]) & PL_en1[2];
	assign temp4 = (pos4[1] | pos4[0]) & PL_en1[3];
	// player 2 : illegal moving  
	assign temp11 = (pos1[1] | pos1[0]) & PL_en2[0];
	assign temp12 = (pos2[1] | pos2[0]) & PL_en2[1];
	assign temp13 = (pos3[1] | pos3[0]) & PL_en2[2];
	assign temp14 = (pos4[1] | pos4[0]) & PL_en2[3];
	// intermediate signals 
	assign temp21 =(((temp1 | temp2) | temp3) | temp4) ;
	assign temp22 =(((temp11 | temp12) | temp13) | temp14) ;
	// output illegal move 
	assign illegal_move = temp21 | temp22 ;
	endmodule 
// to detect who the winner is 
module winner_detector(input [1:0] pos1,pos2,pos3,pos4, output wire winner, output wire [1:0]who);
	wire win1,win2,win3,win4,win5,win6;
	wire [1:0] who1,who2,who3,who4,who5,who6;
	winner_detect_2 u1(pos1,pos2,win1,who1);// (1,2);
	winner_detect_2 u2(pos3,pos4,win2,who2);// (3,4);
	winner_detect_2 u3(pos1,pos3,win3,who3);// (1,3);
	winner_detect_2 u4(pos2,pos4,win4,who4);// (2,4);
	winner_detect_2 u5(pos1,pos4,win5,who5);// (1,4);
	winner_detect_2 u6(pos3,pos2,win6,who6);// (3,2);
	assign winner = (((((win1 | win2) | win3) | win4) | win5) | win6) ;
	assign who = (((((who1 | who2) | who3) | who4) | who5) | who6) ;
	endmodule

// Player: 01
// player 2: 10
module winner_detect_2(input [1:0] pos0,pos1, output wire winner, output wire [1:0]who);
	wire [1:0] temp0;
	wire temp3;
	assign temp0[1] = !(pos0[1]^pos1[1]);
	assign temp0[0] = !(pos0[0]^pos1[0]);
	assign temp3 = pos0[1] | pos0[0];
	assign winner = temp3 & temp0[1] & temp0[0];
	// determine who the winner is 
	assign who[1] = winner & pos0[1];
	assign who[0] = winner & pos0[0];
	endmodule
