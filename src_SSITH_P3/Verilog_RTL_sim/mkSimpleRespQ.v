//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
// On Sat Jun  6 22:39:24 BST 2020
//
//
// Ports:
// Name                         I/O  size props
// RDY_enq                        O     1
// RDY_deq                        O     1
// first                          O   102
// RDY_first                      O     1
// RDY_specUpdate_incorrectSpeculation  O     1 const
// RDY_specUpdate_correctSpeculation  O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// enq_x                          I   102
// specUpdate_incorrectSpeculation_kill_all  I     1
// specUpdate_incorrectSpeculation_kill_tag  I     4
// specUpdate_correctSpeculation_mask  I    12
// EN_enq                         I     1
// EN_deq                         I     1
// EN_specUpdate_incorrectSpeculation  I     1
// EN_specUpdate_correctSpeculation  I     1
//
// No combinational paths from inputs to outputs
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

module mkSimpleRespQ(CLK,
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
  input  [101 : 0] enq_x;
  input  EN_enq;
  output RDY_enq;

  // action method deq
  input  EN_deq;
  output RDY_deq;

  // value method first
  output [101 : 0] first;
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
  reg RDY_deq;
  wire [101 : 0] first;
  wire RDY_enq,
       RDY_first,
       RDY_specUpdate_correctSpeculation,
       RDY_specUpdate_incorrectSpeculation;

  // inlined wires
  reg m_m_valid_for_enq_wire$wget;
  wire m_m_deqP_ehr_lat_0$whas,
       m_m_empty_for_enq_wire$wget,
       m_m_valid_0_lat_0$whas,
       m_m_valid_0_lat_1$whas,
       m_m_valid_1_lat_0$whas,
       m_m_valid_1_lat_1$whas;

  // register m_m_deqP_ehr_rl
  reg m_m_deqP_ehr_rl;
  wire m_m_deqP_ehr_rl$D_IN, m_m_deqP_ehr_rl$EN;

  // register m_m_enqP
  reg m_m_enqP;
  wire m_m_enqP$D_IN, m_m_enqP$EN;

  // register m_m_row_0
  reg [89 : 0] m_m_row_0;
  wire [89 : 0] m_m_row_0$D_IN;
  wire m_m_row_0$EN;

  // register m_m_row_1
  reg [89 : 0] m_m_row_1;
  wire [89 : 0] m_m_row_1$D_IN;
  wire m_m_row_1$EN;

  // register m_m_specBits_0_rl
  reg [11 : 0] m_m_specBits_0_rl;
  wire [11 : 0] m_m_specBits_0_rl$D_IN;
  wire m_m_specBits_0_rl$EN;

  // register m_m_specBits_1_rl
  reg [11 : 0] m_m_specBits_1_rl;
  wire [11 : 0] m_m_specBits_1_rl$D_IN;
  wire m_m_specBits_1_rl$EN;

  // register m_m_valid_0_rl
  reg m_m_valid_0_rl;
  wire m_m_valid_0_rl$D_IN, m_m_valid_0_rl$EN;

  // register m_m_valid_1_rl
  reg m_m_valid_1_rl;
  wire m_m_valid_1_rl$D_IN, m_m_valid_1_rl$EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_m_m_canon_deqP,
       CAN_FIRE_RL_m_m_deqP_ehr_canon,
       CAN_FIRE_RL_m_m_setWireForEnq,
       CAN_FIRE_RL_m_m_specBits_0_canon,
       CAN_FIRE_RL_m_m_specBits_1_canon,
       CAN_FIRE_RL_m_m_valid_0_canon,
       CAN_FIRE_RL_m_m_valid_1_canon,
       CAN_FIRE_deq,
       CAN_FIRE_enq,
       CAN_FIRE_specUpdate_correctSpeculation,
       CAN_FIRE_specUpdate_incorrectSpeculation,
       WILL_FIRE_RL_m_m_canon_deqP,
       WILL_FIRE_RL_m_m_deqP_ehr_canon,
       WILL_FIRE_RL_m_m_setWireForEnq,
       WILL_FIRE_RL_m_m_specBits_0_canon,
       WILL_FIRE_RL_m_m_specBits_1_canon,
       WILL_FIRE_RL_m_m_valid_0_canon,
       WILL_FIRE_RL_m_m_valid_1_canon,
       WILL_FIRE_deq,
       WILL_FIRE_enq,
       WILL_FIRE_specUpdate_correctSpeculation,
       WILL_FIRE_specUpdate_incorrectSpeculation;

  // inputs to muxes for submodule ports
  wire MUX_m_m_valid_0_lat_0$wset_1__SEL_2,
       MUX_m_m_valid_1_lat_0$wset_1__SEL_2;

  // remaining internal signals
  reg [63 : 0] CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_89_TO_26_ETC__q8;
  reg [11 : 0] CASE_m_m_deqP_ehr_rl_0_m_m_specBits_0_rl_1_m_m_ETC__q10;
  reg [6 : 0] CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_19_TO_13_ETC__q3;
  reg [5 : 0] CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_5_TO_0_1_ETC__q7;
  reg [4 : 0] CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_10_TO_6__ETC__q6,
	      CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_25_TO_21_ETC__q9;
  reg CASE_m_m_deqP_ehr_rl_0_NOT_m_m_row_0_BIT_20_1__ETC__q2,
      CASE_m_m_deqP_ehr_rl_0_NOT_m_m_valid_0_rl_1_NO_ETC__q1,
      CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BIT_11_1_m_m__ETC__q5,
      CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BIT_12_1_m_m__ETC__q4;
  wire [20 : 0] NOT_SEL_ARR_NOT_m_m_row_0_3_BIT_20_4_5_NOT_m_m_ETC___d114;
  wire [11 : 0] sb__h5525, sb__h5641, upd__h1621, upd__h1966;
  wire upd__h2497;

  // action method enq
  assign RDY_enq =
	     m_m_empty_for_enq_wire$wget || m_m_enqP != m_m_deqP_ehr_rl ;
  assign CAN_FIRE_enq =
	     m_m_empty_for_enq_wire$wget || m_m_enqP != m_m_deqP_ehr_rl ;
  assign WILL_FIRE_enq = EN_enq ;

  // action method deq
  always@(m_m_deqP_ehr_rl or m_m_valid_0_rl or m_m_valid_1_rl)
  begin
    case (m_m_deqP_ehr_rl)
      1'd0: RDY_deq = m_m_valid_0_rl;
      1'd1: RDY_deq = m_m_valid_1_rl;
    endcase
  end
  assign CAN_FIRE_deq = RDY_deq ;
  assign WILL_FIRE_deq = EN_deq ;

  // value method first
  assign first =
	     { CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_89_TO_26_ETC__q8,
	       CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_25_TO_21_ETC__q9,
	       NOT_SEL_ARR_NOT_m_m_row_0_3_BIT_20_4_5_NOT_m_m_ETC___d114,
	       CASE_m_m_deqP_ehr_rl_0_m_m_specBits_0_rl_1_m_m_ETC__q10 } ;
  assign RDY_first = RDY_deq ;

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

  // rule RL_m_m_canon_deqP
  assign CAN_FIRE_RL_m_m_canon_deqP =
	     CASE_m_m_deqP_ehr_rl_0_NOT_m_m_valid_0_rl_1_NO_ETC__q1 &&
	     (m_m_enqP != m_m_deqP_ehr_rl || m_m_valid_0_rl ||
	      m_m_valid_1_rl) ;
  assign WILL_FIRE_RL_m_m_canon_deqP =
	     CAN_FIRE_RL_m_m_canon_deqP &&
	     !EN_specUpdate_incorrectSpeculation ;

  // rule RL_m_m_setWireForEnq
  assign CAN_FIRE_RL_m_m_setWireForEnq = 1'd1 ;
  assign WILL_FIRE_RL_m_m_setWireForEnq = 1'd1 ;

  // rule RL_m_m_valid_0_canon
  assign CAN_FIRE_RL_m_m_valid_0_canon = 1'd1 ;
  assign WILL_FIRE_RL_m_m_valid_0_canon = 1'd1 ;

  // rule RL_m_m_valid_1_canon
  assign CAN_FIRE_RL_m_m_valid_1_canon = 1'd1 ;
  assign WILL_FIRE_RL_m_m_valid_1_canon = 1'd1 ;

  // rule RL_m_m_specBits_0_canon
  assign CAN_FIRE_RL_m_m_specBits_0_canon = 1'd1 ;
  assign WILL_FIRE_RL_m_m_specBits_0_canon = 1'd1 ;

  // rule RL_m_m_specBits_1_canon
  assign CAN_FIRE_RL_m_m_specBits_1_canon = 1'd1 ;
  assign WILL_FIRE_RL_m_m_specBits_1_canon = 1'd1 ;

  // rule RL_m_m_deqP_ehr_canon
  assign CAN_FIRE_RL_m_m_deqP_ehr_canon = 1'd1 ;
  assign WILL_FIRE_RL_m_m_deqP_ehr_canon = 1'd1 ;

  // inputs to muxes for submodule ports
  assign MUX_m_m_valid_0_lat_0$wset_1__SEL_2 =
	     EN_specUpdate_incorrectSpeculation &&
	     (specUpdate_incorrectSpeculation_kill_all ||
	      m_m_specBits_0_rl[specUpdate_incorrectSpeculation_kill_tag]) ;
  assign MUX_m_m_valid_1_lat_0$wset_1__SEL_2 =
	     EN_specUpdate_incorrectSpeculation &&
	     (specUpdate_incorrectSpeculation_kill_all ||
	      m_m_specBits_1_rl[specUpdate_incorrectSpeculation_kill_tag]) ;

  // inlined wires
  assign m_m_valid_0_lat_0$whas =
	     EN_deq && m_m_deqP_ehr_rl == 1'd0 ||
	     MUX_m_m_valid_0_lat_0$wset_1__SEL_2 ;
  assign m_m_valid_0_lat_1$whas = EN_enq && m_m_enqP == 1'd0 ;
  assign m_m_valid_1_lat_0$whas =
	     EN_deq && m_m_deqP_ehr_rl == 1'd1 ||
	     MUX_m_m_valid_1_lat_0$wset_1__SEL_2 ;
  assign m_m_valid_1_lat_1$whas = EN_enq && m_m_enqP == 1'd1 ;
  assign m_m_deqP_ehr_lat_0$whas = WILL_FIRE_RL_m_m_canon_deqP || EN_deq ;
  assign m_m_empty_for_enq_wire$wget = !m_m_valid_0_rl && !m_m_valid_1_rl ;
  always@(m_m_enqP or m_m_valid_0_rl or m_m_valid_1_rl)
  begin
    case (m_m_enqP)
      1'd0: m_m_valid_for_enq_wire$wget = m_m_valid_0_rl;
      1'd1: m_m_valid_for_enq_wire$wget = m_m_valid_1_rl;
    endcase
  end

  // register m_m_deqP_ehr_rl
  assign m_m_deqP_ehr_rl$D_IN =
	     m_m_deqP_ehr_lat_0$whas ? upd__h2497 : m_m_deqP_ehr_rl ;
  assign m_m_deqP_ehr_rl$EN = 1'd1 ;

  // register m_m_enqP
  assign m_m_enqP$D_IN = m_m_enqP + 1'd1 ;
  assign m_m_enqP$EN = EN_enq ;

  // register m_m_row_0
  assign m_m_row_0$D_IN = enq_x[101:12] ;
  assign m_m_row_0$EN = m_m_valid_0_lat_1$whas ;

  // register m_m_row_1
  assign m_m_row_1$D_IN = enq_x[101:12] ;
  assign m_m_row_1$EN = m_m_valid_1_lat_1$whas ;

  // register m_m_specBits_0_rl
  assign m_m_specBits_0_rl$D_IN =
	     EN_specUpdate_correctSpeculation ? upd__h1621 : sb__h5525 ;
  assign m_m_specBits_0_rl$EN = 1'd1 ;

  // register m_m_specBits_1_rl
  assign m_m_specBits_1_rl$D_IN =
	     EN_specUpdate_correctSpeculation ? upd__h1966 : sb__h5641 ;
  assign m_m_specBits_1_rl$EN = 1'd1 ;

  // register m_m_valid_0_rl
  assign m_m_valid_0_rl$D_IN =
	     m_m_valid_0_lat_1$whas ||
	     (m_m_valid_0_lat_0$whas ? 1'd0 : m_m_valid_0_rl) ;
  assign m_m_valid_0_rl$EN = 1'd1 ;

  // register m_m_valid_1_rl
  assign m_m_valid_1_rl$D_IN =
	     m_m_valid_1_lat_1$whas ||
	     (m_m_valid_1_lat_0$whas ? 1'd0 : m_m_valid_1_rl) ;
  assign m_m_valid_1_rl$EN = 1'd1 ;

  // remaining internal signals
  assign NOT_SEL_ARR_NOT_m_m_row_0_3_BIT_20_4_5_NOT_m_m_ETC___d114 =
	     { !CASE_m_m_deqP_ehr_rl_0_NOT_m_m_row_0_BIT_20_1__ETC__q2,
	       CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_19_TO_13_ETC__q3,
	       CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BIT_12_1_m_m__ETC__q4,
	       CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BIT_11_1_m_m__ETC__q5,
	       CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_10_TO_6__ETC__q6,
	       CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_5_TO_0_1_ETC__q7 } ;
  assign sb__h5525 =
	     m_m_valid_0_lat_1$whas ? enq_x[11:0] : m_m_specBits_0_rl ;
  assign sb__h5641 =
	     m_m_valid_1_lat_1$whas ? enq_x[11:0] : m_m_specBits_1_rl ;
  assign upd__h1621 = sb__h5525 & specUpdate_correctSpeculation_mask ;
  assign upd__h1966 = sb__h5641 & specUpdate_correctSpeculation_mask ;
  assign upd__h2497 = m_m_deqP_ehr_rl + 1'd1 ;
  always@(m_m_deqP_ehr_rl or m_m_valid_0_rl or m_m_valid_1_rl)
  begin
    case (m_m_deqP_ehr_rl)
      1'd0:
	  CASE_m_m_deqP_ehr_rl_0_NOT_m_m_valid_0_rl_1_NO_ETC__q1 =
	      !m_m_valid_0_rl;
      1'd1:
	  CASE_m_m_deqP_ehr_rl_0_NOT_m_m_valid_0_rl_1_NO_ETC__q1 =
	      !m_m_valid_1_rl;
    endcase
  end
  always@(m_m_deqP_ehr_rl or m_m_row_0 or m_m_row_1)
  begin
    case (m_m_deqP_ehr_rl)
      1'd0:
	  CASE_m_m_deqP_ehr_rl_0_NOT_m_m_row_0_BIT_20_1__ETC__q2 =
	      !m_m_row_0[20];
      1'd1:
	  CASE_m_m_deqP_ehr_rl_0_NOT_m_m_row_0_BIT_20_1__ETC__q2 =
	      !m_m_row_1[20];
    endcase
  end
  always@(m_m_deqP_ehr_rl or m_m_row_0 or m_m_row_1)
  begin
    case (m_m_deqP_ehr_rl)
      1'd0:
	  CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_19_TO_13_ETC__q3 =
	      m_m_row_0[19:13];
      1'd1:
	  CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_19_TO_13_ETC__q3 =
	      m_m_row_1[19:13];
    endcase
  end
  always@(m_m_deqP_ehr_rl or m_m_row_0 or m_m_row_1)
  begin
    case (m_m_deqP_ehr_rl)
      1'd0:
	  CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BIT_12_1_m_m__ETC__q4 =
	      m_m_row_0[12];
      1'd1:
	  CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BIT_12_1_m_m__ETC__q4 =
	      m_m_row_1[12];
    endcase
  end
  always@(m_m_deqP_ehr_rl or m_m_row_0 or m_m_row_1)
  begin
    case (m_m_deqP_ehr_rl)
      1'd0:
	  CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BIT_11_1_m_m__ETC__q5 =
	      m_m_row_0[11];
      1'd1:
	  CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BIT_11_1_m_m__ETC__q5 =
	      m_m_row_1[11];
    endcase
  end
  always@(m_m_deqP_ehr_rl or m_m_row_0 or m_m_row_1)
  begin
    case (m_m_deqP_ehr_rl)
      1'd0:
	  CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_10_TO_6__ETC__q6 =
	      m_m_row_0[10:6];
      1'd1:
	  CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_10_TO_6__ETC__q6 =
	      m_m_row_1[10:6];
    endcase
  end
  always@(m_m_deqP_ehr_rl or m_m_row_0 or m_m_row_1)
  begin
    case (m_m_deqP_ehr_rl)
      1'd0:
	  CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_5_TO_0_1_ETC__q7 =
	      m_m_row_0[5:0];
      1'd1:
	  CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_5_TO_0_1_ETC__q7 =
	      m_m_row_1[5:0];
    endcase
  end
  always@(m_m_deqP_ehr_rl or m_m_row_0 or m_m_row_1)
  begin
    case (m_m_deqP_ehr_rl)
      1'd0:
	  CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_89_TO_26_ETC__q8 =
	      m_m_row_0[89:26];
      1'd1:
	  CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_89_TO_26_ETC__q8 =
	      m_m_row_1[89:26];
    endcase
  end
  always@(m_m_deqP_ehr_rl or m_m_row_0 or m_m_row_1)
  begin
    case (m_m_deqP_ehr_rl)
      1'd0:
	  CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_25_TO_21_ETC__q9 =
	      m_m_row_0[25:21];
      1'd1:
	  CASE_m_m_deqP_ehr_rl_0_m_m_row_0_BITS_25_TO_21_ETC__q9 =
	      m_m_row_1[25:21];
    endcase
  end
  always@(m_m_deqP_ehr_rl or m_m_specBits_0_rl or m_m_specBits_1_rl)
  begin
    case (m_m_deqP_ehr_rl)
      1'd0:
	  CASE_m_m_deqP_ehr_rl_0_m_m_specBits_0_rl_1_m_m_ETC__q10 =
	      m_m_specBits_0_rl;
      1'd1:
	  CASE_m_m_deqP_ehr_rl_0_m_m_specBits_0_rl_1_m_m_ETC__q10 =
	      m_m_specBits_1_rl;
    endcase
  end

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        m_m_deqP_ehr_rl <= `BSV_ASSIGNMENT_DELAY 1'd0;
	m_m_enqP <= `BSV_ASSIGNMENT_DELAY 1'd0;
	m_m_specBits_0_rl <= `BSV_ASSIGNMENT_DELAY 12'hAAA;
	m_m_specBits_1_rl <= `BSV_ASSIGNMENT_DELAY 12'hAAA;
	m_m_valid_0_rl <= `BSV_ASSIGNMENT_DELAY 1'd0;
	m_m_valid_1_rl <= `BSV_ASSIGNMENT_DELAY 1'd0;
      end
    else
      begin
        if (m_m_deqP_ehr_rl$EN)
	  m_m_deqP_ehr_rl <= `BSV_ASSIGNMENT_DELAY m_m_deqP_ehr_rl$D_IN;
	if (m_m_enqP$EN) m_m_enqP <= `BSV_ASSIGNMENT_DELAY m_m_enqP$D_IN;
	if (m_m_specBits_0_rl$EN)
	  m_m_specBits_0_rl <= `BSV_ASSIGNMENT_DELAY m_m_specBits_0_rl$D_IN;
	if (m_m_specBits_1_rl$EN)
	  m_m_specBits_1_rl <= `BSV_ASSIGNMENT_DELAY m_m_specBits_1_rl$D_IN;
	if (m_m_valid_0_rl$EN)
	  m_m_valid_0_rl <= `BSV_ASSIGNMENT_DELAY m_m_valid_0_rl$D_IN;
	if (m_m_valid_1_rl$EN)
	  m_m_valid_1_rl <= `BSV_ASSIGNMENT_DELAY m_m_valid_1_rl$D_IN;
      end
    if (m_m_row_0$EN) m_m_row_0 <= `BSV_ASSIGNMENT_DELAY m_m_row_0$D_IN;
    if (m_m_row_1$EN) m_m_row_1 <= `BSV_ASSIGNMENT_DELAY m_m_row_1$D_IN;
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    m_m_deqP_ehr_rl = 1'h0;
    m_m_enqP = 1'h0;
    m_m_row_0 = 90'h2AAAAAAAAAAAAAAAAAAAAAA;
    m_m_row_1 = 90'h2AAAAAAAAAAAAAAAAAAAAAA;
    m_m_specBits_0_rl = 12'hAAA;
    m_m_specBits_1_rl = 12'hAAA;
    m_m_valid_0_rl = 1'h0;
    m_m_valid_1_rl = 1'h0;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (EN_enq && m_m_valid_for_enq_wire$wget)
	$fdisplay(32'h80000002, "\n%m: ASSERT FAIL!!");
  end
  // synopsys translate_on
endmodule  // mkSimpleRespQ

