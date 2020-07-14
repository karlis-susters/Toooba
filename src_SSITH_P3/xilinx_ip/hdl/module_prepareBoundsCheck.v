//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
// On Tue Jul 14 18:20:08 BST 2020
//
//
// Ports:
// Name                         I/O  size props
// prepareBoundsCheck             O   266
// prepareBoundsCheck_a           I   163
// prepareBoundsCheck_b           I   163
// prepareBoundsCheck_pcc         I   163
// prepareBoundsCheck_ddc         I   163
// prepareBoundsCheck_vaddr       I    64
// prepareBoundsCheck_size        I     5
// prepareBoundsCheck_toCheck     I    47
//
// Combinational paths from inputs to outputs:
//   (prepareBoundsCheck_a,
//    prepareBoundsCheck_b,
//    prepareBoundsCheck_pcc,
//    prepareBoundsCheck_ddc,
//    prepareBoundsCheck_vaddr,
//    prepareBoundsCheck_size,
//    prepareBoundsCheck_toCheck) -> prepareBoundsCheck
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

module module_prepareBoundsCheck(prepareBoundsCheck_a,
				 prepareBoundsCheck_b,
				 prepareBoundsCheck_pcc,
				 prepareBoundsCheck_ddc,
				 prepareBoundsCheck_vaddr,
				 prepareBoundsCheck_size,
				 prepareBoundsCheck_toCheck,
				 prepareBoundsCheck);
  // value method prepareBoundsCheck
  input  [162 : 0] prepareBoundsCheck_a;
  input  [162 : 0] prepareBoundsCheck_b;
  input  [162 : 0] prepareBoundsCheck_pcc;
  input  [162 : 0] prepareBoundsCheck_ddc;
  input  [63 : 0] prepareBoundsCheck_vaddr;
  input  [4 : 0] prepareBoundsCheck_size;
  input  [46 : 0] prepareBoundsCheck_toCheck;
  output [265 : 0] prepareBoundsCheck;

  // signals for module outputs
  wire [265 : 0] prepareBoundsCheck;

  // remaining internal signals
  reg [65 : 0] x__h930;
  reg [64 : 0] x__h1812;
  reg [63 : 0] x__h1621;
  reg [15 : 0] x__h697, x__h978;
  reg [13 : 0] IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d75;
  reg [5 : 0] CASE_prepareBoundsCheck_toCheck_BITS_20_TO_19__ETC__q6,
	      IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d23;
  reg [1 : 0] x__h1461;
  wire [65 : 0] IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d69,
		addTop__h1825,
		addTop__h872,
		prepareBoundsCheck_a_BITS_161_TO_110_33_AND_45_ETC___d139,
		result__h1502,
		result__h2421,
		ret__h1829,
		ret__h876,
		x__h1822,
		x__h869;
  wire [63 : 0] addBase__h1673, addBase__h350, bot__h1676, x__h180;
  wire [51 : 0] mask__h1826, mask__h873;
  wire [49 : 0] mask__h1674,
		mask__h351,
		prepareBoundsCheck_a_BITS_159_TO_110_PLUS_SEXT_ETC__q2,
		x30_BITS_63_TO_14_PLUS_SEXT_x461_SL_IF_prepare_ETC__q5;
  wire [15 : 0] prepareBoundsCheck_a_BITS_1_TO_0_CONCAT_prepar_ETC__q3,
		prepareBoundsCheck_a_BITS_3_TO_2_CONCAT_prepar_ETC__q4;
  wire [1 : 0] prepareBoundsCheck_a_BITS_1_TO_0__q1;
  wire IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d90,
       prepareBoundsCheck_a_BITS_43_TO_38_6_ULT_51_32_ETC___d152,
       x__h1053,
       x__h1973;

  // value method prepareBoundsCheck
  assign prepareBoundsCheck =
	     { prepareBoundsCheck_toCheck[21],
	       x__h180,
	       x__h869[64:0],
	       CASE_prepareBoundsCheck_toCheck_BITS_20_TO_19__ETC__q6,
	       x__h1621,
	       x__h1812,
	       prepareBoundsCheck_toCheck[12] } ;

  // remaining internal signals
  assign IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d69 =
	     { x__h930[65:14] & mask__h873, 14'd0 } + addTop__h872 ;
  assign IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d90 =
	     IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d23 <
	     6'd51 &&
	     IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d69[64:63] -
	     { 1'd0, x__h1053 } >
	     2'd1 ;
  assign addBase__h1673 =
	     { {48{prepareBoundsCheck_a_BITS_1_TO_0_CONCAT_prepar_ETC__q3[15]}},
	       prepareBoundsCheck_a_BITS_1_TO_0_CONCAT_prepar_ETC__q3 } <<
	     prepareBoundsCheck_a[43:38] ;
  assign addBase__h350 =
	     { {48{x__h697[15]}}, x__h697 } <<
	     IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d23 ;
  assign addTop__h1825 =
	     { {50{prepareBoundsCheck_a_BITS_3_TO_2_CONCAT_prepar_ETC__q4[15]}},
	       prepareBoundsCheck_a_BITS_3_TO_2_CONCAT_prepar_ETC__q4 } <<
	     prepareBoundsCheck_a[43:38] ;
  assign addTop__h872 =
	     { {50{x__h978[15]}}, x__h978 } <<
	     IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d23 ;
  assign bot__h1676 =
	     { prepareBoundsCheck_a[159:110] & mask__h1674, 14'd0 } +
	     addBase__h1673 ;
  assign mask__h1674 = 50'h3FFFFFFFFFFFF << prepareBoundsCheck_a[43:38] ;
  assign mask__h1826 = 52'hFFFFFFFFFFFFF << prepareBoundsCheck_a[43:38] ;
  assign mask__h351 =
	     50'h3FFFFFFFFFFFF <<
	     IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d23 ;
  assign mask__h873 =
	     52'hFFFFFFFFFFFFF <<
	     IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d23 ;
  assign prepareBoundsCheck_a_BITS_159_TO_110_PLUS_SEXT_ETC__q2 =
	     prepareBoundsCheck_a[159:110] +
	     ({ {48{prepareBoundsCheck_a_BITS_1_TO_0__q1[1]}},
		prepareBoundsCheck_a_BITS_1_TO_0__q1 } <<
	      prepareBoundsCheck_a[43:38]) ;
  assign prepareBoundsCheck_a_BITS_161_TO_110_33_AND_45_ETC___d139 =
	     { prepareBoundsCheck_a[161:110] & mask__h1826, 14'd0 } +
	     addTop__h1825 ;
  assign prepareBoundsCheck_a_BITS_1_TO_0_CONCAT_prepar_ETC__q3 =
	     { prepareBoundsCheck_a[1:0], prepareBoundsCheck_a[23:10] } ;
  assign prepareBoundsCheck_a_BITS_1_TO_0__q1 = prepareBoundsCheck_a[1:0] ;
  assign prepareBoundsCheck_a_BITS_3_TO_2_CONCAT_prepar_ETC__q4 =
	     { prepareBoundsCheck_a[3:2], prepareBoundsCheck_a[37:24] } ;
  assign prepareBoundsCheck_a_BITS_43_TO_38_6_ULT_51_32_ETC___d152 =
	     prepareBoundsCheck_a[43:38] < 6'd51 &&
	     prepareBoundsCheck_a_BITS_161_TO_110_33_AND_45_ETC___d139[64:63] -
	     { 1'd0, x__h1973 } >
	     2'd1 ;
  assign result__h1502 =
	     { 1'd0,
	       ~IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d69[64],
	       IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d69[63:0] } ;
  assign result__h2421 =
	     { 1'd0,
	       ~prepareBoundsCheck_a_BITS_161_TO_110_33_AND_45_ETC___d139[64],
	       prepareBoundsCheck_a_BITS_161_TO_110_33_AND_45_ETC___d139[63:0] } ;
  assign ret__h1829 =
	     { 1'd0,
	       prepareBoundsCheck_a_BITS_161_TO_110_33_AND_45_ETC___d139[64:0] } ;
  assign ret__h876 =
	     { 1'd0,
	       IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d69[64:0] } ;
  assign x30_BITS_63_TO_14_PLUS_SEXT_x461_SL_IF_prepare_ETC__q5 =
	     x__h930[63:14] +
	     ({ {48{x__h1461[1]}}, x__h1461 } <<
	      IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d23) ;
  assign x__h1053 =
	     (IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d23 ==
	      6'd50) ?
	       IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d75[13] :
	       x30_BITS_63_TO_14_PLUS_SEXT_x461_SL_IF_prepare_ETC__q5[49] ;
  assign x__h180 = { x__h930[63:14] & mask__h351, 14'd0 } + addBase__h350 ;
  assign x__h1822 =
	     prepareBoundsCheck_a_BITS_43_TO_38_6_ULT_51_32_ETC___d152 ?
	       result__h2421 :
	       ret__h1829 ;
  assign x__h1973 =
	     (prepareBoundsCheck_a[43:38] == 6'd50) ?
	       prepareBoundsCheck_a[23] :
	       prepareBoundsCheck_a_BITS_159_TO_110_PLUS_SEXT_ETC__q2[49] ;
  assign x__h869 =
	     IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d90 ?
	       result__h1502 :
	       ret__h876 ;
  always@(prepareBoundsCheck_toCheck or
	  prepareBoundsCheck_ddc or
	  prepareBoundsCheck_a or
	  prepareBoundsCheck_b or prepareBoundsCheck_pcc)
  begin
    case (prepareBoundsCheck_toCheck[20:19])
      2'd0: x__h930 = prepareBoundsCheck_a[161:96];
      2'd1: x__h930 = prepareBoundsCheck_b[161:96];
      2'd2: x__h930 = prepareBoundsCheck_pcc[161:96];
      2'd3: x__h930 = prepareBoundsCheck_ddc[161:96];
    endcase
  end
  always@(prepareBoundsCheck_toCheck or
	  prepareBoundsCheck_vaddr or
	  prepareBoundsCheck_a or bot__h1676 or prepareBoundsCheck_b)
  begin
    case (prepareBoundsCheck_toCheck[18:16])
      3'd0: x__h1621 = prepareBoundsCheck_a[159:96];
      3'd1: x__h1621 = bot__h1676;
      3'd2: x__h1621 = { 46'd0, prepareBoundsCheck_a[62:45] };
      3'd3: x__h1621 = prepareBoundsCheck_b[159:96];
      default: x__h1621 = prepareBoundsCheck_vaddr;
    endcase
  end
  always@(prepareBoundsCheck_toCheck or
	  prepareBoundsCheck_ddc or
	  prepareBoundsCheck_a or
	  prepareBoundsCheck_b or prepareBoundsCheck_pcc)
  begin
    case (prepareBoundsCheck_toCheck[20:19])
      2'd0:
	  x__h697 =
	      { prepareBoundsCheck_a[1:0], prepareBoundsCheck_a[23:10] };
      2'd1:
	  x__h697 =
	      { prepareBoundsCheck_b[1:0], prepareBoundsCheck_b[23:10] };
      2'd2:
	  x__h697 =
	      { prepareBoundsCheck_pcc[1:0], prepareBoundsCheck_pcc[23:10] };
      2'd3:
	  x__h697 =
	      { prepareBoundsCheck_ddc[1:0], prepareBoundsCheck_ddc[23:10] };
    endcase
  end
  always@(prepareBoundsCheck_toCheck or
	  prepareBoundsCheck_ddc or
	  prepareBoundsCheck_a or
	  prepareBoundsCheck_b or prepareBoundsCheck_pcc)
  begin
    case (prepareBoundsCheck_toCheck[20:19])
      2'd0:
	  x__h978 =
	      { prepareBoundsCheck_a[3:2], prepareBoundsCheck_a[37:24] };
      2'd1:
	  x__h978 =
	      { prepareBoundsCheck_b[3:2], prepareBoundsCheck_b[37:24] };
      2'd2:
	  x__h978 =
	      { prepareBoundsCheck_pcc[3:2], prepareBoundsCheck_pcc[37:24] };
      2'd3:
	  x__h978 =
	      { prepareBoundsCheck_ddc[3:2], prepareBoundsCheck_ddc[37:24] };
    endcase
  end
  always@(prepareBoundsCheck_toCheck or
	  prepareBoundsCheck_ddc or
	  prepareBoundsCheck_a or
	  prepareBoundsCheck_b or prepareBoundsCheck_pcc)
  begin
    case (prepareBoundsCheck_toCheck[20:19])
      2'd0: x__h1461 = prepareBoundsCheck_a[1:0];
      2'd1: x__h1461 = prepareBoundsCheck_b[1:0];
      2'd2: x__h1461 = prepareBoundsCheck_pcc[1:0];
      2'd3: x__h1461 = prepareBoundsCheck_ddc[1:0];
    endcase
  end
  always@(prepareBoundsCheck_toCheck or
	  prepareBoundsCheck_ddc or
	  prepareBoundsCheck_a or
	  prepareBoundsCheck_b or prepareBoundsCheck_pcc)
  begin
    case (prepareBoundsCheck_toCheck[20:19])
      2'd0:
	  IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d23 =
	      prepareBoundsCheck_a[43:38];
      2'd1:
	  IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d23 =
	      prepareBoundsCheck_b[43:38];
      2'd2:
	  IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d23 =
	      prepareBoundsCheck_pcc[43:38];
      2'd3:
	  IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d23 =
	      prepareBoundsCheck_ddc[43:38];
    endcase
  end
  always@(prepareBoundsCheck_toCheck or
	  prepareBoundsCheck_ddc or
	  prepareBoundsCheck_a or
	  prepareBoundsCheck_b or prepareBoundsCheck_pcc)
  begin
    case (prepareBoundsCheck_toCheck[20:19])
      2'd0:
	  IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d75 =
	      prepareBoundsCheck_a[23:10];
      2'd1:
	  IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d75 =
	      prepareBoundsCheck_b[23:10];
      2'd2:
	  IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d75 =
	      prepareBoundsCheck_pcc[23:10];
      2'd3:
	  IF_prepareBoundsCheck_toCheck_BITS_20_TO_19_EQ_ETC___d75 =
	      prepareBoundsCheck_ddc[23:10];
    endcase
  end
  always@(prepareBoundsCheck_toCheck or
	  prepareBoundsCheck_vaddr or
	  prepareBoundsCheck_size or
	  prepareBoundsCheck_a or x__h1822 or prepareBoundsCheck_b)
  begin
    case (prepareBoundsCheck_toCheck[15:13])
      3'd0: x__h1812 = { 1'b0, prepareBoundsCheck_a[159:96] + 64'd2 };
      3'd1: x__h1812 = x__h1822[64:0];
      3'd2: x__h1812 = { 47'd0, prepareBoundsCheck_a[62:45] };
      3'd3: x__h1812 = { 1'b0, prepareBoundsCheck_b[159:96] };
      3'd4:
	  x__h1812 =
	      { 1'b0, prepareBoundsCheck_a[159:96] } +
	      { 1'b0, prepareBoundsCheck_b[159:96] };
      default: x__h1812 =
		   { 1'b0, prepareBoundsCheck_vaddr } +
		   { 60'd0, prepareBoundsCheck_size };
    endcase
  end
  always@(prepareBoundsCheck_toCheck)
  begin
    case (prepareBoundsCheck_toCheck[20:19])
      2'd0:
	  CASE_prepareBoundsCheck_toCheck_BITS_20_TO_19__ETC__q6 =
	      prepareBoundsCheck_toCheck[11:6];
      2'd1:
	  CASE_prepareBoundsCheck_toCheck_BITS_20_TO_19__ETC__q6 =
	      prepareBoundsCheck_toCheck[5:0];
      2'd2: CASE_prepareBoundsCheck_toCheck_BITS_20_TO_19__ETC__q6 = 6'd32;
      2'd3: CASE_prepareBoundsCheck_toCheck_BITS_20_TO_19__ETC__q6 = 6'd33;
    endcase
  end
endmodule  // module_prepareBoundsCheck

