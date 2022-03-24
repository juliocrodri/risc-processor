/**********************************************************************************
***                                                                           	***
*** EE 526 L Experiment #9                         Julio Rodriguez, Spring,2019	***
***                                                                            	***
*** Sequence Controller                                                        	***
*** single bit control outputs based on instruction fed                        	***
***********************************************************************************
*** tb_riscy.sv                              created by Julio R. , Apr 7 2019	***
*** - Version 1.0  	      	     						***
*** TB -generate a clock and have soft processor run through instructions      	***
*** preloaded in a ROM module 							***
**********************************************************************************/							

`timescale 1ns/100ps

module tb_riscy();
	 reg	CLK,RST;
	wire [7:0] InOut; //setup as tristate connection?

	//instantiate top design
	riscy	UTT(CLK,RST,InOut);
	//generate clock
   	initial begin
		CLK=1'b0;
		forever #10 CLK=~CLK; 
	end

	//ROM preloaded with instructions monitor -> watch internal signals. 
	initial begin
	$vcdpluson;

	$display("             --------------------------------------------------------------------");
	$display (" RISCY Testing ");
	$display("             --------------------------------------------------------------------");
	
	$display(" %d |CLK|   Instruction    |",$time);
	$monitor(" %d | %b |%b|",$time,{UTT.Memory.OPCODE,UTT.Memory.I_Flag,UTT.Memory.InstADDR,UTT.Memory.RomData});

	


endmodule


