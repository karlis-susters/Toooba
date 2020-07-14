//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
// On Tue Jul 14 18:30:16 BST 2020
//
//
// Ports:
// Name                         I/O  size props
// RDY_enq                        O     1
// RDY_deq                        O     1 reg
// first                          O   969
// RDY_first                      O     1 reg
// RDY_specUpdate_incorrectSpeculation  O     1 const
// RDY_specUpdate_correctSpeculation  O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// enq_x                          I   969
// specUpdate_incorrectSpeculation_kill_all  I     1
// specUpdate_incorrectSpeculation_kill_tag  I     4
// specUpdate_correctSpeculation_mask  I    12
// EN_enq                         I     1
// EN_deq                         I     1
// EN_specUpdate_incorrectSpeculation  I     1
// EN_specUpdate_correctSpeculation  I     1
//
// Combinational paths from inputs to outputs:
//   EN_deq -> RDY_enq
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

module mkAluExeToFinFifo(CLK,
			 RST_N,

			 enq_x,
			 EN_enq,
			 RDY_enq,

			 EN_deq,
			 RDY_deq,

			 first,
			 RDY_first,

			 specUpdate_incorrectSpeculation_kill_all,
			 specUpdate_incorrectSpeculation_kill_tag,
			 EN_specUpdate_incorrectSpeculation,
			 RDY_specUpdate_incorrectSpeculation,

			 specUpdate_correctSpeculation_mask,
			 EN_specUpdate_correctSpeculation,
			 RDY_specUpdate_correctSpeculation);
  input  CLK;
  input  RST_N;

  // action method enq
  input  [968 : 0] enq_x;
  input  EN_enq;
  output RDY_enq;

  // action method deq
  input  EN_deq;
  output RDY_deq;

  // value method first
  output [968 : 0] first;
  output RDY_first;

  // action method specUpdate_incorrectSpeculation
  input  specUpdate_incorrectSpeculation_kill_all;
  input  [3 : 0] specUpdate_incorrectSpeculation_kill_tag;
  input  EN_specUpdate_incorrectSpeculation;
  output RDY_specUpdate_incorrectSpeculation;

  // action method specUpdate_correctSpeculation
  input  [11 : 0] specUpdate_correctSpeculation_mask;
  input  EN_specUpdate_correctSpeculation;
  output RDY_specUpdate_correctSpeculation;

  // signals for module outputs
  wire [968 : 0] first;
  wire RDY_deq,
       RDY_enq,
       RDY_first,
       RDY_specUpdate_correctSpeculation,
       RDY_specUpdate_incorrectSpeculation;

  // inlined wires
  wire [11 : 0] m_m_specBits_0_lat_1$wget;
  wire m_m_valid_0_lat_1$whas;

  // register m_m_row_0
  reg [956 : 0] m_m_row_0;
  wire [956 : 0] m_m_row_0$D_IN;
  wire m_m_row_0$EN;

  // register m_m_specBits_0_rl
  reg [11 : 0] m_m_specBits_0_rl;
  wire [11 : 0] m_m_specBits_0_rl$D_IN;
  wire m_m_specBits_0_rl$EN;

  // register m_m_valid_0_rl
  reg m_m_valid_0_rl;
  wire m_m_valid_0_rl$D_IN, m_m_valid_0_rl$EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_m_m_specBits_0_canon,
       CAN_FIRE_RL_m_m_valid_0_canon,
       CAN_FIRE_deq,
       CAN_FIRE_enq,
       CAN_FIRE_specUpdate_correctSpeculation,
       CAN_FIRE_specUpdate_incorrectSpeculation,
       WILL_FIRE_RL_m_m_specBits_0_canon,
       WILL_FIRE_RL_m_m_valid_0_canon,
       WILL_FIRE_deq,
       WILL_FIRE_enq,
       WILL_FIRE_specUpdate_correctSpeculation,
       WILL_FIRE_specUpdate_incorrectSpeculation;

  // inputs to muxes for submodule ports
  wire MUX_m_m_valid_0_lat_1$wset_1__SEL_1;

  // remaining internal signals
  reg [4 : 0] CASE_enq_x_BITS_287_TO_283_0_enq_x_BITS_287_TO_ETC__q4,
	      CASE_m_m_row_0_BITS_275_TO_271_0_m_m_row_0_BIT_ETC__q2;
  reg [1 : 0] CASE_enq_x_BITS_754_TO_753_0_enq_x_BITS_754_TO_ETC__q3,
	      CASE_m_m_row_0_BITS_742_TO_741_0_m_m_row_0_BIT_ETC__q1;
  wire [11 : 0] sb__h5898, upd__h1154;
  wire _dand1m_m_valid_0_lat_1$EN_wset;

  // action method enq
  assign RDY_enq = EN_deq || !m_m_valid_0_rl ;
  assign CAN_FIRE_enq = EN_deq || !m_m_valid_0_rl ;
  assign WILL_FIRE_enq = EN_enq ;

  // action method deq
  assign RDY_deq = m_m_valid_0_rl ;
  assign CAN_FIRE_deq = m_m_valid_0_rl ;
  assign WILL_FIRE_deq = EN_deq ;

  // value method first
  assign first =
	     { m_m_row_0[956:743],
	       CASE_m_m_row_0_BITS_742_TO_741_0_m_m_row_0_BIT_ETC__q1,
	       m_m_row_0[740:276],
	       CASE_m_m_row_0_BITS_275_TO_271_0_m_m_row_0_BIT_ETC__q2,
	       m_m_row_0[270:0],
	       m_m_specBits_0_rl } ;
  assign RDY_first = m_m_valid_0_rl ;

  // action method specUpdate_incorrectSpeculation
  assign RDY_specUpdate_incorrectSpeculation = 1'd1 ;
  assign CAN_FIRE_specUpdate_incorrectSpeculation = 1'd1 ;
  assign WILL_FIRE_specUpdate_incorrectSpeculation =
	     EN_specUpdate_incorrectSpeculation ;

  // action method specUpdate_correctSpeculation
  assign RDY_specUpdate_correctSpeculation = 1'd1 ;
  assign CAN_FIRE_specUpdate_correctSpeculation = 1'd1 ;
  assign WILL_FIRE_specUpdate_correctSpeculation =
	     EN_specUpdate_correctSpeculation ;

  // rule RL_m_m_valid_0_canon
  assign CAN_FIRE_RL_m_m_valid_0_canon = 1'd1 ;
  assign WILL_FIRE_RL_m_m_valid_0_canon = 1'd1 ;

  // rule RL_m_m_specBits_0_canon
  assign CAN_FIRE_RL_m_m_specBits_0_canon = 1'd1 ;
  assign WILL_FIRE_RL_m_m_specBits_0_canon = 1'd1 ;

  // inputs to muxes for submodule ports
  assign MUX_m_m_valid_0_lat_1$wset_1__SEL_1 =
	     EN_specUpdate_incorrectSpeculation &&
	     (specUpdate_incorrectSpeculation_kill_all ||
	      m_m_specBits_0_rl[specUpdate_incorrectSpeculation_kill_tag]) ;

  // inlined wires
  assign m_m_valid_0_lat_1$whas = _dand1m_m_valid_0_lat_1$EN_wset || EN_enq ;
  assign m_m_specBits_0_lat_1$wget =
	     sb__h5898 & specUpdate_correctSpeculation_mask ;

  // register m_m_row_0
  assign m_m_row_0$D_IN =
	     { enq_x[968:755],
	       CASE_enq_x_BITS_754_TO_753_0_enq_x_BITS_754_TO_ETC__q3,
	       enq_x[752:288],
	       CASE_enq_x_BITS_287_TO_283_0_enq_x_BITS_287_TO_ETC__q4,
	       enq_x[282:12] } ;
  assign m_m_row_0$EN = EN_enq ;

  // register m_m_specBits_0_rl
  assign m_m_specBits_0_rl$D_IN =
	     EN_specUpdate_correctSpeculation ? upd__h1154 : sb__h5898 ;
  assign m_m_specBits_0_rl$EN = 1'd1 ;

  // register m_m_valid_0_rl
  assign m_m_valid_0_rl$D_IN =
	     m_m_valid_0_lat_1$whas ?
	       !MUX_m_m_valid_0_lat_1$wset_1__SEL_1 :
	       !EN_deq && m_m_valid_0_rl ;
  assign m_m_valid_0_rl$EN = 1'd1 ;

  // remaining internal signals
  assign _dand1m_m_valid_0_lat_1$EN_wset =
	     EN_specUpdate_incorrectSpeculation &&
	     (specUpdate_incorrectSpeculation_kill_all ||
	      m_m_specBits_0_rl[specUpdate_incorrectSpeculation_kill_tag]) ;
  assign sb__h5898 = EN_enq ? enq_x[11:0] : m_m_specBits_0_rl ;
  assign upd__h1154 = m_m_specBits_0_lat_1$wget ;
  always@(m_m_row_0)
  begin
    case (m_m_row_0[742:741])
      2'd0, 2'd1:
	  CASE_m_m_row_0_BITS_742_TO_741_0_m_m_row_0_BIT_ETC__q1 =
	      m_m_row_0[742:741];
      default: CASE_m_m_row_0_BITS_742_TO_741_0_m_m_row_0_BIT_ETC__q1 = 2'd2;
    endcase
  end
  always@(m_m_row_0)
  begin
    case (m_m_row_0[275:271])
      5'd0,
      5'd1,
      5'd2,
      5'd3,
      5'd4,
      5'd5,
      5'd6,
      5'd7,
      5'd8,
      5'd9,
      5'd10,
      5'd11,
      5'd16,
      5'd17,
      5'd18,
      5'd19,
      5'd20,
      5'd21,
      5'd22,
      5'd23,
      5'd24,
      5'd25,
      5'd26:
	  CASE_m_m_row_0_BITS_275_TO_271_0_m_m_row_0_BIT_ETC__q2 =
	      m_m_row_0[275:271];
      default: CASE_m_m_row_0_BITS_275_TO_271_0_m_m_row_0_BIT_ETC__q2 = 5'd27;
    endcase
  end
  always@(enq_x)
  begin
    case (enq_x[754:753])
      2'd0, 2'd1:
	  CASE_enq_x_BITS_754_TO_753_0_enq_x_BITS_754_TO_ETC__q3 =
	      enq_x[754:753];
      default: CASE_enq_x_BITS_754_TO_753_0_enq_x_BITS_754_TO_ETC__q3 = 2'd2;
    endcase
  end
  always@(enq_x)
  begin
    case (enq_x[287:283])
      5'd0,
      5'd1,
      5'd2,
      5'd3,
      5'd4,
      5'd5,
      5'd6,
      5'd7,
      5'd8,
      5'd9,
      5'd10,
      5'd11,
      5'd16,
      5'd17,
      5'd18,
      5'd19,
      5'd20,
      5'd21,
      5'd22,
      5'd23,
      5'd24,
      5'd25,
      5'd26:
	  CASE_enq_x_BITS_287_TO_283_0_enq_x_BITS_287_TO_ETC__q4 =
	      enq_x[287:283];
      default: CASE_enq_x_BITS_287_TO_283_0_enq_x_BITS_287_TO_ETC__q4 = 5'd27;
    endcase
  end

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        m_m_specBits_0_rl <= `BSV_ASSIGNMENT_DELAY
	    12'bxxxxxxxxxxxx /* unspecified value */ ;
	m_m_valid_0_rl <= `BSV_ASSIGNMENT_DELAY 1'd0;
      end
    else
      begin
        if (m_m_specBits_0_rl$EN)
	  m_m_specBits_0_rl <= `BSV_ASSIGNMENT_DELAY m_m_specBits_0_rl$D_IN;
	if (m_m_valid_0_rl$EN)
	  m_m_valid_0_rl <= `BSV_ASSIGNMENT_DELAY m_m_valid_0_rl$D_IN;
      end
    if (m_m_row_0$EN) m_m_row_0 <= `BSV_ASSIGNMENT_DELAY m_m_row_0$D_IN;
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    m_m_row_0 =
	957'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    m_m_specBits_0_rl = 12'hAAA;
    m_m_valid_0_rl = 1'h0;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkAluExeToFinFifo

