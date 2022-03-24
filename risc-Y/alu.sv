/*********************************************************************************
***                                                                            ***
*** EE 526 L Experiment #8                         Julio Rodriguez, Spring,2019***
***                                                                            ***
*** FullAdder                                                                  ***
***                                                                            ***
**********************************************************************************
*** ALU.sv                                    created by Julio R. , Apr 04 2019***
*** - Version 1.0  	      	     					       ***
*** Ram 				                                       ***
*********************************************************************************/							

`timescale 1ns/100ps

module ALU(CLK,EN,OE,OPCODE,A,B,ALU_OUT,CF,OF,SF,ZF);
	//parameters
	parameter Width	=8;
	//port declaration
	output [Width-1:0] ALU_OUT;
	output  CF,OF,SF,ZF;
	input [3:0] OPCODE;
	input [Width-1:0] A,B;
	input CLK,EN,OE;

	
	//internal
	//reg [Width-1:0] TwosCompB; //used for easier subtraction
	enum reg[2:0] {AB_ADD,AB_SUB,AB_AND,AB_OR,AB_XOR,A_NOT} ALU_STATE;
	reg [Width-1:0] ALU_RES;
	reg [3:0] FLAGS;

	//local params -> not changed from higher up improve readability
	//can be modified in one place if opcode for instruction changes
	localparam ALU_ADD=4'b0010;
	localparam ALU_SUB=4'b0011;
	localparam ALU_AND=4'b0100;
	localparam ALU_OR=4'b0101;
	localparam ALU_XOR=4'b0110;
	localparam ALU_Anot=4'b0111;


	//check opcode, assign state.

	assign  ALU_OUT=(!OE)?'bz:ALU_RES;
	assign {CF,OF,SF,ZF}=(!OE)?4'bz:FLAGS;

	always_comb begin
		//go to state based on opcode 
		case (OPCODE)
		ALU_ADD: begin
			ALU_STATE=AB_ADD;
			//OF flag -> if signed bit is diff/changes after addigion for overflow
			FLAGS[2]<=((A[Width-1] == B[Width-1])==ALU_RES[Width-1])? 1'b1:1'b0; 
			// negative flag matters if signed is being used to programmer
			FLAGS[1]<=(ALU_RES[Width-1]==1)?1'b1:1'b0;
			//zero flag can be Pos + neg cancel out or 0+0. result is zero regardless
			FLAGS[0]<=(ALU_RES==0)?1'b1:1'b0;
			end
		ALU_SUB: begin
			ALU_STATE=AB_SUB;
			FLAGS[2]<=(A[Width-1] && B[Width-1]==ALU_RES[Width-1])? 1'b1:1'b0; 
			FLAGS[1]<=(ALU_RES[Width-1]==1)?1'b1:1'b0;
			FLAGS[0]<=(ALU_RES==0)?1'b1:1'b0; 
			end
		ALU_AND: begin
			ALU_STATE=AB_AND;
			//FLAGS[3]<=1'b0;
			//use logical operators produce 1 bit result for relevant flags
			FLAGS[2]<=1'b0;//overflow not set for this opcode
			FLAGS[1]<=(ALU_RES[Width-1]==1)?1'b1:1'b0; //msb is s
			FLAGS[0]<=~|(A && B);//reduction operation
			end
		ALU_OR:  begin
			ALU_STATE=AB_OR;
			//FLAGS[3]<=1'b0;
			FLAGS[2]<=1'b0;
			FLAGS[1]<=(ALU_RES[Width-1]==1)?1'b1:1'b0;
			FLAGS[0] <= A||B;
			end
		ALU_XOR: begin
			ALU_STATE=AB_XOR;
			//FLAGS[3]<=1'b0;
			FLAGS[2]<=1'b0;
			FLAGS[1]<=(ALU_RES[Width-1]==1)?1'b1:1'b0;
			FLAGS[0] <= (A & ~B) || (~A & B);//logic operator using 2 bitwise results
			end
		ALU_Anot: begin
			ALU_STATE=A_NOT;
			//FLAGS[3]<=1'b0;
			FLAGS[2]<=1'b0;
			FLAGS[1]<=(ALU_RES[Width-1]==1)?1'b1:1'b0;
			FLAGS[0] <= !A;
			end
		default: begin
			ALU_STATE= ALU_STATE; //holds state for opcodes
			
			end
		endcase
		
	end


	always_ff @(posedge CLK)begin
		//needs to be in always comb otherwise only outputs on clock if !EN 
		//instead of constantly holding state
		if(!EN)begin
		ALU_RES<=ALU_RES; //not enabled holds state
		//FLAGS<=FLAGS;  
		end
	
		else begin

		case (ALU_STATE)
		AB_ADD: begin
			{FLAGS[3],ALU_RES} <= A+B; //carry flag set here
			end
		AB_SUB: begin
			//set the carry flag when A<B by intel definition
			
			{FLAGS[3],ALU_RES}<= A+(~B+1); 
			end			
		AB_AND: begin
			ALU_RES<= A & B; //note using bitwise operators 
			end
		AB_OR:begin
			ALU_RES<= A | B;	
			end
		AB_XOR: begin
			ALU_RES<= A ^ B;
			end
		default: begin
			//A_NOT since we know thats the only other value ALU_STATE can take
			ALU_RES<=~A;
			end

		endcase

		end

		
	end



endmodule
