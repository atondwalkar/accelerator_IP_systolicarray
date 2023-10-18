	`timescale 1ns / 1ps

module ast_systolic_array_control_v (
 clk,
 reset,
 cycles_in,
 depth_A,
 width_B,
 start,
 load_en,
 mult_en,
 acc_en,
 memsel_A,
 memsel_B,
 done,
 busy,
 );
	 
	 parameter SIZE = 4;
	 
	 input clk, reset, start;
	 input [$clog2(SIZE)+1:0] cycles_in;
	 input [$clog2(SIZE):0] depth_A, width_B; //row dimensions for mem select
	 output reg load_en, mult_en, acc_en;
	 output reg [SIZE:0] memsel_A, memsel_B;
	 output reg done, busy;
	 
	 reg [3:0] state;
	 reg [1:0] mac_cycles;
	 reg [$clog2(SIZE)+1:0] cycles;
	 //logic [$clog2(SIZE):0] cycles_max;
	 
	 initial
	 begin
		  state <= 0;
	 end
	 
	 always @ (posedge clk)
	 begin
		  if(reset)
		  begin
				state <= 0;
				load_en <= 0;
				mult_en <= 0;
				acc_en <= 0;
				memsel_A <= 0;
				memsel_B <= 0;
				cycles <= 0;
				mac_cycles <= 0;
				//cycles_max <= 0;
				done <= 0;
				busy <= 0;
		  end
		  if(state == 0)
		  begin
				if(start)
				begin
					 state <= 1;
					 //cycles_max <= (cycles_in << 1) - 1; //2n-1
					 busy <= 1;
				end
				else
				begin
					 state <= 0;
					 load_en <= 0;
					 mult_en <= 0;
					 acc_en <= 0;
					 memsel_A <= 0;
					 memsel_B <= 0;
					 cycles <= 0;
					 mac_cycles <= 0;
					 //cycles_max <= 0;
					 done <= 0;
					 busy <= 0;
				end
		  end
		  if(state == 1)
		  begin
				busy <= 1;
				//if(cycles != cycles_max + 1) 
				if(cycles != cycles_in + 1) //how many elements to multiply in array
				begin
					 case (mac_cycles) //mac unit has 3 steps
						  0   : 
								begin //load popped data/run accummulation
									mac_cycles <= 1;
									load_en <= 1;
									mult_en <= 0;
									acc_en <= 1;
								end
						  1   :
								begin //run multiplication
									mac_cycles <= 0;
									load_en <= 0;
									mult_en <= 1;
									acc_en <= 0;
									cycles <= cycles + 1;
									/*if(cycles < depth_A)
										 memsel_A <= memsel_A + 1;
									else
										 memsel_A <= memsel_A;
									if(cycles < width_B)
										 memsel_B <= memsel_B + 1; 
									else
										 memsel_B <= memsel_B;*/
								    memsel_A <= memsel_A + 1;
								    memsel_B <= memsel_B + 1; 
								end
						  default :
								begin
									mac_cycles <= 0;
									load_en <= 0;
									mult_en <= 0;
									acc_en <= 0;
								end
					 endcase
				end
				else
				begin
					 state <= 2;
					 load_en <= 0;
					 mult_en <= 0;
					 acc_en <= 0;
					 busy <= 1;
				end
		  end
		  if(state == 2)
		  begin
				done <= 1;
				state <= 3;
				busy <= 0;
		  end
		  if(state == 3)
		  begin
				done <= 0;
				busy <= 0;
				state <= 0;
		  end
		  
	 end
	 
	 
endmodule
