//==========================================================
//      RTL Generated File
//      Author: Ashish Tondwalkar
//--------------------------------------------------
//      Description: Systolic Array Top File
//--------------------------------------------------
//      Datawidth = 16
//      Dimension = 4
//==========================================================


module accelerator_IP_systolicarray (
    clk, 
    reset,
    depth_A,
    width_A,
    depth_B,
    width_B,
    busy,
    a_in_0_0,
    a_in_0_1,
    a_in_0_2,
    a_in_0_3,
    a_in_1_0,
    a_in_1_1,
    a_in_1_2,
    a_in_1_3,
    a_in_2_0,
    a_in_2_1,
    a_in_2_2,
    a_in_2_3,
    a_in_3_0,
    a_in_3_1,
    a_in_3_2,
    a_in_3_3,
    b_in_0_0,
    b_in_0_1,
    b_in_0_2,
    b_in_0_3,
    b_in_1_0,
    b_in_1_1,
    b_in_1_2,
    b_in_1_3,
    b_in_2_0,
    b_in_2_1,
    b_in_2_2,
    b_in_2_3,
    b_in_3_0,
    b_in_3_1,
    b_in_3_2,
    b_in_3_3,
    dout_0_0,
    dout_0_1,
    dout_0_2,
    dout_0_3,
    dout_1_0,
    dout_1_1,
    dout_1_2,
    dout_1_3,
    dout_2_0,
    dout_2_1,
    dout_2_2,
    dout_2_3,
    dout_3_0,
    dout_3_1,
    dout_3_2,
    dout_3_3,
	start,
	done
	); 	

    localparam DATAWIDTH = 16;
    localparam SIZE = 4;

	input clk, reset, start;
	input [$clog2(SIZE):0] depth_A, width_A, depth_B, width_B;
	output busy, done;		
    input wire [DATAWIDTH-1:0] a_in_0_0;
    input wire [DATAWIDTH-1:0] a_in_0_1;
    input wire [DATAWIDTH-1:0] a_in_0_2;
    input wire [DATAWIDTH-1:0] a_in_0_3;
    input wire [DATAWIDTH-1:0] a_in_1_0;
    input wire [DATAWIDTH-1:0] a_in_1_1;
    input wire [DATAWIDTH-1:0] a_in_1_2;
    input wire [DATAWIDTH-1:0] a_in_1_3;
    input wire [DATAWIDTH-1:0] a_in_2_0;
    input wire [DATAWIDTH-1:0] a_in_2_1;
    input wire [DATAWIDTH-1:0] a_in_2_2;
    input wire [DATAWIDTH-1:0] a_in_2_3;
    input wire [DATAWIDTH-1:0] a_in_3_0;
    input wire [DATAWIDTH-1:0] a_in_3_1;
    input wire [DATAWIDTH-1:0] a_in_3_2;
    input wire [DATAWIDTH-1:0] a_in_3_3;
    input wire [DATAWIDTH-1:0] b_in_0_0;
    input wire [DATAWIDTH-1:0] b_in_0_1;
    input wire [DATAWIDTH-1:0] b_in_0_2;
    input wire [DATAWIDTH-1:0] b_in_0_3;
    input wire [DATAWIDTH-1:0] b_in_1_0;
    input wire [DATAWIDTH-1:0] b_in_1_1;
    input wire [DATAWIDTH-1:0] b_in_1_2;
    input wire [DATAWIDTH-1:0] b_in_1_3;
    input wire [DATAWIDTH-1:0] b_in_2_0;
    input wire [DATAWIDTH-1:0] b_in_2_1;
    input wire [DATAWIDTH-1:0] b_in_2_2;
    input wire [DATAWIDTH-1:0] b_in_2_3;
    input wire [DATAWIDTH-1:0] b_in_3_0;
    input wire [DATAWIDTH-1:0] b_in_3_1;
    input wire [DATAWIDTH-1:0] b_in_3_2;
    input wire [DATAWIDTH-1:0] b_in_3_3;
    output wire [DATAWIDTH-1:0] dout_0_0;
    output wire [DATAWIDTH-1:0] dout_0_1;
    output wire [DATAWIDTH-1:0] dout_0_2;
    output wire [DATAWIDTH-1:0] dout_0_3;
    output wire [DATAWIDTH-1:0] dout_1_0;
    output wire [DATAWIDTH-1:0] dout_1_1;
    output wire [DATAWIDTH-1:0] dout_1_2;
    output wire [DATAWIDTH-1:0] dout_1_3;
    output wire [DATAWIDTH-1:0] dout_2_0;
    output wire [DATAWIDTH-1:0] dout_2_1;
    output wire [DATAWIDTH-1:0] dout_2_2;
    output wire [DATAWIDTH-1:0] dout_2_3;
    output wire [DATAWIDTH-1:0] dout_3_0;
    output wire [DATAWIDTH-1:0] dout_3_1;
    output wire [DATAWIDTH-1:0] dout_3_2;
    output wire [DATAWIDTH-1:0] dout_3_3;
    reg [DATAWIDTH-1:0] a_mux_0;
    reg [DATAWIDTH-1:0] a_mux_1;
    reg [DATAWIDTH-1:0] a_mux_2;
    reg [DATAWIDTH-1:0] a_mux_3;
    reg [DATAWIDTH-1:0] b_mux_0;
    reg [DATAWIDTH-1:0] b_mux_1;
    reg [DATAWIDTH-1:0] b_mux_2;
    reg [DATAWIDTH-1:0] b_mux_3;

    wire [$clog2(SIZE)+1:0] memsel_A, memsel_B;


    always @ (*)
    begin
        case(memsel_A)
        0 : 
        begin 
            a_mux_0 = a_in_0_0;
            a_mux_1 = 0;
            a_mux_2 = 0;
            a_mux_3 = 0;
        end 
        1 : 
        begin 
            a_mux_0 = a_in_0_1;
            a_mux_1 = a_in_1_0;
            a_mux_2 = 0;
            a_mux_3 = 0;
        end 
        2 : 
        begin 
            a_mux_0 = a_in_0_2;
            a_mux_1 = a_in_1_1;
            a_mux_2 = a_in_2_0;
            a_mux_3 = 0;
        end 
        3 : 
        begin 
            a_mux_0 = a_in_0_3;
            a_mux_1 = a_in_1_2;
            a_mux_2 = a_in_2_1;
            a_mux_3 = a_in_3_0;
        end 
        4 : 
        begin 
            a_mux_0 = 0;
            a_mux_1 = a_in_1_3;
            a_mux_2 = a_in_2_2;
            a_mux_3 = a_in_3_1;
        end 
        5 : 
        begin 
            a_mux_0 = 0;
            a_mux_1 = 0;
            a_mux_2 = a_in_2_3;
            a_mux_3 = a_in_3_2;
        end 
        6 : 
        begin 
            a_mux_0 = 0;
            a_mux_1 = 0;
            a_mux_2 = 0;
            a_mux_3 = a_in_3_3;
        end 
        7 : 
        begin 
            a_mux_0 = 0;
            a_mux_1 = 0;
            a_mux_2 = 0;
            a_mux_3 = 0;
        end 
        default : 
        begin 
            a_mux_0 = 0;
            a_mux_1 = 0;
            a_mux_2 = 0;
            a_mux_3 = 0;
        end 
        endcase
    end

    always @ (*)
    begin
        case(memsel_B)
        0 : 
        begin 
            b_mux_0 = b_in_0_0;
            b_mux_1 = 0;
            b_mux_2 = 0;
            b_mux_3 = 0;
        end 
        1 : 
        begin 
            b_mux_0 = b_in_1_0;
            b_mux_1 = b_in_0_1;
            b_mux_2 = 0;
            b_mux_3 = 0;
        end 
        2 : 
        begin 
            b_mux_0 = b_in_2_0;
            b_mux_1 = b_in_1_1;
            b_mux_2 = b_in_0_2;
            b_mux_3 = 0;
        end 
        3 : 
        begin 
            b_mux_0 = b_in_3_0;
            b_mux_1 = b_in_2_1;
            b_mux_2 = b_in_1_2;
            b_mux_3 = b_in_0_3;
        end 
        4 : 
        begin 
            b_mux_0 = 0;
            b_mux_1 = b_in_3_1;
            b_mux_2 = b_in_2_2;
            b_mux_3 = b_in_1_3;
        end 
        5 : 
        begin 
            b_mux_0 = 0;
            b_mux_1 = 0;
            b_mux_2 = b_in_3_2;
            b_mux_3 = b_in_2_3;
        end 
        6 : 
        begin 
            b_mux_0 = 0;
            b_mux_1 = 0;
            b_mux_2 = 0;
            b_mux_3 = b_in_3_3;
        end 
        7 : 
        begin 
            b_mux_0 = 0;
            b_mux_1 = 0;
            b_mux_2 = 0;
            b_mux_3 = 0;
        end 
        default : 
            begin 
            a_mux_0 = 0 ;
            a_mux_1 = 0 ;
            a_mux_2 = 0 ;
            a_mux_3 = 0 ;
            end 
        endcase
    end


    //-------------------------------------------------------------------------------
    // Systolic Array DP and CU

    wire load_en, mult_en, acc_en;
    wire [SIZE-1:0] mac_cycles;

    ast_systolic_array_v array (
        .clk(clk),
        .reset(reset | done),
        .a_in_0(a_mux_0),
        .a_in_1(a_mux_1),
        .a_in_2(a_mux_2),
        .a_in_3(a_mux_3),
        .b_in_0(b_mux_0),
        .b_in_1(b_mux_1),
        .b_in_2(b_mux_2),
        .b_in_3(b_mux_3),
        .dout_0_0(dout_0_0),
        .dout_0_1(dout_0_1),
        .dout_0_2(dout_0_2),
        .dout_0_3(dout_0_3),
        .dout_1_0(dout_1_0),
        .dout_1_1(dout_1_1),
        .dout_1_2(dout_1_2),
        .dout_1_3(dout_1_3),
        .dout_2_0(dout_2_0),
        .dout_2_1(dout_2_1),
        .dout_2_2(dout_2_2),
        .dout_2_3(dout_2_3),
        .dout_3_0(dout_3_0),
        .dout_3_1(dout_3_1),
        .dout_3_2(dout_3_2),
        .dout_3_3(dout_3_3),
        .mult_en(mult_en),
        .acc_en(acc_en),
        .load_en(load_en)
    );

    assign mac_cycles = (depth_A + width_A + depth_B) - 1; //QxR * RxK -> cycles = R+Q+K-1

    ast_systolic_array_control_v #(.SIZE(SIZE)) array_control (
        .clk(clk),
        .reset(reset),
        .cycles_in(mac_cycles), 
        .depth_A(depth_A),
        .width_B(width_B),
        .load_en(load_en),
        .mult_en(mult_en),
        .acc_en(acc_en),
        .done(done),
        .start(start),
        .memsel_A(memsel_A),
        .memsel_B(memsel_B),
        .busy(busy)
    );

    //-------------------------------------------------------------------------------	


endmodule
