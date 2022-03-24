/**********************************************************************************
***                                                                            	***
*** EE 526 L Experiment #10                        Julio Rodriguez, Spring,2019	***
***                                                                            	***
*** Controller 		                                                       	***
*** Seq_Controller + PhaseGenerator	 		                        ***
***********************************************************************************
*** Controller.sv      			      created by Julio R. , May 7 2019 	***
*** - Version 1.0  	      	     					      	***
*** 										***
*** Generates Values for pins							***
***********************************************************************************/							

`timescale 1ns/100ps

`include "SubModules/seq_ctrlr.sv"
`include "SubModules/Phase_gen.sv"
//`include "SubModules/pckg_cntrlr.sv" //include file package - already imported when including lower level files
//import pckg_cntrlr::*; 	//import elements in file

//typedef enum reg[1:0] {FETCH,DECODE,EXECUTE,UPDATE} SeqState;//seq state type can be used in module
module Controller(
	input reg 	Ena,
			CLK,
			RST,
			I_Flag,
	input reg [3:0] OPCODE,
	input reg [3:0] ALU_Flags,
	input reg [6:0] InstADDR,
	output wire 	IR_EN,
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
			RAM_CS);
//intermediate value (phase enum type)
	SeqState Phase;//"wire" between sequencer and phase generator
//component instances
	//Seq_Controller
	seq_ctrlr	sequencer(.*);//enum type is input
	//phase GEN
	Phase_gen	Phaser(.*);// need enumerated type in output port

											

endmodule


