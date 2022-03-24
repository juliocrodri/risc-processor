/*********************************************************************************
***                                                                            ***
*** EE 526 L Experiment #6                         Julio Rodriguez, Spring,2019***
***                                                                            ***
***                                                                            ***
***                                                                            ***
**********************************************************************************
*** Rom.v                                     created by Julio R. , Apr 04 2019***
*** - Version 1.0  	      	     					       ***
*** Rom implemented using register file                                        ***
*********************************************************************************/							

`timescale 1ns/1ns

module ROM(ADDR,OE,CS_n,DATA);
	//parameters
	parameter Depth =5;
	parameter Width	=8;
	//port declaration
	input [Depth-1:0] ADDR;//memory depth is determined by ADDR
	input OE,CS_n; //CS_n is active low
	output [Width-1:0] DATA;//memory width is determined by DATA width

	

	//internal
	reg [Width-1:0] MEMORY [0:(2**Depth)-1]; 
	reg [Width-1:0] databuff;

//Start Behaviour
	//initialize memory from file
	initial begin
		$readmemh("Rominit.txt",MEMORY);
	end
//Tristate driver for data still needed with DATA being output port only?
	assign DATA = (!CS_n && OE)? databuff : {Width{1'bz}};

//reg memory
	always_comb begin //using posedge treats OE as a strobe not an enable pin
	//read
	if(!CS_n && OE)
		databuff=MEMORY[ADDR]; 
	else //to not infer a latch? 
		databuff='bz;
	end

endmodule
