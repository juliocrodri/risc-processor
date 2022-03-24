/**********************************************************************************
***                                                                            	***
*** EE 526 L Experiment #10                        Julio Rodriguez, Spring,2019	***
***                                                                            	***
*** tb_Controller 		                                                ***
*** Seq_Controller + PhaseGenerator	 		                        ***
***********************************************************************************
*** tb_Controller.sv      		  created by Julio R. , May 7 2019 	***
*** - Version 1.0  	      	     					      	***
*** 										***
*** Generates Values for pins							***
***********************************************************************************/							

`timescale 1ns/100ps

module tb_Controller();
	reg 	Ena,
		CLK,
		RST,
		I_Flag;
	reg [3:0] OPCODE;
	reg [6:0] InstADDR;
	reg [3:0] ALU_Flags;
	wire 	IR_EN,
		A_EN,
		B_EN,
		PDR_EN,
		PORT_EN,
		PORT_RD,
		PC_EN,
		PC_LOAD,
		ALU_EN,
		ALU_OE,
		RAM_OE,
		RDR_EN,
		RAM_CS;
	
	//instance of test 
	Controller	UTT(.*);
	

	//generate clock
   	initial begin
		CLK=1'b0;
		forever #10 CLK=~CLK; 
		//repeat(5) #10 CLK=~CLK;
	end

	initial begin
	$vcdpluson;
	Ena=1'b0; //always enabled

	$display("             --------------------------------------------------------------------");
	$display (" Controller Testing - Lab9 ");
	$display("             --------------------------------------------------------------------");
	
	$display("%d  | CLK | OPCode:I:ALU_Flags:InstADDR |  Output Bits  |",$time);
	
	$monitor("%d  | %b |%b:%b:%b:%b| %b%b%b%b%b%b |",CLK, OPCODE,I_Flag,ALU_Flags,InstADDR,
		IR_EN,
		A_EN,
		B_EN,
		PDR_EN,
		PORT_EN,
		PORT_RD,
		PC_EN,
		PC_LOAD,
		ALU_EN,
		ALU_OE,
		RAM_OE,
		RDR_EN,
		RAM_CS); //concat the outputbits into a stream, does it work?
	//put in some values for OPcode etc.
	#10 OPCODE=4'b0000; //load instruction
	I_Flag=1'b0;
	InstADDR=7'b0000000;
	ALU_Flags=4'b0000;
	#10 //do other stuff after some time
	#10 OPCODE=4'b0001; //load instruction
	I_Flag=1'b0;
	InstADDR=7'b0000000;
	ALU_Flags=4'b0000;

	#10 $finish;
	end

endmodule


