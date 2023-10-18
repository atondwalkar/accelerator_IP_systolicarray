//==========================================================
//      RTL Generated File
//      Author: Ashish Tondwalkar
//--------------------------------------------------
//      Description: TB for Systolic Array IP
//--------------------------------------------------
//      Datawidth = 16
//      Dimension = 4
//==========================================================



module system_TB_sv;

    parameter SIZE = 4;
	parameter DATAWIDTH = 16;

    logic clk, reset;
	logic start, busy;
	
    logic [SIZE-1:0][SIZE-1:0][DATAWIDTH-1:0] matrixA = '{'{5, 2, 6, 1},'{0, 6, 2, 0},'{3, 8, 1, 4},'{1, 8, 5, 6}};
    logic [SIZE-1:0][SIZE-1:0][DATAWIDTH-1:0] matrixB = '{'{7, 5, 8, 0},'{1, 8, 2, 6},'{9, 4, 3, 8},'{5, 3, 7, 9}};
    logic [SIZE-1:0][SIZE-1:0][DATAWIDTH-1:0] matrix_results;

    accelerator_IP_systolicarray DUT (
        .clk(clk),
        .reset(reset),
        .depth_A(4),
        .width_A(4),
        .depth_B(4),
        .width_B(4),
        .a_in_0_0(matrixA[0][0]),
        .a_in_0_1(matrixA[0][1]),
        .a_in_0_2(matrixA[0][2]),
        .a_in_0_3(matrixA[0][3]),
        .a_in_1_0(matrixA[1][0]),
        .a_in_1_1(matrixA[1][1]),
        .a_in_1_2(matrixA[1][2]),
        .a_in_1_3(matrixA[1][3]),
        .a_in_2_0(matrixA[2][0]),
        .a_in_2_1(matrixA[2][1]),
        .a_in_2_2(matrixA[2][2]),
        .a_in_2_3(matrixA[2][3]),
        .a_in_3_0(matrixA[3][0]),
        .a_in_3_1(matrixA[3][1]),
        .a_in_3_2(matrixA[3][2]),
        .a_in_3_3(matrixA[3][3]),
        .b_in_0_0(matrixB[0][0]),
        .b_in_0_1(matrixB[0][1]),
        .b_in_0_2(matrixB[0][2]),
        .b_in_0_3(matrixB[0][3]),
        .b_in_1_0(matrixB[1][0]),
        .b_in_1_1(matrixB[1][1]),
        .b_in_1_2(matrixB[1][2]),
        .b_in_1_3(matrixB[1][3]),
        .b_in_2_0(matrixB[2][0]),
        .b_in_2_1(matrixB[2][1]),
        .b_in_2_2(matrixB[2][2]),
        .b_in_2_3(matrixB[2][3]),
        .b_in_3_0(matrixB[3][0]),
        .b_in_3_1(matrixB[3][1]),
        .b_in_3_2(matrixB[3][2]),
        .b_in_3_3(matrixB[3][3]),
        .dout_0_0(matrix_results[0][0]),
        .dout_0_1(matrix_results[0][1]),
        .dout_0_2(matrix_results[0][2]),
        .dout_0_3(matrix_results[0][3]),
        .dout_1_0(matrix_results[1][0]),
        .dout_1_1(matrix_results[1][1]),
        .dout_1_2(matrix_results[1][2]),
        .dout_1_3(matrix_results[1][3]),
        .dout_2_0(matrix_results[2][0]),
        .dout_2_1(matrix_results[2][1]),
        .dout_2_2(matrix_results[2][2]),
        .dout_2_3(matrix_results[2][3]),
        .dout_3_0(matrix_results[3][0]),
        .dout_3_1(matrix_results[3][1]),
        .dout_3_2(matrix_results[3][2]),
        .dout_3_3(matrix_results[3][3]),
        .start(start),
        .done(done)
    );

integer i, j, k;


	initial begin 
		clk = 0;
		forever begin
		#10 clk = ~clk;
	end end 	
	 
	initial begin
		reset = 1;
		start = 0;
		#45;
		reset = 0;

		start = 1;
		#40;

		start = 0;
		#1000;
	
		$stop;
	
	end
endmodule
	 
