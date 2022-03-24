/**********************************************************************************
***                                                                            	***
*** EE 526 L Experiment #10                        Julio Rodriguez, Spring,2019	***
***                                                                            	***
*** SystemRAM	 	                                                       	***
*** type of Register File: holds RDR,ALUOutput		                        ***
*** as well as portpins								***
***********************************************************************************
*** SysRAM.sv		      		      created by Julio R. , May 7 2019 	***
*** - Version 1.0  	      	     					      	***
*** 										***
*** Fetches next instruction into MIR output pins				***
*** PC <-PC+4 or PC<-BranchAddress						***
***********************************************************************************/							

`timescale 1ns/100ps

module SysRAM(
	input reg 	RAM_CS,
			RAM_OE,
			CLK,
			RDR_EN,
	input wire [7:0] Datain,
	input wire [4:0] RomData,
	input wire [7:0] ALUData,
	input wire [7:0] PortData,
	output wire [7:0] RamData); //CLK is the RAM Write Strobe & RomData drives the RAM ADDR
	
	//intermediate variables
	wire [7:0]	DATA; // wire to take ALU_Data & Port_Read Data also bidir RAM <--> RDR

	// wire will have multiple drivers, we expect hi z from the ones not in use 
	assign DATA = PortData;
	assign DATA = ALUData; //only one of these will be no high z when running

	RAM	DatMem(RomData,RAM_OE,CLK,RAM_CS,DATA); 
	MemReg #(32) RamDataReg(RDR_EN,DATA}; //bidirectional version of MemReg

endmodule
