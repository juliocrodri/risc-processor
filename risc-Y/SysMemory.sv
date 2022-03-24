/**********************************************************************************
***                                                                            	***
*** EE 526 L Experiment #10                        Julio Rodriguez, Spring,2019	***
***                                                                            	***
*** SysMemory 		                                                       	***
*** Program Counter + Instruction ROM + MIR 		                        ***
***********************************************************************************
*** SysMemory.sv      			      created by Julio R. , May 3 2019 	***
*** - Version 1.0  	      	     					      	***
*** 										***
*** Fetches next instruction into MIR output pins				***
*** PC <-PC+4 or PC<-BranchAddress						***
***********************************************************************************/							

`timescale 1ns/100ps

module SysMemory(
	input reg 	 ROM_CS,
			 ROM_OE,
			 LOAD_EN,
			 PC_EN,
			 IR_EN,
	input reg 	 [4:0] InstADDR,
	output wire  	 I_Flag,
	output wire [3:0] OPCODE,
	output wire [6:0] ImediateADDR,
	output wire [7:0] RomData); 	

	//intermediate variables
	wire [4:0] ProgADDR; // ROM <- Program Counter
	wire [31:0] InstBUS; // MIR <- ROM
												
	//note it would be useful to have multiple names for same bits covered in one of the lectures
	//structures and unions 526Lec10

	Prog_Cntr	ProgramCounter(.*); //name match all -> make module for this its a counter that can be side loaded 
	ROM	#(5,32) InstructionROM(.*,.ADDR(ProgADDR),.DATA(InstBUS));
	MemReg #(32) MIR(1'b0,.OE(IR_EN),.WS(CLK),.DATA(InstBUS),{OPCODE,I_Flag,ImediateADDR,RomData}; 
	//concat the outputs modify RAM turn into MemReg, default 32bits wide
	//MemReg can used for be MIR or MAR or MBR
endmodule


