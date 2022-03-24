/*********************************************************************************
***                                                                            ***
*** EE 526 L Experiment #7                         Julio Rodriguez, Spring,2019***
***                                                                            ***
*** Ram module                                                                 ***
***                                                                            ***
**********************************************************************************
*** Ram.v                                     created by Julio R. , Mar 28 2019***
*** - Version 1.0  	      	     					       ***
*** Ram implemented using register file                                        ***
*********************************************************************************/							

`timescale 1ns/1ns

module RAM(ADDR,OE,WS,CS_n,DATA);
	//parameters
	parameter Depth =5;
	parameter Width	=8;
	//port declaration
	input [Depth-1:0] ADDR;//memory depth is determined by ADDR
	input OE,WS,CS_n; //CS_n is active low
	inout [Width-1:0] DATA;//memory width is determined by DATA width

	

	//internal
	reg [Width-1:0] MEMORY [0:(2**Depth)-1]; 
	reg [Width-1:0] databuff;

//Start Behaviour
//Tristate driver for data
	assign DATA = (!CS_n && OE && !WS)? databuff : {Width{1'bz}};

//reg memory useing always_ff so that its syncronous 
	always_comb begin
	//read
	if(!CS_n && !WS && OE)
	//databuff=(CS_n && !WS && OE)? MEMORY[ADDR] : ; 
	databuff=MEMORY[ADDR]; 
	else
	//nothing
   	end

	always_ff @(posedge WS)begin
	//write - this style probably infers a latch?
	if(!CS_n && WS && !OE)
		 MEMORY[ADDR]=DATA ; 
	else
	//nothings
	end

endmodule
