Tic Tac Toe game on Ico board FPGA
Pre-requisites:
Linux machine
Fair knowledge on verilog HDL
Should be comfortable with simulating verilog HDL projects in their favourite simulator
Understand FSM

Setup
Please install iverilog or any other verilog HDL simulator. Here, I am using iverilog. 
$ sudo apt-get install iverilog
Install the required packages to work on Ico board by following the document https://github.com/gadepall/EE5811/blob/master/icoboard_fpga/gvv_hemanth_icoboard.pdf
Get a local repository of our project from github 
$ git pull https://github.com/CHINTADINESH/tic_tac_toe_extension 
Simulation
We can use iverilog to simulate the project. You are however free to use any simulator. 
        $ iverilog -o tic_tac_toe tb_tttg.v tttg.v


dinesh@UB18:~/Desktop/tic_tac_toe_extension$ ls
Makefile   tb_tttg.v                 tic_tac_toe_extension2x2.tar.gz  tttg.v
README.md  tic_tac_toe_extension2x2  tttg.pcf
dinesh@UB18:~/Desktop/tic_tac_toe_extension$ iverilog -o tic_tac_toe tb_tttg.v tttg.v




If iverilog works properly, you will get an binary named tic_tac_toe in the project directory.

dinesh@UB18:~/Desktop/tic_tac_toe_extension$ ls
Makefile   tb_tttg.v    tic_tac_toe_extension2x2         tttg.pcf
README.md  tic_tac_toe  tic_tac_toe_extension2x2.tar.gz  tttg.v



Now execute the binary. 
$ ./tic_tac_toe


dinesh@UB18:~/Desktop/tic_tac_toe_extension$ ./tic_tac_toe

time =   0
 0 0 0
 0 0 0
 0 0 0
 winner = 0


time = 405
 0 0 0
 0 0 0
 0 0 1
 winner = 0


time = 803
 0 0 0
 0 0 0
 0 2 1
 winner = 0


time = 1405
 0 0 0
 0 0 0
 1 2 1
 winner = 0


time = 1603
 0 2 0
 0 0 0
 1 2 1
 winner = 0


time = 2205
 0 2 0
 0 0 1
 1 2 1
 winner = 0


time = 2803
 0 2 2
 0 0 1
 1 2 1
 winner = 0


time = 3405
 0 2 2
 0 1 1
 1 2 1
 winner = 0


time = 4003
 2 2 2
 0 1 1
 1 2 1
 winner = 2

^C** VVP Stop(0) **
** Flushing output streams.
** Current simulation time is 624565000 ticks.
> finish
** Continue **
dinesh@UB18:~/Desktop/tic_tac_toe_extension$



Synthesis on Ico Board
If you have followed https://github.com/gadepall/EE5811/blob/master/icoboard_fpga/gvv_hemanth_icoboard.pdf
Then you are all set to synthesize the project on icoboard. The following command will dump the verilog on the ico board.
$ make v_fname=tttg
    
 


