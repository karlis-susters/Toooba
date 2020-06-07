//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
// On Sat Jun  6 22:44:24 BST 2020
//
//
// Ports:
// Name                         I/O  size props
// specialRWALU                   O   163
// specialRWALU_cap               I   163
// specialRWALU_oldCap            I   163
// specialRWALU_scrType           I     5
//
// Combinational paths from inputs to outputs:
//   (specialRWALU_cap,
//    specialRWALU_oldCap,
//    specialRWALU_scrType) -> specialRWALU
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

module module_specialRWALU(specialRWALU_cap,
			   specialRWALU_oldCap,
			   specialRWALU_scrType,
			   specialRWALU);
  // value method specialRWALU
  input  [162 : 0] specialRWALU_cap;
  input  [162 : 0] specialRWALU_oldCap;
  input  [4 : 0] specialRWALU_scrType;
  output [162 : 0] specialRWALU;

  // signals for module outputs
  wire [162 : 0] specialRWALU;

  // remaining internal signals
  reg [65 : 0] IF_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_ETC___d166;
  reg [63 : 0] IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d35;
  reg [13 : 0] CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q1;
  reg [4 : 0] CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q3;
  reg [2 : 0] CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q5,
	      IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8;
  reg CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q2,
      CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q4,
      CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q6;
  wire [71 : 0] IF_specialRWALU_scrType_BITS_4_TO_2_EQ_0_OR_IF_ETC___d205;
  wire [65 : 0] IF_specialRWALU_scrType_BITS_4_TO_2_EQ_1_OR_IF_ETC___d167,
		in__h1125,
		in__h392,
		res_capFat_address__h1768,
		x__h1143,
		x__h410,
		y__h1142,
		y__h409;
  wire [63 : 0] SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d95,
		addBase__h1838,
		addBase__h2022,
		bot__h1841,
		bot__h2025,
		offsetAddr__h129,
		offsetAddr__h1382,
		offsetAddr__h693,
		offsetAddr__h987,
		oldOffset__h23,
		x__h1043,
		x__h1045,
		x__h1262,
		x__h1509,
		x__h283,
		x__h285,
		x__h564,
		x__h867,
		y__h764;
  wire [49 : 0] highOffsetBits__h1386,
		highOffsetBits__h697,
		mask__h1931,
		mask__h2115,
		signBits__h1383,
		signBits__h694,
		x__h1413,
		x__h724;
  wire [15 : 0] newAddrBits__h1640,
		newAddrBits__h1674,
		newAddrBits__h1708,
		newAddrBits__h1742,
		offset__h1031,
		offset__h271,
		x__h1895,
		x__h2079;
  wire [13 : 0] IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d190,
		IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d196,
		IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d176,
		IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d182,
		IF_specialRWALU_scrType_BITS_4_TO_2_EQ_1_OR_IF_ETC___d199,
		res_capFat_addrBits__h1769,
		toBoundsM1__h1396,
		toBoundsM1__h707,
		toBounds__h1395,
		toBounds__h706;
  wire [9 : 0] IF_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_ETC___d280,
	       IF_specialRWALU_scrType_BITS_4_TO_2_EQ_0_OR_NO_ETC___d282,
	       IF_specialRWALU_scrType_BITS_4_TO_2_EQ_1_OR_IF_ETC___d281;
  wire [5 : 0] IF_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_ETC___d279;
  wire [4 : 0] IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d263,
	       IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d275;
  wire [3 : 0] IF_specialRWALU_oldCap_BITS_37_TO_35_09_ULT_sp_ETC___d223,
	       IF_specialRWALU_oldCap_BITS_37_TO_35_09_ULT_sp_ETC___d237;
  wire [2 : 0] repBound__h2650, repBound__h2672;
  wire IF_IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0__ETC___d56,
       IF_IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0__ETC___d75,
       IF_SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO__ETC___d116,
       IF_SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO__ETC___d134,
       IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d253,
       IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d265,
       IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d213,
       IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d227,
       IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d63,
       IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d78,
       IF_specialRWALU_scrType_BITS_4_TO_2_EQ_0_OR_NO_ETC___d142,
       IF_specialRWALU_scrType_BITS_4_TO_2_EQ_1_OR_IF_ETC___d141,
       NOT_specialRWALU_cap_BITS_43_TO_38_8_ULT_50_18___d119,
       NOT_specialRWALU_oldCap_BITS_43_TO_38_3_ULT_50_8___d59,
       SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d123,
       SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d137,
       specialRWALU_cap_BITS_23_TO_21_41_ULT_specialR_ETC___d249,
       specialRWALU_cap_BITS_37_TO_35_45_ULT_specialR_ETC___d246,
       specialRWALU_oldCap_BITS_23_TO_21_07_ULT_speci_ETC___d211,
       specialRWALU_oldCap_BITS_37_TO_35_09_ULT_speci_ETC___d210;

  // value method specialRWALU
  assign specialRWALU =
	     { IF_specialRWALU_scrType_BITS_4_TO_2_EQ_0_OR_NO_ETC___d142,
	       res_capFat_address__h1768,
	       res_capFat_addrBits__h1769,
	       IF_specialRWALU_scrType_BITS_4_TO_2_EQ_0_OR_IF_ETC___d205,
	       IF_specialRWALU_scrType_BITS_4_TO_2_EQ_0_OR_NO_ETC___d282 } ;

  // remaining internal signals
  assign IF_IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0__ETC___d56 =
	     IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d35[63] ?
	       x__h564[13:0] >= toBounds__h706 :
	       x__h564[13:0] <= toBoundsM1__h707 ;
  assign IF_IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0__ETC___d75 =
	     IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d35[63] ?
	       x__h867[13:0] >= toBounds__h706 :
	       x__h867[13:0] <= toBoundsM1__h707 ;
  assign IF_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_ETC___d279 =
	     { CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q2,
	       CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q3 } ;
  assign IF_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_ETC___d280 =
	     { CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q5,
	       CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q6,
	       IF_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_ETC___d279 } ;
  assign IF_SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO__ETC___d116 =
	     SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d95[63] ?
	       x__h1262[13:0] >= toBounds__h1395 :
	       x__h1262[13:0] <= toBoundsM1__h1396 ;
  assign IF_SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO__ETC___d134 =
	     SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d95[63] ?
	       x__h1509[13:0] >= toBounds__h1395 :
	       x__h1509[13:0] <= toBoundsM1__h1396 ;
  assign IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d190 =
	     (specialRWALU_cap[43:38] == 6'd52) ?
	       { 1'b0, newAddrBits__h1708[12:0] } :
	       newAddrBits__h1708[13:0] ;
  assign IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d196 =
	     (specialRWALU_cap[43:38] == 6'd52) ?
	       { 1'b0, newAddrBits__h1742[12:0] } :
	       newAddrBits__h1742[13:0] ;
  assign IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d253 =
	     IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d190[13:11] <
	     repBound__h2672 ;
  assign IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d263 =
	     { IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d253,
	       (specialRWALU_cap_BITS_37_TO_35_45_ULT_specialR_ETC___d246 ==
		IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d253) ?
		 2'd0 :
		 ((specialRWALU_cap_BITS_37_TO_35_45_ULT_specialR_ETC___d246 &&
		   !IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d253) ?
		    2'd1 :
		    2'd3),
	       (specialRWALU_cap_BITS_23_TO_21_41_ULT_specialR_ETC___d249 ==
		IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d253) ?
		 2'd0 :
		 ((specialRWALU_cap_BITS_23_TO_21_41_ULT_specialR_ETC___d249 &&
		   !IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d253) ?
		    2'd1 :
		    2'd3) } ;
  assign IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d265 =
	     IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d196[13:11] <
	     repBound__h2672 ;
  assign IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d275 =
	     { IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d265,
	       (specialRWALU_cap_BITS_37_TO_35_45_ULT_specialR_ETC___d246 ==
		IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d265) ?
		 2'd0 :
		 ((specialRWALU_cap_BITS_37_TO_35_45_ULT_specialR_ETC___d246 &&
		   !IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d265) ?
		    2'd1 :
		    2'd3),
	       (specialRWALU_cap_BITS_23_TO_21_41_ULT_specialR_ETC___d249 ==
		IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d265) ?
		 2'd0 :
		 ((specialRWALU_cap_BITS_23_TO_21_41_ULT_specialR_ETC___d249 &&
		   !IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d265) ?
		    2'd1 :
		    2'd3) } ;
  assign IF_specialRWALU_oldCap_BITS_37_TO_35_09_ULT_sp_ETC___d223 =
	     { (specialRWALU_oldCap_BITS_37_TO_35_09_ULT_speci_ETC___d210 ==
		IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d213) ?
		 2'd0 :
		 ((specialRWALU_oldCap_BITS_37_TO_35_09_ULT_speci_ETC___d210 &&
		   !IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d213) ?
		    2'd1 :
		    2'd3),
	       (specialRWALU_oldCap_BITS_23_TO_21_07_ULT_speci_ETC___d211 ==
		IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d213) ?
		 2'd0 :
		 ((specialRWALU_oldCap_BITS_23_TO_21_07_ULT_speci_ETC___d211 &&
		   !IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d213) ?
		    2'd1 :
		    2'd3) } ;
  assign IF_specialRWALU_oldCap_BITS_37_TO_35_09_ULT_sp_ETC___d237 =
	     { (specialRWALU_oldCap_BITS_37_TO_35_09_ULT_speci_ETC___d210 ==
		IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d227) ?
		 2'd0 :
		 ((specialRWALU_oldCap_BITS_37_TO_35_09_ULT_speci_ETC___d210 &&
		   !IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d227) ?
		    2'd1 :
		    2'd3),
	       (specialRWALU_oldCap_BITS_23_TO_21_07_ULT_speci_ETC___d211 ==
		IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d227) ?
		 2'd0 :
		 ((specialRWALU_oldCap_BITS_23_TO_21_07_ULT_speci_ETC___d211 &&
		   !IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d227) ?
		    2'd1 :
		    2'd3) } ;
  assign IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d176 =
	     (specialRWALU_oldCap[43:38] == 6'd52) ?
	       { 1'b0, newAddrBits__h1640[12:0] } :
	       newAddrBits__h1640[13:0] ;
  assign IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d182 =
	     (specialRWALU_oldCap[43:38] == 6'd52) ?
	       { 1'b0, newAddrBits__h1674[12:0] } :
	       newAddrBits__h1674[13:0] ;
  assign IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d213 =
	     IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d176[13:11] <
	     repBound__h2650 ;
  assign IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d227 =
	     IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d182[13:11] <
	     repBound__h2650 ;
  assign IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d63 =
	     (highOffsetBits__h697 == 50'd0 &&
	      IF_IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0__ETC___d56 ||
	      NOT_specialRWALU_oldCap_BITS_43_TO_38_3_ULT_50_8___d59) &&
	     specialRWALU_oldCap[62:45] == 18'd262143 ;
  assign IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d78 =
	     (highOffsetBits__h697 == 50'd0 &&
	      IF_IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0__ETC___d75 ||
	      NOT_specialRWALU_oldCap_BITS_43_TO_38_3_ULT_50_8___d59) &&
	     specialRWALU_oldCap[62:45] == 18'd262143 ;
  assign IF_specialRWALU_scrType_BITS_4_TO_2_EQ_0_OR_IF_ETC___d205 =
	     (specialRWALU_scrType[4:2] == 3'd0 ||
	      IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 ==
	      3'd0 ||
	      specialRWALU_scrType[4:2] == 3'd1 ||
	      IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 ==
	      3'd1) ?
	       specialRWALU_oldCap[81:10] :
	       specialRWALU_cap[81:10] ;
  assign IF_specialRWALU_scrType_BITS_4_TO_2_EQ_0_OR_NO_ETC___d142 =
	     (specialRWALU_scrType[4:2] == 3'd0 ||
	      specialRWALU_scrType[4:2] != 3'd1 &&
	      IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 ==
	      3'd0) ?
	       IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d63 &&
	       specialRWALU_oldCap[162] :
	       IF_specialRWALU_scrType_BITS_4_TO_2_EQ_1_OR_IF_ETC___d141 ;
  assign IF_specialRWALU_scrType_BITS_4_TO_2_EQ_0_OR_NO_ETC___d282 =
	     (specialRWALU_scrType[4:2] == 3'd0 ||
	      specialRWALU_scrType[4:2] != 3'd1 &&
	      IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 ==
	      3'd0) ?
	       { repBound__h2650,
		 specialRWALU_oldCap_BITS_37_TO_35_09_ULT_speci_ETC___d210,
		 specialRWALU_oldCap_BITS_23_TO_21_07_ULT_speci_ETC___d211,
		 IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d213,
		 IF_specialRWALU_oldCap_BITS_37_TO_35_09_ULT_sp_ETC___d223 } :
	       IF_specialRWALU_scrType_BITS_4_TO_2_EQ_1_OR_IF_ETC___d281 ;
  assign IF_specialRWALU_scrType_BITS_4_TO_2_EQ_1_OR_IF_ETC___d141 =
	     (specialRWALU_scrType[4:2] == 3'd1 ||
	      IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 ==
	      3'd1) ?
	       IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d78 &&
	       specialRWALU_oldCap[162] :
	       CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q4 ;
  assign IF_specialRWALU_scrType_BITS_4_TO_2_EQ_1_OR_IF_ETC___d167 =
	     (specialRWALU_scrType[4:2] == 3'd1 ||
	      IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 ==
	      3'd1) ?
	       { 2'd0, bot__h1841 } + { 2'd0, offsetAddr__h693 } :
	       IF_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_ETC___d166 ;
  assign IF_specialRWALU_scrType_BITS_4_TO_2_EQ_1_OR_IF_ETC___d199 =
	     (specialRWALU_scrType[4:2] == 3'd1 ||
	      IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 ==
	      3'd1) ?
	       IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d182 :
	       CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q1 ;
  assign IF_specialRWALU_scrType_BITS_4_TO_2_EQ_1_OR_IF_ETC___d281 =
	     (specialRWALU_scrType[4:2] == 3'd1 ||
	      IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 ==
	      3'd1) ?
	       { repBound__h2650,
		 specialRWALU_oldCap_BITS_37_TO_35_09_ULT_speci_ETC___d210,
		 specialRWALU_oldCap_BITS_23_TO_21_07_ULT_speci_ETC___d211,
		 IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d227,
		 IF_specialRWALU_oldCap_BITS_37_TO_35_09_ULT_sp_ETC___d237 } :
	       IF_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_ETC___d280 ;
  assign NOT_specialRWALU_cap_BITS_43_TO_38_8_ULT_50_18___d119 =
	     specialRWALU_cap[43:38] >= 6'd50 ;
  assign NOT_specialRWALU_oldCap_BITS_43_TO_38_3_ULT_50_8___d59 =
	     specialRWALU_oldCap[43:38] >= 6'd50 ;
  assign SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d123 =
	     (highOffsetBits__h1386 == 50'd0 &&
	      IF_SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO__ETC___d116 ||
	      NOT_specialRWALU_cap_BITS_43_TO_38_8_ULT_50_18___d119) &&
	     specialRWALU_cap[62:45] == 18'd262143 ;
  assign SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d137 =
	     (highOffsetBits__h1386 == 50'd0 &&
	      IF_SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO__ETC___d134 ||
	      NOT_specialRWALU_cap_BITS_43_TO_38_8_ULT_50_18___d119) &&
	     specialRWALU_cap[62:45] == 18'd262143 ;
  assign SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d95 =
	     x__h1043 | in__h1125[63:0] ;
  assign addBase__h1838 =
	     { {48{x__h1895[15]}}, x__h1895 } << specialRWALU_oldCap[43:38] ;
  assign addBase__h2022 =
	     { {48{x__h2079[15]}}, x__h2079 } << specialRWALU_cap[43:38] ;
  assign bot__h1841 =
	     { specialRWALU_oldCap[159:110] & mask__h1931, 14'd0 } +
	     addBase__h1838 ;
  assign bot__h2025 =
	     { specialRWALU_cap[159:110] & mask__h2115, 14'd0 } +
	     addBase__h2022 ;
  assign highOffsetBits__h1386 = x__h1413 & mask__h2115 ;
  assign highOffsetBits__h697 = x__h724 & mask__h1931 ;
  assign in__h1125 = specialRWALU_cap[161:96] & y__h1142 ;
  assign in__h392 = specialRWALU_oldCap[161:96] & y__h409 ;
  assign mask__h1931 = 50'h3FFFFFFFFFFFF << specialRWALU_oldCap[43:38] ;
  assign mask__h2115 = 50'h3FFFFFFFFFFFF << specialRWALU_cap[43:38] ;
  assign newAddrBits__h1640 =
	     { 2'd0, specialRWALU_oldCap[23:10] } + { 2'd0, x__h564[13:0] } ;
  assign newAddrBits__h1674 =
	     { 2'd0, specialRWALU_oldCap[23:10] } + { 2'd0, x__h867[13:0] } ;
  assign newAddrBits__h1708 =
	     { 2'd0, specialRWALU_cap[23:10] } + { 2'd0, x__h1262[13:0] } ;
  assign newAddrBits__h1742 =
	     { 2'd0, specialRWALU_cap[23:10] } + { 2'd0, x__h1509[13:0] } ;
  assign offsetAddr__h129 =
	     { IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d35[63:2],
	       1'd0,
	       IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d35[0] } ;
  assign offsetAddr__h1382 =
	     { SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d95[63:1],
	       1'd0 } ;
  assign offsetAddr__h693 =
	     { IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d35[63:1],
	       1'd0 } ;
  assign offsetAddr__h987 =
	     { SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d95[63:2],
	       1'd0,
	       SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d95[0] } ;
  assign offset__h1031 = { 2'd0, specialRWALU_cap[95:82] } - x__h2079 ;
  assign offset__h271 = { 2'd0, specialRWALU_oldCap[95:82] } - x__h1895 ;
  assign oldOffset__h23 = x__h283 | in__h392[63:0] ;
  assign repBound__h2650 = specialRWALU_oldCap[23:21] - 3'b001 ;
  assign repBound__h2672 = specialRWALU_cap[23:21] - 3'b001 ;
  assign res_capFat_addrBits__h1769 =
	     (specialRWALU_scrType[4:2] == 3'd0 ||
	      specialRWALU_scrType[4:2] != 3'd1 &&
	      IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 ==
	      3'd0) ?
	       IF_specialRWALU_oldCap_BITS_43_TO_38_3_EQ_52_6_ETC___d176 :
	       IF_specialRWALU_scrType_BITS_4_TO_2_EQ_1_OR_IF_ETC___d199 ;
  assign res_capFat_address__h1768 =
	     (specialRWALU_scrType[4:2] == 3'd0 ||
	      specialRWALU_scrType[4:2] != 3'd1 &&
	      IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 ==
	      3'd0) ?
	       { 2'd0, bot__h1841 } + { 2'd0, offsetAddr__h129 } :
	       IF_specialRWALU_scrType_BITS_4_TO_2_EQ_1_OR_IF_ETC___d167 ;
  assign signBits__h1383 =
	     {50{SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d95[63]}} ;
  assign signBits__h694 =
	     {50{IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d35[63]}} ;
  assign specialRWALU_cap_BITS_23_TO_21_41_ULT_specialR_ETC___d249 =
	     specialRWALU_cap[23:21] < repBound__h2672 ;
  assign specialRWALU_cap_BITS_37_TO_35_45_ULT_specialR_ETC___d246 =
	     specialRWALU_cap[37:35] < repBound__h2672 ;
  assign specialRWALU_oldCap_BITS_23_TO_21_07_ULT_speci_ETC___d211 =
	     specialRWALU_oldCap[23:21] < repBound__h2650 ;
  assign specialRWALU_oldCap_BITS_37_TO_35_09_ULT_speci_ETC___d210 =
	     specialRWALU_oldCap[37:35] < repBound__h2650 ;
  assign toBoundsM1__h1396 = { 3'b110, ~specialRWALU_cap[20:10] } ;
  assign toBoundsM1__h707 = { 3'b110, ~specialRWALU_oldCap[20:10] } ;
  assign toBounds__h1395 = 14'd14336 - { 3'b0, specialRWALU_cap[20:10] } ;
  assign toBounds__h706 = 14'd14336 - { 3'b0, specialRWALU_oldCap[20:10] } ;
  assign x__h1043 = x__h1045 << specialRWALU_cap[43:38] ;
  assign x__h1045 = { {48{offset__h1031[15]}}, offset__h1031 } ;
  assign x__h1143 = 66'h3FFFFFFFFFFFFFFFF << specialRWALU_cap[43:38] ;
  assign x__h1262 = offsetAddr__h987 >> specialRWALU_cap[43:38] ;
  assign x__h1413 =
	     SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d95[63:14] ^
	     signBits__h1383 ;
  assign x__h1509 = offsetAddr__h1382 >> specialRWALU_cap[43:38] ;
  assign x__h1895 = { specialRWALU_oldCap[1:0], specialRWALU_oldCap[23:10] } ;
  assign x__h2079 = { specialRWALU_cap[1:0], specialRWALU_cap[23:10] } ;
  assign x__h283 = x__h285 << specialRWALU_oldCap[43:38] ;
  assign x__h285 = { {48{offset__h271[15]}}, offset__h271 } ;
  assign x__h410 = 66'h3FFFFFFFFFFFFFFFF << specialRWALU_oldCap[43:38] ;
  assign x__h564 = offsetAddr__h129 >> specialRWALU_oldCap[43:38] ;
  assign x__h724 =
	     IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d35[63:14] ^
	     signBits__h694 ;
  assign x__h867 = offsetAddr__h693 >> specialRWALU_oldCap[43:38] ;
  assign y__h1142 = ~x__h1143 ;
  assign y__h409 = ~x__h410 ;
  assign y__h764 = ~specialRWALU_cap[159:96] ;
  always@(specialRWALU_scrType)
  begin
    case (specialRWALU_scrType[4:2])
      3'd2, 3'd3:
	  IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 =
	      specialRWALU_scrType[4:2];
      default: IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 = 3'd4;
    endcase
  end
  always@(specialRWALU_scrType or
	  oldOffset__h23 or y__h764 or specialRWALU_cap)
  begin
    case (specialRWALU_scrType[1:0])
      2'd0:
	  IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d35 =
	      specialRWALU_cap[159:96];
      2'd1:
	  IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d35 =
	      oldOffset__h23 | specialRWALU_cap[159:96];
      default: IF_specialRWALU_scrType_BITS_1_TO_0_2_EQ_0_3_T_ETC___d35 =
		   oldOffset__h23 & y__h764;
    endcase
  end
  always@(IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 or
	  specialRWALU_cap or
	  bot__h2025 or offsetAddr__h987 or offsetAddr__h1382)
  begin
    case (IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8)
      3'd2:
	  IF_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_ETC___d166 =
	      { 2'd0, bot__h2025 } + { 2'd0, offsetAddr__h987 };
      3'd3:
	  IF_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_ETC___d166 =
	      { 2'd0, bot__h2025 } + { 2'd0, offsetAddr__h1382 };
      default: IF_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_ETC___d166 =
		   specialRWALU_cap[161:96];
    endcase
  end
  always@(IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 or
	  specialRWALU_cap or
	  IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d190 or
	  IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d196)
  begin
    case (IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8)
      3'd2:
	  CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q1 =
	      IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d190;
      3'd3:
	  CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q1 =
	      IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d196;
      default: CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q1 =
		   specialRWALU_cap[95:82];
    endcase
  end
  always@(IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 or
	  specialRWALU_cap or
	  specialRWALU_cap_BITS_23_TO_21_41_ULT_specialR_ETC___d249)
  begin
    case (IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8)
      3'd2, 3'd3:
	  CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q2 =
	      specialRWALU_cap_BITS_23_TO_21_41_ULT_specialR_ETC___d249;
      default: CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q2 =
		   specialRWALU_cap[5];
    endcase
  end
  always@(IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 or
	  specialRWALU_cap or
	  IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d263 or
	  IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d275)
  begin
    case (IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8)
      3'd2:
	  CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q3 =
	      IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d263;
      3'd3:
	  CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q3 =
	      IF_specialRWALU_cap_BITS_43_TO_38_8_EQ_52_83_T_ETC___d275;
      default: CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q3 =
		   specialRWALU_cap[4:0];
    endcase
  end
  always@(IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 or
	  specialRWALU_cap or
	  SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d123 or
	  SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d137)
  begin
    case (IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8)
      3'd2:
	  CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q4 =
	      SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d123 &&
	      specialRWALU_cap[162];
      3'd3:
	  CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q4 =
	      SEXT__0_CONCAT_specialRWALU_cap_BITS_95_TO_82__ETC___d137 &&
	      specialRWALU_cap[162];
      default: CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q4 =
		   specialRWALU_cap[162];
    endcase
  end
  always@(IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 or
	  specialRWALU_cap or repBound__h2672)
  begin
    case (IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8)
      3'd2, 3'd3:
	  CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q5 =
	      repBound__h2672;
      default: CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q5 =
		   specialRWALU_cap[9:7];
    endcase
  end
  always@(IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8 or
	  specialRWALU_cap or
	  specialRWALU_cap_BITS_37_TO_35_45_ULT_specialR_ETC___d246)
  begin
    case (IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2_OR_sp_ETC___d8)
      3'd2, 3'd3:
	  CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q6 =
	      specialRWALU_cap_BITS_37_TO_35_45_ULT_specialR_ETC___d246;
      default: CASE_IF_specialRWALU_scrType_BITS_4_TO_2_EQ_2__ETC__q6 =
		   specialRWALU_cap[6];
    endcase
  end
endmodule  // module_specialRWALU

