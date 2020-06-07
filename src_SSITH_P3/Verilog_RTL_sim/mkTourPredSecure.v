//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
// On Sat Jun  6 22:40:32 BST 2020
//
//
// Ports:
// Name                         I/O  size props
// pred_0_pred                    O    25
// RDY_pred_0_pred                O     1 const
// pred_1_pred                    O    25
// RDY_pred_1_pred                O     1 const
// RDY_update                     O     1 const
// RDY_flush                      O     1 reg
// flush_done                     O     1 reg
// RDY_flush_done                 O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// pred_0_pred_pc                 I   129
// pred_1_pred_pc                 I   129
// update_pc                      I   129
// update_taken                   I     1
// update_train                   I    24
// update_mispred                 I     1
// EN_update                      I     1
// EN_flush                       I     1
// EN_pred_0_pred                 I     1
// EN_pred_1_pred                 I     1
//
// Combinational paths from inputs to outputs:
//   pred_0_pred_pc -> pred_0_pred
//   (pred_1_pred_pc, EN_pred_0_pred) -> pred_1_pred
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkTourPredSecure(CLK,
			RST_N,

			pred_0_pred_pc,
			EN_pred_0_pred,
			pred_0_pred,
			RDY_pred_0_pred,

			pred_1_pred_pc,
			EN_pred_1_pred,
			pred_1_pred,
			RDY_pred_1_pred,

			update_pc,
			update_taken,
			update_train,
			update_mispred,
			EN_update,
			RDY_update,

			EN_flush,
			RDY_flush,

			flush_done,
			RDY_flush_done);
  input  CLK;
  input  RST_N;

  // actionvalue method pred_0_pred
  input  [128 : 0] pred_0_pred_pc;
  input  EN_pred_0_pred;
  output [24 : 0] pred_0_pred;
  output RDY_pred_0_pred;

  // actionvalue method pred_1_pred
  input  [128 : 0] pred_1_pred_pc;
  input  EN_pred_1_pred;
  output [24 : 0] pred_1_pred;
  output RDY_pred_1_pred;

  // action method update
  input  [128 : 0] update_pc;
  input  update_taken;
  input  [23 : 0] update_train;
  input  update_mispred;
  input  EN_update;
  output RDY_update;

  // action method flush
  input  EN_flush;
  output RDY_flush;

  // value method flush_done
  output flush_done;
  output RDY_flush_done;

  // signals for module outputs
  wire [24 : 0] pred_0_pred, pred_1_pred;
  wire RDY_flush,
       RDY_flush_done,
       RDY_pred_0_pred,
       RDY_pred_1_pred,
       RDY_update,
       flush_done;

  // inlined wires
  wire [154 : 0] updateEn$wget;
  wire [1 : 0] predCnt_lat_0$wget,
	       predCnt_lat_1$wget,
	       predRes_lat_0$wget,
	       predRes_lat_1$wget;

  // register flushDone
  reg flushDone;
  wire flushDone$D_IN, flushDone$EN;

  // register flushIndex
  reg [8 : 0] flushIndex;
  wire [8 : 0] flushIndex$D_IN;
  wire flushIndex$EN;

  // register predCnt_rl
  reg [1 : 0] predCnt_rl;
  wire [1 : 0] predCnt_rl$D_IN;
  wire predCnt_rl$EN;

  // register predRes_rl
  reg [1 : 0] predRes_rl;
  wire [1 : 0] predRes_rl$D_IN;
  wire predRes_rl$EN;

  // ports of submodule choiceBht
  wire [15 : 0] choiceBht$D_IN,
		choiceBht$D_OUT_1,
		choiceBht$D_OUT_2,
		choiceBht$D_OUT_3;
  wire [8 : 0] choiceBht$ADDR_1,
	       choiceBht$ADDR_2,
	       choiceBht$ADDR_3,
	       choiceBht$ADDR_4,
	       choiceBht$ADDR_5,
	       choiceBht$ADDR_IN;
  wire choiceBht$WE;

  // ports of submodule gHistReg
  wire [11 : 0] gHistReg$history, gHistReg$redirect_newHist;
  wire [1 : 0] gHistReg$addHistory_num, gHistReg$addHistory_taken;
  wire gHistReg$EN_addHistory, gHistReg$EN_redirect;

  // ports of submodule globalBht
  wire [15 : 0] globalBht$D_IN,
		globalBht$D_OUT_1,
		globalBht$D_OUT_2,
		globalBht$D_OUT_3;
  wire [8 : 0] globalBht$ADDR_1,
	       globalBht$ADDR_2,
	       globalBht$ADDR_3,
	       globalBht$ADDR_4,
	       globalBht$ADDR_5,
	       globalBht$ADDR_IN;
  wire globalBht$WE;

  // ports of submodule localBht
  wire [8 : 0] localBht$ADDR_1,
	       localBht$ADDR_2,
	       localBht$ADDR_3,
	       localBht$ADDR_4,
	       localBht$ADDR_5,
	       localBht$ADDR_IN;
  wire [5 : 0] localBht$D_IN,
	       localBht$D_OUT_1,
	       localBht$D_OUT_2,
	       localBht$D_OUT_3;
  wire localBht$WE;

  // ports of submodule localHistTab
  wire [19 : 0] localHistTab$D_IN,
		localHistTab$D_OUT_1,
		localHistTab$D_OUT_2,
		localHistTab$D_OUT_3;
  wire [8 : 0] localHistTab$ADDR_1,
	       localHistTab$ADDR_2,
	       localHistTab$ADDR_3,
	       localHistTab$ADDR_4,
	       localHistTab$ADDR_5,
	       localHistTab$ADDR_IN;
  wire localHistTab$WE;

  // rule scheduling signals
  wire CAN_FIRE_RL_canonFlush,
       CAN_FIRE_RL_canonGlobalHist,
       CAN_FIRE_RL_canonUpdate,
       CAN_FIRE_RL_predCnt_canon,
       CAN_FIRE_RL_predRes_canon,
       CAN_FIRE_flush,
       CAN_FIRE_pred_0_pred,
       CAN_FIRE_pred_1_pred,
       CAN_FIRE_update,
       WILL_FIRE_RL_canonFlush,
       WILL_FIRE_RL_canonGlobalHist,
       WILL_FIRE_RL_canonUpdate,
       WILL_FIRE_RL_predCnt_canon,
       WILL_FIRE_RL_predRes_canon,
       WILL_FIRE_flush,
       WILL_FIRE_pred_0_pred,
       WILL_FIRE_pred_1_pred,
       WILL_FIRE_update;

  // inputs to muxes for submodule ports
  wire [19 : 0] MUX_localHistTab$upd_2__VAL_1;
  wire [15 : 0] MUX_choiceBht$upd_2__VAL_1, MUX_globalBht$upd_2__VAL_1;
  wire [5 : 0] MUX_localBht$upd_2__VAL_2;
  wire MUX_choiceBht$upd_1__SEL_1,
       MUX_flushDone$write_1__SEL_1,
       MUX_gHistReg$redirect_1__SEL_1;

  // remaining internal signals
  reg [9 : 0] localHist__h7939, localHist__h9249;
  reg [2 : 0] cnt__h8505, cnt__h9839, localCnt__h2959;
  reg [1 : 0] choiceCnt__h4464,
	      cnt__h10110,
	      cnt__h8084,
	      cnt__h8776,
	      cnt__h9422,
	      globalCnt__h3336;
  wire [11 : 0] IF_updateEn_wget__4_BITS_20_TO_13_5_EQ_7_6_THE_ETC___d125,
		IF_updateEn_wget__4_BITS_20_TO_13_5_EQ_7_6_THE_ETC___d88,
		globalHist__h7945,
		globalHist__h9255;
  wire [9 : 0] n__h2786;
  wire [7 : 0] IF_updateEn_wget__4_BITS_20_TO_13_5_EQ_7_6_THE_ETC___d122,
	       IF_updateEn_wget__4_BITS_20_TO_13_5_EQ_7_6_THE_ETC___d83;
  wire [2 : 0] n__h3120;
  wire [1 : 0] IF_predCnt_lat_0_whas_THEN_predCnt_lat_0_wget__ETC___d8,
	       IF_predRes_lat_0_whas__5_THEN_predRes_lat_0_wg_ETC___d18,
	       n__h3719,
	       n__h4829,
	       upd__h10539,
	       upd__h2202,
	       upd__h2322,
	       upd__h9342,
	       x__h8065,
	       x__h9403,
	       y__h10572,
	       y__h9210;
  wire IF_SEL_ARR_choiceBht_sub_gHistReg_history__34__ETC___d177,
       IF_SEL_ARR_choiceBht_sub_gHistReg_history__34__ETC___d227,
       NOT_updateEn_wget__4_BIT_2_4_EQ_updateEn_wget__ETC___d97;

  // actionvalue method pred_0_pred
  assign pred_0_pred =
	     { IF_SEL_ARR_choiceBht_sub_gHistReg_history__34__ETC___d177,
	       globalHist__h7945,
	       localHist__h7939,
	       cnt__h8776[1],
	       cnt__h8505[2] } ;
  assign RDY_pred_0_pred = 1'd1 ;
  assign CAN_FIRE_pred_0_pred = 1'd1 ;
  assign WILL_FIRE_pred_0_pred = EN_pred_0_pred ;

  // actionvalue method pred_1_pred
  assign pred_1_pred =
	     { IF_SEL_ARR_choiceBht_sub_gHistReg_history__34__ETC___d227,
	       globalHist__h9255,
	       localHist__h9249,
	       cnt__h10110[1],
	       cnt__h9839[2] } ;
  assign RDY_pred_1_pred = 1'd1 ;
  assign CAN_FIRE_pred_1_pred = 1'd1 ;
  assign WILL_FIRE_pred_1_pred = EN_pred_1_pred ;

  // action method update
  assign RDY_update = 1'd1 ;
  assign CAN_FIRE_update = 1'd1 ;
  assign WILL_FIRE_update = EN_update ;

  // action method flush
  assign RDY_flush = flushDone ;
  assign CAN_FIRE_flush = flushDone ;
  assign WILL_FIRE_flush = EN_flush ;

  // value method flush_done
  assign flush_done = flushDone ;
  assign RDY_flush_done = 1'd1 ;

  // submodule choiceBht
  RegFile #(.addr_width(32'd9),
	    .data_width(32'd16),
	    .lo(9'd0),
	    .hi(9'd511)) choiceBht(.CLK(CLK),
				   .ADDR_1(choiceBht$ADDR_1),
				   .ADDR_2(choiceBht$ADDR_2),
				   .ADDR_3(choiceBht$ADDR_3),
				   .ADDR_4(choiceBht$ADDR_4),
				   .ADDR_5(choiceBht$ADDR_5),
				   .ADDR_IN(choiceBht$ADDR_IN),
				   .D_IN(choiceBht$D_IN),
				   .WE(choiceBht$WE),
				   .D_OUT_1(choiceBht$D_OUT_1),
				   .D_OUT_2(choiceBht$D_OUT_2),
				   .D_OUT_3(choiceBht$D_OUT_3),
				   .D_OUT_4(),
				   .D_OUT_5());

  // submodule gHistReg
  mkTourGHistReg gHistReg(.CLK(CLK),
			  .RST_N(RST_N),
			  .addHistory_num(gHistReg$addHistory_num),
			  .addHistory_taken(gHistReg$addHistory_taken),
			  .redirect_newHist(gHistReg$redirect_newHist),
			  .EN_addHistory(gHistReg$EN_addHistory),
			  .EN_redirect(gHistReg$EN_redirect),
			  .history(gHistReg$history),
			  .RDY_history(),
			  .RDY_addHistory(),
			  .RDY_redirect());

  // submodule globalBht
  RegFile #(.addr_width(32'd9),
	    .data_width(32'd16),
	    .lo(9'd0),
	    .hi(9'd511)) globalBht(.CLK(CLK),
				   .ADDR_1(globalBht$ADDR_1),
				   .ADDR_2(globalBht$ADDR_2),
				   .ADDR_3(globalBht$ADDR_3),
				   .ADDR_4(globalBht$ADDR_4),
				   .ADDR_5(globalBht$ADDR_5),
				   .ADDR_IN(globalBht$ADDR_IN),
				   .D_IN(globalBht$D_IN),
				   .WE(globalBht$WE),
				   .D_OUT_1(globalBht$D_OUT_1),
				   .D_OUT_2(globalBht$D_OUT_2),
				   .D_OUT_3(globalBht$D_OUT_3),
				   .D_OUT_4(),
				   .D_OUT_5());

  // submodule localBht
  RegFile #(.addr_width(32'd9),
	    .data_width(32'd6),
	    .lo(9'd0),
	    .hi(9'd511)) localBht(.CLK(CLK),
				  .ADDR_1(localBht$ADDR_1),
				  .ADDR_2(localBht$ADDR_2),
				  .ADDR_3(localBht$ADDR_3),
				  .ADDR_4(localBht$ADDR_4),
				  .ADDR_5(localBht$ADDR_5),
				  .ADDR_IN(localBht$ADDR_IN),
				  .D_IN(localBht$D_IN),
				  .WE(localBht$WE),
				  .D_OUT_1(localBht$D_OUT_1),
				  .D_OUT_2(localBht$D_OUT_2),
				  .D_OUT_3(localBht$D_OUT_3),
				  .D_OUT_4(),
				  .D_OUT_5());

  // submodule localHistTab
  RegFile #(.addr_width(32'd9),
	    .data_width(32'd20),
	    .lo(9'd0),
	    .hi(9'd511)) localHistTab(.CLK(CLK),
				      .ADDR_1(localHistTab$ADDR_1),
				      .ADDR_2(localHistTab$ADDR_2),
				      .ADDR_3(localHistTab$ADDR_3),
				      .ADDR_4(localHistTab$ADDR_4),
				      .ADDR_5(localHistTab$ADDR_5),
				      .ADDR_IN(localHistTab$ADDR_IN),
				      .D_IN(localHistTab$D_IN),
				      .WE(localHistTab$WE),
				      .D_OUT_1(localHistTab$D_OUT_1),
				      .D_OUT_2(localHistTab$D_OUT_2),
				      .D_OUT_3(localHistTab$D_OUT_3),
				      .D_OUT_4(),
				      .D_OUT_5());

  // rule RL_canonGlobalHist
  assign CAN_FIRE_RL_canonGlobalHist = 1'd1 ;
  assign WILL_FIRE_RL_canonGlobalHist = 1'd1 ;

  // rule RL_canonUpdate
  assign CAN_FIRE_RL_canonUpdate = flushDone && EN_update ;
  assign WILL_FIRE_RL_canonUpdate = CAN_FIRE_RL_canonUpdate ;

  // rule RL_canonFlush
  assign CAN_FIRE_RL_canonFlush = !flushDone ;
  assign WILL_FIRE_RL_canonFlush = CAN_FIRE_RL_canonFlush ;

  // rule RL_predCnt_canon
  assign CAN_FIRE_RL_predCnt_canon = 1'd1 ;
  assign WILL_FIRE_RL_predCnt_canon = 1'd1 ;

  // rule RL_predRes_canon
  assign CAN_FIRE_RL_predRes_canon = 1'd1 ;
  assign WILL_FIRE_RL_predRes_canon = 1'd1 ;

  // inputs to muxes for submodule ports
  assign MUX_choiceBht$upd_1__SEL_1 =
	     WILL_FIRE_RL_canonUpdate &&
	     NOT_updateEn_wget__4_BIT_2_4_EQ_updateEn_wget__ETC___d97 ;
  assign MUX_flushDone$write_1__SEL_1 =
	     WILL_FIRE_RL_canonFlush && flushIndex == 9'd511 ;
  assign MUX_gHistReg$redirect_1__SEL_1 =
	     WILL_FIRE_RL_canonUpdate && updateEn$wget[0] ;
  assign MUX_choiceBht$upd_2__VAL_1 =
	     { IF_updateEn_wget__4_BITS_20_TO_13_5_EQ_7_6_THE_ETC___d125,
	       (updateEn$wget[20:13] == 8'd1) ?
		 n__h4829 :
		 choiceBht$D_OUT_3[3:2],
	       (updateEn$wget[20:13] == 8'd0) ?
		 n__h4829 :
		 choiceBht$D_OUT_3[1:0] } ;
  assign MUX_globalBht$upd_2__VAL_1 =
	     { IF_updateEn_wget__4_BITS_20_TO_13_5_EQ_7_6_THE_ETC___d88,
	       (updateEn$wget[20:13] == 8'd1) ?
		 n__h3719 :
		 globalBht$D_OUT_3[3:2],
	       (updateEn$wget[20:13] == 8'd0) ?
		 n__h3719 :
		 globalBht$D_OUT_3[1:0] } ;
  assign MUX_localBht$upd_2__VAL_2 =
	     updateEn$wget[3] ?
	       { n__h3120, localBht$D_OUT_1[2:0] } :
	       { localBht$D_OUT_1[5:3], n__h3120 } ;
  assign MUX_localHistTab$upd_2__VAL_1 =
	     updateEn$wget[28] ?
	       { n__h2786, localHistTab$D_OUT_3[9:0] } :
	       { localHistTab$D_OUT_3[19:10], n__h2786 } ;

  // inlined wires
  assign predCnt_lat_0$wget = predCnt_rl + 2'd1 ;
  assign predCnt_lat_1$wget =
	     IF_predCnt_lat_0_whas_THEN_predCnt_lat_0_wget__ETC___d8 + 2'd1 ;
  assign predRes_lat_0$wget =
	     IF_SEL_ARR_choiceBht_sub_gHistReg_history__34__ETC___d177 ?
	       predRes_rl | x__h8065 :
	       predRes_rl & y__h9210 ;
  assign predRes_lat_1$wget =
	     IF_SEL_ARR_choiceBht_sub_gHistReg_history__34__ETC___d227 ?
	       IF_predRes_lat_0_whas__5_THEN_predRes_lat_0_wg_ETC___d18 |
	       x__h9403 :
	       IF_predRes_lat_0_whas__5_THEN_predRes_lat_0_wg_ETC___d18 &
	       y__h10572 ;
  assign updateEn$wget =
	     { update_pc, update_taken, update_train, update_mispred } ;

  // register flushDone
  assign flushDone$D_IN = MUX_flushDone$write_1__SEL_1 ;
  assign flushDone$EN =
	     WILL_FIRE_RL_canonFlush && flushIndex == 9'd511 || EN_flush ;

  // register flushIndex
  assign flushIndex$D_IN = flushIndex + 9'd1 ;
  assign flushIndex$EN = CAN_FIRE_RL_canonFlush ;

  // register predCnt_rl
  assign predCnt_rl$D_IN = 2'd0 ;
  assign predCnt_rl$EN = 1'd1 ;

  // register predRes_rl
  assign predRes_rl$D_IN = 2'd0 ;
  assign predRes_rl$EN = 1'd1 ;

  // submodule choiceBht
  assign choiceBht$ADDR_1 = globalHist__h9255[11:3] ;
  assign choiceBht$ADDR_2 = globalHist__h7945[11:3] ;
  assign choiceBht$ADDR_3 = updateEn$wget[24:16] ;
  assign choiceBht$ADDR_4 = 9'h0 ;
  assign choiceBht$ADDR_5 = 9'h0 ;
  assign choiceBht$ADDR_IN =
	     MUX_choiceBht$upd_1__SEL_1 ? updateEn$wget[24:16] : flushIndex ;
  assign choiceBht$D_IN =
	     MUX_choiceBht$upd_1__SEL_1 ? MUX_choiceBht$upd_2__VAL_1 : 16'd0 ;
  assign choiceBht$WE =
	     WILL_FIRE_RL_canonUpdate &&
	     NOT_updateEn_wget__4_BIT_2_4_EQ_updateEn_wget__ETC___d97 ||
	     WILL_FIRE_RL_canonFlush ;

  // submodule gHistReg
  assign gHistReg$addHistory_num =
	     EN_pred_1_pred ?
	       upd__h2322 :
	       IF_predCnt_lat_0_whas_THEN_predCnt_lat_0_wget__ETC___d8 ;
  assign gHistReg$addHistory_taken =
	     EN_pred_1_pred ?
	       upd__h2202 :
	       IF_predRes_lat_0_whas__5_THEN_predRes_lat_0_wg_ETC___d18 ;
  assign gHistReg$redirect_newHist =
	     MUX_gHistReg$redirect_1__SEL_1 ? updateEn$wget[25:14] : 12'd0 ;
  assign gHistReg$EN_addHistory = 1'd1 ;
  assign gHistReg$EN_redirect =
	     WILL_FIRE_RL_canonUpdate && updateEn$wget[0] ||
	     WILL_FIRE_RL_canonFlush ;

  // submodule globalBht
  assign globalBht$ADDR_1 = globalHist__h9255[11:3] ;
  assign globalBht$ADDR_2 = globalHist__h7945[11:3] ;
  assign globalBht$ADDR_3 = updateEn$wget[24:16] ;
  assign globalBht$ADDR_4 = 9'h0 ;
  assign globalBht$ADDR_5 = 9'h0 ;
  assign globalBht$ADDR_IN =
	     WILL_FIRE_RL_canonUpdate ? updateEn$wget[24:16] : flushIndex ;
  assign globalBht$D_IN =
	     WILL_FIRE_RL_canonUpdate ? MUX_globalBht$upd_2__VAL_1 : 16'd0 ;
  assign globalBht$WE = WILL_FIRE_RL_canonUpdate || WILL_FIRE_RL_canonFlush ;

  // submodule localBht
  assign localBht$ADDR_1 = updateEn$wget[12:4] ;
  assign localBht$ADDR_2 = localHist__h9249[9:1] ;
  assign localBht$ADDR_3 = localHist__h7939[9:1] ;
  assign localBht$ADDR_4 = 9'h0 ;
  assign localBht$ADDR_5 = 9'h0 ;
  assign localBht$ADDR_IN =
	     WILL_FIRE_RL_canonFlush ? flushIndex : updateEn$wget[12:4] ;
  assign localBht$D_IN =
	     WILL_FIRE_RL_canonFlush ? 6'd0 : MUX_localBht$upd_2__VAL_2 ;
  assign localBht$WE = WILL_FIRE_RL_canonFlush || WILL_FIRE_RL_canonUpdate ;

  // submodule localHistTab
  assign localHistTab$ADDR_1 = pred_1_pred_pc[11:3] ;
  assign localHistTab$ADDR_2 = pred_0_pred_pc[11:3] ;
  assign localHistTab$ADDR_3 = updateEn$wget[37:29] ;
  assign localHistTab$ADDR_4 = 9'h0 ;
  assign localHistTab$ADDR_5 = 9'h0 ;
  assign localHistTab$ADDR_IN =
	     WILL_FIRE_RL_canonUpdate ? updateEn$wget[37:29] : flushIndex ;
  assign localHistTab$D_IN =
	     WILL_FIRE_RL_canonUpdate ?
	       MUX_localHistTab$upd_2__VAL_1 :
	       20'd0 ;
  assign localHistTab$WE =
	     WILL_FIRE_RL_canonUpdate || WILL_FIRE_RL_canonFlush ;

  // remaining internal signals
  assign IF_SEL_ARR_choiceBht_sub_gHistReg_history__34__ETC___d177 =
	     cnt__h8084[1] ? cnt__h8505[2] : cnt__h8776[1] ;
  assign IF_SEL_ARR_choiceBht_sub_gHistReg_history__34__ETC___d227 =
	     cnt__h9422[1] ? cnt__h9839[2] : cnt__h10110[1] ;
  assign IF_predCnt_lat_0_whas_THEN_predCnt_lat_0_wget__ETC___d8 =
	     EN_pred_0_pred ? upd__h9342 : predCnt_rl ;
  assign IF_predRes_lat_0_whas__5_THEN_predRes_lat_0_wg_ETC___d18 =
	     EN_pred_0_pred ? upd__h10539 : predRes_rl ;
  assign IF_updateEn_wget__4_BITS_20_TO_13_5_EQ_7_6_THE_ETC___d122 =
	     { (updateEn$wget[20:13] == 8'd7) ?
		 n__h4829 :
		 choiceBht$D_OUT_3[15:14],
	       (updateEn$wget[20:13] == 8'd6) ?
		 n__h4829 :
		 choiceBht$D_OUT_3[13:12],
	       (updateEn$wget[20:13] == 8'd5) ?
		 n__h4829 :
		 choiceBht$D_OUT_3[11:10],
	       (updateEn$wget[20:13] == 8'd4) ?
		 n__h4829 :
		 choiceBht$D_OUT_3[9:8] } ;
  assign IF_updateEn_wget__4_BITS_20_TO_13_5_EQ_7_6_THE_ETC___d125 =
	     { IF_updateEn_wget__4_BITS_20_TO_13_5_EQ_7_6_THE_ETC___d122,
	       (updateEn$wget[20:13] == 8'd3) ?
		 n__h4829 :
		 choiceBht$D_OUT_3[7:6],
	       (updateEn$wget[20:13] == 8'd2) ?
		 n__h4829 :
		 choiceBht$D_OUT_3[5:4] } ;
  assign IF_updateEn_wget__4_BITS_20_TO_13_5_EQ_7_6_THE_ETC___d83 =
	     { (updateEn$wget[20:13] == 8'd7) ?
		 n__h3719 :
		 globalBht$D_OUT_3[15:14],
	       (updateEn$wget[20:13] == 8'd6) ?
		 n__h3719 :
		 globalBht$D_OUT_3[13:12],
	       (updateEn$wget[20:13] == 8'd5) ?
		 n__h3719 :
		 globalBht$D_OUT_3[11:10],
	       (updateEn$wget[20:13] == 8'd4) ?
		 n__h3719 :
		 globalBht$D_OUT_3[9:8] } ;
  assign IF_updateEn_wget__4_BITS_20_TO_13_5_EQ_7_6_THE_ETC___d88 =
	     { IF_updateEn_wget__4_BITS_20_TO_13_5_EQ_7_6_THE_ETC___d83,
	       (updateEn$wget[20:13] == 8'd3) ?
		 n__h3719 :
		 globalBht$D_OUT_3[7:6],
	       (updateEn$wget[20:13] == 8'd2) ?
		 n__h3719 :
		 globalBht$D_OUT_3[5:4] } ;
  assign NOT_updateEn_wget__4_BIT_2_4_EQ_updateEn_wget__ETC___d97 =
	     updateEn$wget[2] != updateEn$wget[1] ;
  assign globalHist__h7945 = gHistReg$history >> predCnt_rl ;
  assign globalHist__h9255 =
	     gHistReg$history >>
	     IF_predCnt_lat_0_whas_THEN_predCnt_lat_0_wget__ETC___d8 ;
  assign n__h2786 = { updateEn$wget[25], updateEn$wget[12:4] } ;
  assign n__h3120 =
	     updateEn$wget[25] ?
	       ((localCnt__h2959 == 3'd7) ?
		  localCnt__h2959 :
		  localCnt__h2959 + 3'd1) :
	       ((localCnt__h2959 == 3'd0) ?
		  localCnt__h2959 :
		  localCnt__h2959 - 3'd1) ;
  assign n__h3719 =
	     updateEn$wget[25] ?
	       ((globalCnt__h3336 == 2'd3) ?
		  globalCnt__h3336 :
		  globalCnt__h3336 + 2'd1) :
	       ((globalCnt__h3336 == 2'd0) ?
		  globalCnt__h3336 :
		  globalCnt__h3336 - 2'd1) ;
  assign n__h4829 =
	     (updateEn$wget[1] == updateEn$wget[25]) ?
	       ((choiceCnt__h4464 == 2'd3) ?
		  choiceCnt__h4464 :
		  choiceCnt__h4464 + 2'd1) :
	       ((choiceCnt__h4464 == 2'd0) ?
		  choiceCnt__h4464 :
		  choiceCnt__h4464 - 2'd1) ;
  assign upd__h10539 = predRes_lat_0$wget ;
  assign upd__h2202 = predRes_lat_1$wget ;
  assign upd__h2322 = predCnt_lat_1$wget ;
  assign upd__h9342 = predCnt_lat_0$wget ;
  assign x__h8065 = 2'd1 << predCnt_rl ;
  assign x__h9403 =
	     2'd1 << IF_predCnt_lat_0_whas_THEN_predCnt_lat_0_wget__ETC___d8 ;
  assign y__h10572 = ~x__h9403 ;
  assign y__h9210 = ~x__h8065 ;
  always@(pred_1_pred_pc or localHistTab$D_OUT_1)
  begin
    case (pred_1_pred_pc[2])
      1'd0: localHist__h9249 = localHistTab$D_OUT_1[9:0];
      1'd1: localHist__h9249 = localHistTab$D_OUT_1[19:10];
    endcase
  end
  always@(pred_0_pred_pc or localHistTab$D_OUT_2)
  begin
    case (pred_0_pred_pc[2])
      1'd0: localHist__h7939 = localHistTab$D_OUT_2[9:0];
      1'd1: localHist__h7939 = localHistTab$D_OUT_2[19:10];
    endcase
  end
  always@(localHist__h7939 or localBht$D_OUT_3)
  begin
    case (localHist__h7939[0])
      1'd0: cnt__h8505 = localBht$D_OUT_3[2:0];
      1'd1: cnt__h8505 = localBht$D_OUT_3[5:3];
    endcase
  end
  always@(localHist__h9249 or localBht$D_OUT_2)
  begin
    case (localHist__h9249[0])
      1'd0: cnt__h9839 = localBht$D_OUT_2[2:0];
      1'd1: cnt__h9839 = localBht$D_OUT_2[5:3];
    endcase
  end
  always@(globalHist__h7945 or choiceBht$D_OUT_2)
  begin
    case (globalHist__h7945[7:0])
      8'd0: cnt__h8084 = choiceBht$D_OUT_2[1:0];
      8'd1: cnt__h8084 = choiceBht$D_OUT_2[3:2];
      8'd2: cnt__h8084 = choiceBht$D_OUT_2[5:4];
      8'd3: cnt__h8084 = choiceBht$D_OUT_2[7:6];
      8'd4: cnt__h8084 = choiceBht$D_OUT_2[9:8];
      8'd5: cnt__h8084 = choiceBht$D_OUT_2[11:10];
      8'd6: cnt__h8084 = choiceBht$D_OUT_2[13:12];
      8'd7: cnt__h8084 = choiceBht$D_OUT_2[15:14];
      default: cnt__h8084 = 2'b10 /* unspecified value */ ;
    endcase
  end
  always@(globalHist__h7945 or globalBht$D_OUT_2)
  begin
    case (globalHist__h7945[7:0])
      8'd0: cnt__h8776 = globalBht$D_OUT_2[1:0];
      8'd1: cnt__h8776 = globalBht$D_OUT_2[3:2];
      8'd2: cnt__h8776 = globalBht$D_OUT_2[5:4];
      8'd3: cnt__h8776 = globalBht$D_OUT_2[7:6];
      8'd4: cnt__h8776 = globalBht$D_OUT_2[9:8];
      8'd5: cnt__h8776 = globalBht$D_OUT_2[11:10];
      8'd6: cnt__h8776 = globalBht$D_OUT_2[13:12];
      8'd7: cnt__h8776 = globalBht$D_OUT_2[15:14];
      default: cnt__h8776 = 2'b10 /* unspecified value */ ;
    endcase
  end
  always@(globalHist__h9255 or choiceBht$D_OUT_1)
  begin
    case (globalHist__h9255[7:0])
      8'd0: cnt__h9422 = choiceBht$D_OUT_1[1:0];
      8'd1: cnt__h9422 = choiceBht$D_OUT_1[3:2];
      8'd2: cnt__h9422 = choiceBht$D_OUT_1[5:4];
      8'd3: cnt__h9422 = choiceBht$D_OUT_1[7:6];
      8'd4: cnt__h9422 = choiceBht$D_OUT_1[9:8];
      8'd5: cnt__h9422 = choiceBht$D_OUT_1[11:10];
      8'd6: cnt__h9422 = choiceBht$D_OUT_1[13:12];
      8'd7: cnt__h9422 = choiceBht$D_OUT_1[15:14];
      default: cnt__h9422 = 2'b10 /* unspecified value */ ;
    endcase
  end
  always@(globalHist__h9255 or globalBht$D_OUT_1)
  begin
    case (globalHist__h9255[7:0])
      8'd0: cnt__h10110 = globalBht$D_OUT_1[1:0];
      8'd1: cnt__h10110 = globalBht$D_OUT_1[3:2];
      8'd2: cnt__h10110 = globalBht$D_OUT_1[5:4];
      8'd3: cnt__h10110 = globalBht$D_OUT_1[7:6];
      8'd4: cnt__h10110 = globalBht$D_OUT_1[9:8];
      8'd5: cnt__h10110 = globalBht$D_OUT_1[11:10];
      8'd6: cnt__h10110 = globalBht$D_OUT_1[13:12];
      8'd7: cnt__h10110 = globalBht$D_OUT_1[15:14];
      default: cnt__h10110 = 2'b10 /* unspecified value */ ;
    endcase
  end
  always@(updateEn$wget or localBht$D_OUT_1)
  begin
    case (updateEn$wget[3])
      1'd0: localCnt__h2959 = localBht$D_OUT_1[2:0];
      1'd1: localCnt__h2959 = localBht$D_OUT_1[5:3];
    endcase
  end
  always@(updateEn$wget or globalBht$D_OUT_3)
  begin
    case (updateEn$wget[20:13])
      8'd0: globalCnt__h3336 = globalBht$D_OUT_3[1:0];
      8'd1: globalCnt__h3336 = globalBht$D_OUT_3[3:2];
      8'd2: globalCnt__h3336 = globalBht$D_OUT_3[5:4];
      8'd3: globalCnt__h3336 = globalBht$D_OUT_3[7:6];
      8'd4: globalCnt__h3336 = globalBht$D_OUT_3[9:8];
      8'd5: globalCnt__h3336 = globalBht$D_OUT_3[11:10];
      8'd6: globalCnt__h3336 = globalBht$D_OUT_3[13:12];
      8'd7: globalCnt__h3336 = globalBht$D_OUT_3[15:14];
      default: globalCnt__h3336 = 2'b10 /* unspecified value */ ;
    endcase
  end
  always@(updateEn$wget or choiceBht$D_OUT_3)
  begin
    case (updateEn$wget[20:13])
      8'd0: choiceCnt__h4464 = choiceBht$D_OUT_3[1:0];
      8'd1: choiceCnt__h4464 = choiceBht$D_OUT_3[3:2];
      8'd2: choiceCnt__h4464 = choiceBht$D_OUT_3[5:4];
      8'd3: choiceCnt__h4464 = choiceBht$D_OUT_3[7:6];
      8'd4: choiceCnt__h4464 = choiceBht$D_OUT_3[9:8];
      8'd5: choiceCnt__h4464 = choiceBht$D_OUT_3[11:10];
      8'd6: choiceCnt__h4464 = choiceBht$D_OUT_3[13:12];
      8'd7: choiceCnt__h4464 = choiceBht$D_OUT_3[15:14];
      default: choiceCnt__h4464 = 2'b10 /* unspecified value */ ;
    endcase
  end

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        flushDone <= `BSV_ASSIGNMENT_DELAY 1'd1;
	flushIndex <= `BSV_ASSIGNMENT_DELAY 9'd0;
	predCnt_rl <= `BSV_ASSIGNMENT_DELAY 2'd0;
	predRes_rl <= `BSV_ASSIGNMENT_DELAY 2'd0;
      end
    else
      begin
        if (flushDone$EN) flushDone <= `BSV_ASSIGNMENT_DELAY flushDone$D_IN;
	if (flushIndex$EN)
	  flushIndex <= `BSV_ASSIGNMENT_DELAY flushIndex$D_IN;
	if (predCnt_rl$EN)
	  predCnt_rl <= `BSV_ASSIGNMENT_DELAY predCnt_rl$D_IN;
	if (predRes_rl$EN)
	  predRes_rl <= `BSV_ASSIGNMENT_DELAY predRes_rl$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    flushDone = 1'h0;
    flushIndex = 9'h0AA;
    predCnt_rl = 2'h2;
    predRes_rl = 2'h2;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkTourPredSecure

