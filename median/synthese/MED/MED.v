//
// Verilog description for cell MED, 
// Mon Dec 10 11:45:38 2018
//
// Precision RTL Synthesis, 64-bit 2017.1.0.15//


module MED ( DI, DSI, BYP, CLK, DO ) ;

    input [7:0]DI ;
    input DSI ;
    input BYP ;
    input CLK ;
    output [7:0]DO ;

    wire [7:0]R_7_;
    wire nx2857z2, nx2857z9, nx2857z8, nx2857z7, nx2857z6, nx2857z5, nx2857z4, 
         nx2857z3, GND;
    wire [7:0]MUX_1_OUT_0n1ss1;
    wire nx3854z1, nx2857z1, nx2857z10, nx2857z11, nx2857z12, nx2857z13, 
         nx2857z14, nx2857z15, nx2857z16, nx_MED_vcc_net;
    wire [116:0] xmplr_dummy ;




    altshift_taps ix2857z49990 (.shiftin ({MUX_1_OUT_0n1ss1[7],
                  MUX_1_OUT_0n1ss1[0],MUX_1_OUT_0n1ss1[1],MUX_1_OUT_0n1ss1[2],
                  MUX_1_OUT_0n1ss1[3],MUX_1_OUT_0n1ss1[4],MUX_1_OUT_0n1ss1[5],
                  MUX_1_OUT_0n1ss1[6]}), .clock (CLK), .aclr (GND), .shiftout ({
                  R_7_[7],R_7_[0],R_7_[1],R_7_[2],R_7_[3],R_7_[4],R_7_[5],
                  R_7_[6]})) ;
                  defparam ix2857z49990.tap_distance = 8;
                  defparam ix2857z49990.number_of_taps = 1;
                  defparam ix2857z49990.width = 8;
                  defparam ix2857z49990.lpm_type = "altshift_taps";
                  defparam ix2857z49990.power_up_state = "DONT_CARE";
    assign GND = 1'b0 ;
    cycloneii_lcell_ff MUX_2_reg_OUT_7_ (.regout (DO[7]), .datain (R_7_[7]), .sdata (
                       1'b0), .clk (CLK), .ena (nx3854z1), .aclr (1'b0), .sclr (
                       1'b0), .sload (1'b0)) ;
    cycloneii_lcell_ff MUX_2_reg_OUT_6_ (.regout (DO[6]), .datain (R_7_[6]), .sdata (
                       1'b0), .clk (CLK), .ena (nx3854z1), .aclr (1'b0), .sclr (
                       1'b0), .sload (1'b0)) ;
    cycloneii_lcell_ff MUX_2_reg_OUT_5_ (.regout (DO[5]), .datain (R_7_[5]), .sdata (
                       1'b0), .clk (CLK), .ena (nx3854z1), .aclr (1'b0), .sclr (
                       1'b0), .sload (1'b0)) ;
    cycloneii_lcell_ff MUX_2_reg_OUT_4_ (.regout (DO[4]), .datain (R_7_[4]), .sdata (
                       1'b0), .clk (CLK), .ena (nx3854z1), .aclr (1'b0), .sclr (
                       1'b0), .sload (1'b0)) ;
    cycloneii_lcell_ff MUX_2_reg_OUT_3_ (.regout (DO[3]), .datain (R_7_[3]), .sdata (
                       1'b0), .clk (CLK), .ena (nx3854z1), .aclr (1'b0), .sclr (
                       1'b0), .sload (1'b0)) ;
    cycloneii_lcell_ff MUX_2_reg_OUT_2_ (.regout (DO[2]), .datain (R_7_[2]), .sdata (
                       1'b0), .clk (CLK), .ena (nx3854z1), .aclr (1'b0), .sclr (
                       1'b0), .sload (1'b0)) ;
    cycloneii_lcell_ff MUX_2_reg_OUT_1_ (.regout (DO[1]), .datain (R_7_[1]), .sdata (
                       1'b0), .clk (CLK), .ena (nx3854z1), .aclr (1'b0), .sclr (
                       1'b0), .sload (1'b0)) ;
    cycloneii_lcell_ff MUX_2_reg_OUT_0_ (.regout (DO[0]), .datain (R_7_[0]), .sdata (
                       1'b0), .clk (CLK), .ena (nx3854z1), .aclr (1'b0), .sclr (
                       1'b0), .sload (1'b0)) ;
    cycloneii_lcell_comb I_MCE_rtlc0_38_gt_0_ix2857z52926 (.combout (nx2857z2), 
                         .dataa (R_7_[7]), .datab (DO[7]), .datac (1'b1), .datad (
                         nx_MED_vcc_net), .cin (nx2857z3)) ;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52926.lut_mask = 16'hd4d4;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52926.sum_lutc_input = "cin";
    assign nx_MED_vcc_net = 1'b1 ;
    cycloneii_lcell_comb I_MCE_rtlc0_38_gt_0_ix2857z52928 (.cout (nx2857z3), .dataa (
                         R_7_[6]), .datab (DO[6]), .datac (1'b1), .datad (
                         nx_MED_vcc_net), .cin (nx2857z4)) ;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52928.lut_mask = 16'h00d4;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52928.sum_lutc_input = "cin";
    cycloneii_lcell_comb I_MCE_rtlc0_38_gt_0_ix2857z52929 (.cout (nx2857z4), .dataa (
                         R_7_[5]), .datab (DO[5]), .datac (1'b1), .datad (
                         nx_MED_vcc_net), .cin (nx2857z5)) ;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52929.lut_mask = 16'h00d4;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52929.sum_lutc_input = "cin";
    cycloneii_lcell_comb I_MCE_rtlc0_38_gt_0_ix2857z52930 (.cout (nx2857z5), .dataa (
                         R_7_[4]), .datab (DO[4]), .datac (1'b1), .datad (
                         nx_MED_vcc_net), .cin (nx2857z6)) ;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52930.lut_mask = 16'h00d4;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52930.sum_lutc_input = "cin";
    cycloneii_lcell_comb I_MCE_rtlc0_38_gt_0_ix2857z52931 (.cout (nx2857z6), .dataa (
                         R_7_[3]), .datab (DO[3]), .datac (1'b1), .datad (
                         nx_MED_vcc_net), .cin (nx2857z7)) ;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52931.lut_mask = 16'h00d4;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52931.sum_lutc_input = "cin";
    cycloneii_lcell_comb I_MCE_rtlc0_38_gt_0_ix2857z52932 (.cout (nx2857z7), .dataa (
                         R_7_[2]), .datab (DO[2]), .datac (1'b1), .datad (
                         nx_MED_vcc_net), .cin (nx2857z8)) ;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52932.lut_mask = 16'h00d4;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52932.sum_lutc_input = "cin";
    cycloneii_lcell_comb I_MCE_rtlc0_38_gt_0_ix2857z52933 (.cout (nx2857z8), .dataa (
                         R_7_[1]), .datab (DO[1]), .datac (1'b1), .datad (
                         nx_MED_vcc_net), .cin (nx2857z9)) ;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52933.lut_mask = 16'h00d4;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52933.sum_lutc_input = "cin";
    cycloneii_lcell_comb I_MCE_rtlc0_38_gt_0_ix2857z52934 (.cout (nx2857z9), .dataa (
                         DO[0]), .datab (R_7_[0]), .datac (1'b1), .datad (
                         nx_MED_vcc_net)) ;
                         defparam I_MCE_rtlc0_38_gt_0_ix2857z52934.lut_mask = 16'h0022;
    cycloneii_lcell_comb ix2857z52948 (.combout (nx2857z16), .dataa (DO[6]), .datab (
                         DSI), .datac (R_7_[6]), .datad (nx2857z2)) ;
                         defparam ix2857z52948.lut_mask = 16'hfcee;
    cycloneii_lcell_comb ix2857z52946 (.combout (nx2857z15), .dataa (DO[5]), .datab (
                         DSI), .datac (R_7_[5]), .datad (nx2857z2)) ;
                         defparam ix2857z52946.lut_mask = 16'hfcee;
    cycloneii_lcell_comb ix2857z52944 (.combout (nx2857z14), .dataa (DO[4]), .datab (
                         DSI), .datac (R_7_[4]), .datad (nx2857z2)) ;
                         defparam ix2857z52944.lut_mask = 16'hfcee;
    cycloneii_lcell_comb ix2857z52942 (.combout (nx2857z13), .dataa (DO[3]), .datab (
                         DSI), .datac (R_7_[3]), .datad (nx2857z2)) ;
                         defparam ix2857z52942.lut_mask = 16'hfcee;
    cycloneii_lcell_comb ix2857z52940 (.combout (nx2857z12), .dataa (DO[2]), .datab (
                         DSI), .datac (R_7_[2]), .datad (nx2857z2)) ;
                         defparam ix2857z52940.lut_mask = 16'hfcee;
    cycloneii_lcell_comb ix2857z52938 (.combout (nx2857z11), .dataa (DO[1]), .datab (
                         DSI), .datac (R_7_[1]), .datad (nx2857z2)) ;
                         defparam ix2857z52938.lut_mask = 16'hfcee;
    cycloneii_lcell_comb ix2857z52936 (.combout (nx2857z10), .dataa (DO[0]), .datab (
                         DSI), .datac (R_7_[0]), .datad (nx2857z2)) ;
                         defparam ix2857z52936.lut_mask = 16'hfcee;
    cycloneii_lcell_comb ix2857z52925 (.combout (nx2857z1), .dataa (DO[7]), .datab (
                         DSI), .datac (R_7_[7]), .datad (nx2857z2)) ;
                         defparam ix2857z52925.lut_mask = 16'hfcee;
    cycloneii_lcell_comb ix3854z52923 (.combout (nx3854z1), .dataa (BYP), .datab (
                         nx2857z2), .datac (1'b1), .datad (1'b1)) ;
                         defparam ix3854z52923.lut_mask = 16'hbbbb;
    cycloneii_lcell_comb ix2857z52935 (.combout (MUX_1_OUT_0n1ss1[0]), .dataa (
                         DI[0]), .datab (DSI), .datac (nx2857z10), .datad (1'b1)
                         ) ;
                         defparam ix2857z52935.lut_mask = 16'hb0b0;
    cycloneii_lcell_comb ix2857z52937 (.combout (MUX_1_OUT_0n1ss1[1]), .dataa (
                         DI[1]), .datab (DSI), .datac (nx2857z11), .datad (1'b1)
                         ) ;
                         defparam ix2857z52937.lut_mask = 16'hb0b0;
    cycloneii_lcell_comb ix2857z52939 (.combout (MUX_1_OUT_0n1ss1[2]), .dataa (
                         DI[2]), .datab (DSI), .datac (nx2857z12), .datad (1'b1)
                         ) ;
                         defparam ix2857z52939.lut_mask = 16'hb0b0;
    cycloneii_lcell_comb ix2857z52941 (.combout (MUX_1_OUT_0n1ss1[3]), .dataa (
                         DI[3]), .datab (DSI), .datac (nx2857z13), .datad (1'b1)
                         ) ;
                         defparam ix2857z52941.lut_mask = 16'hb0b0;
    cycloneii_lcell_comb ix2857z52943 (.combout (MUX_1_OUT_0n1ss1[4]), .dataa (
                         DI[4]), .datab (DSI), .datac (nx2857z14), .datad (1'b1)
                         ) ;
                         defparam ix2857z52943.lut_mask = 16'hb0b0;
    cycloneii_lcell_comb ix2857z52945 (.combout (MUX_1_OUT_0n1ss1[5]), .dataa (
                         DI[5]), .datab (DSI), .datac (nx2857z15), .datad (1'b1)
                         ) ;
                         defparam ix2857z52945.lut_mask = 16'hb0b0;
    cycloneii_lcell_comb ix2857z52947 (.combout (MUX_1_OUT_0n1ss1[6]), .dataa (
                         DI[6]), .datab (DSI), .datac (nx2857z16), .datad (1'b1)
                         ) ;
                         defparam ix2857z52947.lut_mask = 16'hb0b0;
    cycloneii_lcell_comb ix2857z52924 (.combout (MUX_1_OUT_0n1ss1[7]), .dataa (
                         DI[7]), .datab (DSI), .datac (nx2857z1), .datad (1'b1)
                         ) ;
                         defparam ix2857z52924.lut_mask = 16'hb0b0;
endmodule

