/**********************************************************************************
***                                                                            	***
*** EE 526 L Experiment #10                        Julio Rodriguez, Spring,2019	***
***                                                                            	***
*** RISC-Y Processor                                                           	***
*** instances of smaller modules to model a RISC-Y                            	***
***********************************************************************************
*** Top.sv             		             created by Julio R. , Apr 11 2019  ***
*** - Version 1.0  	      	     						***
*** 										***
*** Call instances of individual items and connect them			     	***
***********************************************************************************/							

`timescale 1ns/100ps

module RISCY(input CLK,RST, inout [7:0] IO ); 	// Processor has very few external connections
						//everything else should be instantiated

	//connectors for modules
	wire [3:0] OPCODE;
	wire [6:0] ADDR;
	wire [7:0] RomDATA; 		//lower 8 bits are imediate data passed with instruction
	wire [7:0] RamDATA;
	wire [7:0] DATA; 		//gets value from either rom or ram
	wire [7:0] WritebackData; 	//could be driven from ALU or Port Read never at same time
	wire [4:0] PCADDR,BranchADDR;
	wire 		IR_EN,
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
			RAM_CS;		//all wires are single pins, use name matching so they go to appropiate pins.

	//Instruction Memory + Program Counter
	SysMemory	Memory(.*); //match all names
	//RAM + RDR
	SysRAM		RegFile(.*); //match all names, note 4lsb of RomDATA taken as ADDR for ram.
	//Controller - this module is sequence controller + phase generator from lab 9
	Controller	SysCntrl(.*);
	//ALU - From previous lab, make sure to match OPcodes 
	ALU	SysALU(.*);
	//IO Subsystem
	IO_Sub	SysIO(.*);
	//MUX
	SclMux #(8) SysMUX(RomDATA,RamDATA,RAM_OE,DATA); //#(value) is syntax for redefining param1


endmodule


