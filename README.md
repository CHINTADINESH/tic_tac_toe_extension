## Tic Tac Toe game on Ico board FPGA
Pre-requisites:
Raspberry pi, Ico board, miscellaneous electrical components
Fair knowledge on verilog HDL
Should be comfortable with simulating verilog HDL projects in their favourite simulator
Understand FSM
## Setup
Please install iverilog or any other verilog HDL simulator. Here, I am using iverilog. 
$ sudo apt-get install iverilog
Install the required packages to work on Ico board by following the document https://github.com/gadepall/EE5811/blob/master/icoboard_fpga/gvv_hemanth_icoboard.pdf
Get a local repository of our project from github 
$ git pull https://github.com/CHINTADINESH/tic_tac_toe_extension 
## Simulation
We can use iverilog to simulate the project. You are however free to use any simulator. 
		$ iverilog -o tic_tac_toe tb_tttg.v tttg.v

dinesh@UB18:~/Desktop/tic_tac_toe_extension$ ls
Makefile   tb_tttg.v             	tic_tac_toe_extension2x2.tar.gz  tttg.v
README.md  tic_tac_toe_extension2x2  tttg.pcf
dinesh@UB18:~/Desktop/tic_tac_toe_extension$ iverilog -o tic_tac_toe tb_tttg.v tttg.v

If iverilog works properly, you will get an binary named tic_tac_toe in the project directory.

dinesh@UB18:~/Desktop/tic_tac_toe_extension$ ls
Makefile   tb_tttg.v	tic_tac_toe_extension2x2     	tttg.pcf
README.md  tic_tac_toe  tic_tac_toe_extension2x2.tar.gz  tttg.v

Now execute the binary. 

dinesh@UB18:~/Desktop/tic_tac_toe_extension$ ./tic_tac_toe

time =   0
 0 0 0
 0 0 0
 0 0 0
 winner = 0
 present_state = 0
 illegal_move = 0
 

time = 401
 0 0 0
 0 0 0
 0 0 0
 winner = 0
 present_state = 1
 illegal_move = 0
 

time = 603
 0 0 0
 0 0 0
 0 0 1
 winner = 0
 present_state = 1
 illegal_move = 1
 
…………………….
…………………….
…………………….
 

time = 4601
 0 2 2
 0 1 1
 1 2 1
 winner = 0
 present_state = 2
 illegal_move = 0
 

time = 4803
 2 2 2
 0 1 1
 1 2 1
 winner = 2
 present_state = 2
 illegal_move = 1
 

time = 4805
 2 2 2
 0 1 1
 1 2 1
 winner = 2
 present_state = 3
 illegal_move = 1
 

time = 4807
 2 2 2
 0 1 1
 1 2 1
 winner = 2
 present_state = 3
 illegal_move = 0
 
^C** VVP Stop(0) **
** Flushing output streams.
** Current simulation time is 556077000 ticks.
>
## Synthesis on Ico Board
If you have followed https://github.com/gadepall/EE5811/blob/master/icoboard_fpga/gvv_hemanth_icoboard.pdf
Then you are all set to synthesize the project on icoboard. The following command will dump the verilog on the ico board.

$ make v_fname=tttg

………………………
………………………
………………………
………………………
………………………

place...
  initial wire length = 3062
  at iteration #50: temp = 10.5745, wire length = 2231
  at iteration #100: temp = 6.33134, wire length = 1817
  at iteration #150: temp = 2.2697, wire length = 1191
  at iteration #200: temp = 0.438517, wire length = 849
  final wire length = 807

After placement:
PIOs       31 / 206
PLBs       37 / 960
BRAMs      0 / 32

  place time 4.13s
route...
  pass 1, 1 shared.
  pass 2, 0 shared.

After routing:
span_4     198 / 29696
span_12    59 / 5632

  route time 5.99s
write_txt tttg.asc...
icetime -d hx8k -c 25 tttg.asc
// Reading input .asc file..
// Reading 8k chipdb file..
// Creating timing netlist..
// Timing estimate: 9.93 ns (100.68 MHz)
// Checking 40.00 ns (25.00 MHz) clock constraint: PASSED.
icepack tttg.asc tttg.bin
icoprog -p < tttg.bin
reset..
cdone: low
programming..
cdone: low

The output should be something like shown above.


