//==========================================================
//      RTL Generated File
//      Author: Ashish Tondwalkar
//--------------------------------------------------
//      Description: Systolic Array of MAC Units
//--------------------------------------------------
//      Datawidth = 16
//      Dimension = 4
//==========================================================

module ast_systolic_array_v (
    clk,
    reset,
    a_in_0,
    a_in_1,
    a_in_2,
    a_in_3,
    b_in_0,
    b_in_1,
    b_in_2,
    b_in_3,
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
    mult_en,
    acc_en,
    load_en
    );

    localparam DATAWIDTH = 15;
    localparam SIZE = 3;

    input clk, reset, mult_en, acc_en, load_en;
    input [DATAWIDTH:0] a_in_0;
    input [DATAWIDTH:0] a_in_1;
    input [DATAWIDTH:0] a_in_2;
    input [DATAWIDTH:0] a_in_3;
    input [DATAWIDTH:0] b_in_0;
    input [DATAWIDTH:0] b_in_1;
    input [DATAWIDTH:0] b_in_2;
    input [DATAWIDTH:0] b_in_3;
    output wire [DATAWIDTH:0] dout_0_0;
    output wire [DATAWIDTH:0] dout_0_1;
    output wire [DATAWIDTH:0] dout_0_2;
    output wire [DATAWIDTH:0] dout_0_3;
    output wire [DATAWIDTH:0] dout_1_0;
    output wire [DATAWIDTH:0] dout_1_1;
    output wire [DATAWIDTH:0] dout_1_2;
    output wire [DATAWIDTH:0] dout_1_3;
    output wire [DATAWIDTH:0] dout_2_0;
    output wire [DATAWIDTH:0] dout_2_1;
    output wire [DATAWIDTH:0] dout_2_2;
    output wire [DATAWIDTH:0] dout_2_3;
    output wire [DATAWIDTH:0] dout_3_0;
    output wire [DATAWIDTH:0] dout_3_1;
    output wire [DATAWIDTH:0] dout_3_2;
    output wire [DATAWIDTH:0] dout_3_3;

    wire [DATAWIDTH:0] a [SIZE+1:0][SIZE+1:0]; //internal array row connections
    wire [DATAWIDTH:0] b [SIZE+1:0][SIZE+1:0]; //internal array col connections


    //row bounday
    assign a[0][0] = a_in_0;
    assign a[1][0] = a_in_1;
    assign a[2][0] = a_in_2;
    assign a[3][0] = a_in_3;

    //col bounday
    assign b[0][0] = b_in_0;
    assign b[0][1] = b_in_1;
    assign b[0][2] = b_in_2;
    assign b[0][3] = b_in_3;

    ast_mac_v element_0_0 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[0][0]), 
        .b_in(b[0][0]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[0][1]), 
        .b_out(b[1][0]),
        .acc_out(dout_0_0)
        );

    ast_mac_v element_0_1 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[0][1]), 
        .b_in(b[0][1]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[0][2]), 
        .b_out(b[1][1]),
        .acc_out(dout_0_1)
        );

    ast_mac_v element_0_2 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[0][2]), 
        .b_in(b[0][2]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[0][3]), 
        .b_out(b[1][2]),
        .acc_out(dout_0_2)
        );

    ast_mac_v element_0_3 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[0][3]), 
        .b_in(b[0][3]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[0][4]), 
        .b_out(b[1][3]),
        .acc_out(dout_0_3)
        );

    ast_mac_v element_1_0 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[1][0]), 
        .b_in(b[1][0]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[1][1]), 
        .b_out(b[2][0]),
        .acc_out(dout_1_0)
        );

    ast_mac_v element_1_1 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[1][1]), 
        .b_in(b[1][1]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[1][2]), 
        .b_out(b[2][1]),
        .acc_out(dout_1_1)
        );

    ast_mac_v element_1_2 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[1][2]), 
        .b_in(b[1][2]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[1][3]), 
        .b_out(b[2][2]),
        .acc_out(dout_1_2)
        );

    ast_mac_v element_1_3 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[1][3]), 
        .b_in(b[1][3]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[1][4]), 
        .b_out(b[2][3]),
        .acc_out(dout_1_3)
        );

    ast_mac_v element_2_0 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[2][0]), 
        .b_in(b[2][0]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[2][1]), 
        .b_out(b[3][0]),
        .acc_out(dout_2_0)
        );

    ast_mac_v element_2_1 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[2][1]), 
        .b_in(b[2][1]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[2][2]), 
        .b_out(b[3][1]),
        .acc_out(dout_2_1)
        );

    ast_mac_v element_2_2 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[2][2]), 
        .b_in(b[2][2]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[2][3]), 
        .b_out(b[3][2]),
        .acc_out(dout_2_2)
        );

    ast_mac_v element_2_3 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[2][3]), 
        .b_in(b[2][3]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[2][4]), 
        .b_out(b[3][3]),
        .acc_out(dout_2_3)
        );

    ast_mac_v element_3_0 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[3][0]), 
        .b_in(b[3][0]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[3][1]), 
        .b_out(b[4][0]),
        .acc_out(dout_3_0)
        );

    ast_mac_v element_3_1 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[3][1]), 
        .b_in(b[3][1]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[3][2]), 
        .b_out(b[4][1]),
        .acc_out(dout_3_1)
        );

    ast_mac_v element_3_2 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[3][2]), 
        .b_in(b[3][2]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[3][3]), 
        .b_out(b[4][2]),
        .acc_out(dout_3_2)
        );

    ast_mac_v element_3_3 ( 
        .clk(clk), 
        .reset(reset), 
        .a_in(a[3][3]), 
        .b_in(b[3][3]), 
        .mult_en(mult_en), 
        .acc_en(acc_en), 
        .load_en(load_en), 
        .a_out(a[3][4]), 
        .b_out(b[4][3]),
        .acc_out(dout_3_3)
        );
endmodule
