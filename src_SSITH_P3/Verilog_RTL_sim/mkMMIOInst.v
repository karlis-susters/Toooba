//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
// On Sat Jun  6 22:31:03 BST 2020
//
//
// Ports:
// Name                         I/O  size props
// getFetchTarget                 O     2
// RDY_getFetchTarget             O     1 const
// RDY_bootRomReq                 O     1
// bootRomResp                    O    66 reg
// RDY_bootRomResp                O     1
// toCore_instReq_notEmpty        O     1
// RDY_toCore_instReq_notEmpty    O     1 const
// RDY_toCore_instReq_deq         O     1
// toCore_instReq_first_fst       O    64 reg
// RDY_toCore_instReq_first_fst   O     1
// toCore_instReq_first_snd       O     1 reg
// RDY_toCore_instReq_first_snd   O     1
// toCore_instResp_notFull        O     1
// RDY_toCore_instResp_notFull    O     1 const
// RDY_toCore_instResp_enq        O     1
// RDY_toCore_setHtifAddrs        O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// getFetchTarget_phyPc           I    64
// bootRomReq_phyPc               I    64
// bootRomReq_maxWay              I     1
// toCore_instResp_enq_x          I    66
// toCore_setHtifAddrs_toHost     I    64 reg
// toCore_setHtifAddrs_fromHost   I    64 reg
// EN_bootRomReq                  I     1
// EN_toCore_instReq_deq          I     1
// EN_toCore_instResp_enq         I     1
// EN_toCore_setHtifAddrs         I     1
// EN_bootRomResp                 I     1
//
// Combinational paths from inputs to outputs:
//   getFetchTarget_phyPc -> getFetchTarget
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

module mkMMIOInst(CLK,
		  RST_N,

		  getFetchTarget_phyPc,
		  getFetchTarget,
		  RDY_getFetchTarget,

		  bootRomReq_phyPc,
		  bootRomReq_maxWay,
		  EN_bootRomReq,
		  RDY_bootRomReq,

		  EN_bootRomResp,
		  bootRomResp,
		  RDY_bootRomResp,

		  toCore_instReq_notEmpty,
		  RDY_toCore_instReq_notEmpty,

		  EN_toCore_instReq_deq,
		  RDY_toCore_instReq_deq,

		  toCore_instReq_first_fst,
		  RDY_toCore_instReq_first_fst,

		  toCore_instReq_first_snd,
		  RDY_toCore_instReq_first_snd,

		  toCore_instResp_notFull,
		  RDY_toCore_instResp_notFull,

		  toCore_instResp_enq_x,
		  EN_toCore_instResp_enq,
		  RDY_toCore_instResp_enq,

		  toCore_setHtifAddrs_toHost,
		  toCore_setHtifAddrs_fromHost,
		  EN_toCore_setHtifAddrs,
		  RDY_toCore_setHtifAddrs);
  input  CLK;
  input  RST_N;

  // value method getFetchTarget
  input  [63 : 0] getFetchTarget_phyPc;
  output [1 : 0] getFetchTarget;
  output RDY_getFetchTarget;

  // action method bootRomReq
  input  [63 : 0] bootRomReq_phyPc;
  input  bootRomReq_maxWay;
  input  EN_bootRomReq;
  output RDY_bootRomReq;

  // actionvalue method bootRomResp
  input  EN_bootRomResp;
  output [65 : 0] bootRomResp;
  output RDY_bootRomResp;

  // value method toCore_instReq_notEmpty
  output toCore_instReq_notEmpty;
  output RDY_toCore_instReq_notEmpty;

  // action method toCore_instReq_deq
  input  EN_toCore_instReq_deq;
  output RDY_toCore_instReq_deq;

  // value method toCore_instReq_first_fst
  output [63 : 0] toCore_instReq_first_fst;
  output RDY_toCore_instReq_first_fst;

  // value method toCore_instReq_first_snd
  output toCore_instReq_first_snd;
  output RDY_toCore_instReq_first_snd;

  // value method toCore_instResp_notFull
  output toCore_instResp_notFull;
  output RDY_toCore_instResp_notFull;

  // action method toCore_instResp_enq
  input  [65 : 0] toCore_instResp_enq_x;
  input  EN_toCore_instResp_enq;
  output RDY_toCore_instResp_enq;

  // action method toCore_setHtifAddrs
  input  [63 : 0] toCore_setHtifAddrs_toHost;
  input  [63 : 0] toCore_setHtifAddrs_fromHost;
  input  EN_toCore_setHtifAddrs;
  output RDY_toCore_setHtifAddrs;

  // signals for module outputs
  wire [65 : 0] bootRomResp;
  wire [63 : 0] toCore_instReq_first_fst;
  wire [1 : 0] getFetchTarget;
  wire RDY_bootRomReq,
       RDY_bootRomResp,
       RDY_getFetchTarget,
       RDY_toCore_instReq_deq,
       RDY_toCore_instReq_first_fst,
       RDY_toCore_instReq_first_snd,
       RDY_toCore_instReq_notEmpty,
       RDY_toCore_instResp_enq,
       RDY_toCore_instResp_notFull,
       RDY_toCore_setHtifAddrs,
       toCore_instReq_first_snd,
       toCore_instReq_notEmpty,
       toCore_instResp_notFull;

  // inlined wires
  wire [66 : 0] respQ_enqReq_lat_0$wget;
  wire [65 : 0] reqQ_enqReq_lat_0$wget;

  // register fromHostAddr
  reg [60 : 0] fromHostAddr;
  wire [60 : 0] fromHostAddr$D_IN;
  wire fromHostAddr$EN;

  // register pendQ_clearReq_rl
  reg pendQ_clearReq_rl;
  wire pendQ_clearReq_rl$D_IN, pendQ_clearReq_rl$EN;

  // register pendQ_deqReq_rl
  reg pendQ_deqReq_rl;
  wire pendQ_deqReq_rl$D_IN, pendQ_deqReq_rl$EN;

  // register pendQ_empty
  reg pendQ_empty;
  wire pendQ_empty$D_IN, pendQ_empty$EN;

  // register pendQ_enqReq_rl
  reg pendQ_enqReq_rl;
  wire pendQ_enqReq_rl$D_IN, pendQ_enqReq_rl$EN;

  // register pendQ_full
  reg pendQ_full;
  wire pendQ_full$D_IN, pendQ_full$EN;

  // register reqQ_clearReq_rl
  reg reqQ_clearReq_rl;
  wire reqQ_clearReq_rl$D_IN, reqQ_clearReq_rl$EN;

  // register reqQ_data_0
  reg [64 : 0] reqQ_data_0;
  wire [64 : 0] reqQ_data_0$D_IN;
  wire reqQ_data_0$EN;

  // register reqQ_deqReq_rl
  reg reqQ_deqReq_rl;
  wire reqQ_deqReq_rl$D_IN, reqQ_deqReq_rl$EN;

  // register reqQ_empty
  reg reqQ_empty;
  wire reqQ_empty$D_IN, reqQ_empty$EN;

  // register reqQ_enqReq_rl
  reg [65 : 0] reqQ_enqReq_rl;
  wire [65 : 0] reqQ_enqReq_rl$D_IN;
  wire reqQ_enqReq_rl$EN;

  // register reqQ_full
  reg reqQ_full;
  wire reqQ_full$D_IN, reqQ_full$EN;

  // register respQ_clearReq_rl
  reg respQ_clearReq_rl;
  wire respQ_clearReq_rl$D_IN, respQ_clearReq_rl$EN;

  // register respQ_data_0
  reg [65 : 0] respQ_data_0;
  wire [65 : 0] respQ_data_0$D_IN;
  wire respQ_data_0$EN;

  // register respQ_deqReq_rl
  reg respQ_deqReq_rl;
  wire respQ_deqReq_rl$D_IN, respQ_deqReq_rl$EN;

  // register respQ_empty
  reg respQ_empty;
  wire respQ_empty$D_IN, respQ_empty$EN;

  // register respQ_enqReq_rl
  reg [66 : 0] respQ_enqReq_rl;
  wire [66 : 0] respQ_enqReq_rl$D_IN;
  wire respQ_enqReq_rl$EN;

  // register respQ_full
  reg respQ_full;
  wire respQ_full$D_IN, respQ_full$EN;

  // register toHostAddr
  reg [60 : 0] toHostAddr;
  wire [60 : 0] toHostAddr$D_IN;
  wire toHostAddr$EN;

  // ports of submodule soc_map
  wire [63 : 0] soc_map$m_is_IO_addr_addr,
		soc_map$m_is_mem_addr_addr,
		soc_map$m_is_near_mem_IO_addr_addr;
  wire soc_map$m_is_IO_addr;

  // rule scheduling signals
  wire CAN_FIRE_RL_pendQ_canonicalize,
       CAN_FIRE_RL_pendQ_clearReq_canon,
       CAN_FIRE_RL_pendQ_deqReq_canon,
       CAN_FIRE_RL_pendQ_enqReq_canon,
       CAN_FIRE_RL_reqQ_canonicalize,
       CAN_FIRE_RL_reqQ_clearReq_canon,
       CAN_FIRE_RL_reqQ_deqReq_canon,
       CAN_FIRE_RL_reqQ_enqReq_canon,
       CAN_FIRE_RL_respQ_canonicalize,
       CAN_FIRE_RL_respQ_clearReq_canon,
       CAN_FIRE_RL_respQ_deqReq_canon,
       CAN_FIRE_RL_respQ_enqReq_canon,
       CAN_FIRE_bootRomReq,
       CAN_FIRE_bootRomResp,
       CAN_FIRE_toCore_instReq_deq,
       CAN_FIRE_toCore_instResp_enq,
       CAN_FIRE_toCore_setHtifAddrs,
       WILL_FIRE_RL_pendQ_canonicalize,
       WILL_FIRE_RL_pendQ_clearReq_canon,
       WILL_FIRE_RL_pendQ_deqReq_canon,
       WILL_FIRE_RL_pendQ_enqReq_canon,
       WILL_FIRE_RL_reqQ_canonicalize,
       WILL_FIRE_RL_reqQ_clearReq_canon,
       WILL_FIRE_RL_reqQ_deqReq_canon,
       WILL_FIRE_RL_reqQ_enqReq_canon,
       WILL_FIRE_RL_respQ_canonicalize,
       WILL_FIRE_RL_respQ_clearReq_canon,
       WILL_FIRE_RL_respQ_deqReq_canon,
       WILL_FIRE_RL_respQ_enqReq_canon,
       WILL_FIRE_bootRomReq,
       WILL_FIRE_bootRomResp,
       WILL_FIRE_toCore_instReq_deq,
       WILL_FIRE_toCore_instResp_enq,
       WILL_FIRE_toCore_setHtifAddrs;

  // remaining internal signals
  wire IF_reqQ_enqReq_lat_1_whas_THEN_reqQ_enqReq_lat_ETC___d13,
       IF_respQ_enqReq_lat_1_whas__0_THEN_respQ_enqRe_ETC___d79;

  // value method getFetchTarget
  assign getFetchTarget =
	     soc_map$m_is_IO_addr ?
	       2'd1 :
	       ((getFetchTarget_phyPc[63:3] >= 61'd402653184 &&
		 getFetchTarget_phyPc[63:3] < 61'd536870912 &&
		 getFetchTarget_phyPc[63:3] != toHostAddr &&
		 getFetchTarget_phyPc[63:3] != fromHostAddr) ?
		  2'd0 :
		  2'd2) ;
  assign RDY_getFetchTarget = 1'd1 ;

  // action method bootRomReq
  assign RDY_bootRomReq = !reqQ_full && !pendQ_full ;
  assign CAN_FIRE_bootRomReq = !reqQ_full && !pendQ_full ;
  assign WILL_FIRE_bootRomReq = EN_bootRomReq ;

  // actionvalue method bootRomResp
  assign bootRomResp = respQ_data_0 ;
  assign RDY_bootRomResp = !respQ_empty && !pendQ_empty ;
  assign CAN_FIRE_bootRomResp = !respQ_empty && !pendQ_empty ;
  assign WILL_FIRE_bootRomResp = EN_bootRomResp ;

  // value method toCore_instReq_notEmpty
  assign toCore_instReq_notEmpty = !reqQ_empty ;
  assign RDY_toCore_instReq_notEmpty = 1'd1 ;

  // action method toCore_instReq_deq
  assign RDY_toCore_instReq_deq = !reqQ_empty ;
  assign CAN_FIRE_toCore_instReq_deq = !reqQ_empty ;
  assign WILL_FIRE_toCore_instReq_deq = EN_toCore_instReq_deq ;

  // value method toCore_instReq_first_fst
  assign toCore_instReq_first_fst = reqQ_data_0[64:1] ;
  assign RDY_toCore_instReq_first_fst = !reqQ_empty ;

  // value method toCore_instReq_first_snd
  assign toCore_instReq_first_snd = reqQ_data_0[0] ;
  assign RDY_toCore_instReq_first_snd = !reqQ_empty ;

  // value method toCore_instResp_notFull
  assign toCore_instResp_notFull = !respQ_full ;
  assign RDY_toCore_instResp_notFull = 1'd1 ;

  // action method toCore_instResp_enq
  assign RDY_toCore_instResp_enq = !respQ_full ;
  assign CAN_FIRE_toCore_instResp_enq = !respQ_full ;
  assign WILL_FIRE_toCore_instResp_enq = EN_toCore_instResp_enq ;

  // action method toCore_setHtifAddrs
  assign RDY_toCore_setHtifAddrs = 1'd1 ;
  assign CAN_FIRE_toCore_setHtifAddrs = 1'd1 ;
  assign WILL_FIRE_toCore_setHtifAddrs = EN_toCore_setHtifAddrs ;

  // submodule soc_map
  mkSoC_Map soc_map(.CLK(CLK),
		    .RST_N(RST_N),
		    .m_is_IO_addr_addr(soc_map$m_is_IO_addr_addr),
		    .m_is_mem_addr_addr(soc_map$m_is_mem_addr_addr),
		    .m_is_near_mem_IO_addr_addr(soc_map$m_is_near_mem_IO_addr_addr),
		    .m_plic_addr_range(),
		    .m_near_mem_io_addr_range(),
		    .m_flash_mem_addr_range(),
		    .m_ethernet_0_addr_range(),
		    .m_dma_0_addr_range(),
		    .m_uart16550_0_addr_range(),
		    .m_gpio_0_addr_range(),
		    .m_boot_rom_addr_range(),
		    .m_ddr4_0_uncached_addr_range(),
		    .m_ddr4_0_cached_addr_range(),
		    .m_mem0_controller_addr_range(),
		    .m_is_mem_addr(),
		    .m_is_IO_addr(soc_map$m_is_IO_addr),
		    .m_is_near_mem_IO_addr(),
		    .m_pc_reset_value(),
		    .m_mtvec_reset_value(),
		    .m_nmivec_reset_value());

  // rule RL_reqQ_canonicalize
  assign CAN_FIRE_RL_reqQ_canonicalize = 1'd1 ;
  assign WILL_FIRE_RL_reqQ_canonicalize = 1'd1 ;

  // rule RL_reqQ_enqReq_canon
  assign CAN_FIRE_RL_reqQ_enqReq_canon = 1'd1 ;
  assign WILL_FIRE_RL_reqQ_enqReq_canon = 1'd1 ;

  // rule RL_reqQ_deqReq_canon
  assign CAN_FIRE_RL_reqQ_deqReq_canon = 1'd1 ;
  assign WILL_FIRE_RL_reqQ_deqReq_canon = 1'd1 ;

  // rule RL_reqQ_clearReq_canon
  assign CAN_FIRE_RL_reqQ_clearReq_canon = 1'd1 ;
  assign WILL_FIRE_RL_reqQ_clearReq_canon = 1'd1 ;

  // rule RL_respQ_canonicalize
  assign CAN_FIRE_RL_respQ_canonicalize = 1'd1 ;
  assign WILL_FIRE_RL_respQ_canonicalize = 1'd1 ;

  // rule RL_respQ_enqReq_canon
  assign CAN_FIRE_RL_respQ_enqReq_canon = 1'd1 ;
  assign WILL_FIRE_RL_respQ_enqReq_canon = 1'd1 ;

  // rule RL_respQ_deqReq_canon
  assign CAN_FIRE_RL_respQ_deqReq_canon = 1'd1 ;
  assign WILL_FIRE_RL_respQ_deqReq_canon = 1'd1 ;

  // rule RL_respQ_clearReq_canon
  assign CAN_FIRE_RL_respQ_clearReq_canon = 1'd1 ;
  assign WILL_FIRE_RL_respQ_clearReq_canon = 1'd1 ;

  // rule RL_pendQ_canonicalize
  assign CAN_FIRE_RL_pendQ_canonicalize = 1'd1 ;
  assign WILL_FIRE_RL_pendQ_canonicalize = 1'd1 ;

  // rule RL_pendQ_enqReq_canon
  assign CAN_FIRE_RL_pendQ_enqReq_canon = 1'd1 ;
  assign WILL_FIRE_RL_pendQ_enqReq_canon = 1'd1 ;

  // rule RL_pendQ_deqReq_canon
  assign CAN_FIRE_RL_pendQ_deqReq_canon = 1'd1 ;
  assign WILL_FIRE_RL_pendQ_deqReq_canon = 1'd1 ;

  // rule RL_pendQ_clearReq_canon
  assign CAN_FIRE_RL_pendQ_clearReq_canon = 1'd1 ;
  assign WILL_FIRE_RL_pendQ_clearReq_canon = 1'd1 ;

  // inlined wires
  assign reqQ_enqReq_lat_0$wget =
	     { 1'd1, bootRomReq_phyPc, bootRomReq_maxWay } ;
  assign respQ_enqReq_lat_0$wget = { 1'd1, toCore_instResp_enq_x } ;

  // register fromHostAddr
  assign fromHostAddr$D_IN = toCore_setHtifAddrs_fromHost[63:3] ;
  assign fromHostAddr$EN = EN_toCore_setHtifAddrs ;

  // register pendQ_clearReq_rl
  assign pendQ_clearReq_rl$D_IN = 1'd0 ;
  assign pendQ_clearReq_rl$EN = 1'd1 ;

  // register pendQ_deqReq_rl
  assign pendQ_deqReq_rl$D_IN = 1'd0 ;
  assign pendQ_deqReq_rl$EN = 1'd1 ;

  // register pendQ_empty
  assign pendQ_empty$D_IN =
	     pendQ_clearReq_rl ||
	     !EN_bootRomReq && !pendQ_enqReq_rl &&
	     (EN_bootRomResp || pendQ_deqReq_rl || pendQ_empty) ;
  assign pendQ_empty$EN = 1'd1 ;

  // register pendQ_enqReq_rl
  assign pendQ_enqReq_rl$D_IN = 1'd0 ;
  assign pendQ_enqReq_rl$EN = 1'd1 ;

  // register pendQ_full
  assign pendQ_full$D_IN =
	     !pendQ_clearReq_rl &&
	     (EN_bootRomReq || pendQ_enqReq_rl ||
	      !EN_bootRomResp && !pendQ_deqReq_rl && pendQ_full) ;
  assign pendQ_full$EN = 1'd1 ;

  // register reqQ_clearReq_rl
  assign reqQ_clearReq_rl$D_IN = 1'd0 ;
  assign reqQ_clearReq_rl$EN = 1'd1 ;

  // register reqQ_data_0
  assign reqQ_data_0$D_IN =
	     EN_bootRomReq ?
	       reqQ_enqReq_lat_0$wget[64:0] :
	       reqQ_enqReq_rl[64:0] ;
  assign reqQ_data_0$EN =
	     !reqQ_clearReq_rl &&
	     IF_reqQ_enqReq_lat_1_whas_THEN_reqQ_enqReq_lat_ETC___d13 ;

  // register reqQ_deqReq_rl
  assign reqQ_deqReq_rl$D_IN = 1'd0 ;
  assign reqQ_deqReq_rl$EN = 1'd1 ;

  // register reqQ_empty
  assign reqQ_empty$D_IN =
	     reqQ_clearReq_rl ||
	     (EN_bootRomReq ?
		!reqQ_enqReq_lat_0$wget[65] :
		!reqQ_enqReq_rl[65]) &&
	     (EN_toCore_instReq_deq || reqQ_deqReq_rl || reqQ_empty) ;
  assign reqQ_empty$EN = 1'd1 ;

  // register reqQ_enqReq_rl
  assign reqQ_enqReq_rl$D_IN = 66'h0AAAAAAAAAAAAAAAA ;
  assign reqQ_enqReq_rl$EN = 1'd1 ;

  // register reqQ_full
  assign reqQ_full$D_IN =
	     !reqQ_clearReq_rl &&
	     (IF_reqQ_enqReq_lat_1_whas_THEN_reqQ_enqReq_lat_ETC___d13 ||
	      !EN_toCore_instReq_deq && !reqQ_deqReq_rl && reqQ_full) ;
  assign reqQ_full$EN = 1'd1 ;

  // register respQ_clearReq_rl
  assign respQ_clearReq_rl$D_IN = 1'd0 ;
  assign respQ_clearReq_rl$EN = 1'd1 ;

  // register respQ_data_0
  assign respQ_data_0$D_IN =
	     { EN_toCore_instResp_enq ?
		 respQ_enqReq_lat_0$wget[65] :
		 respQ_enqReq_rl[65],
	       EN_toCore_instResp_enq ?
		 respQ_enqReq_lat_0$wget[64:33] :
		 respQ_enqReq_rl[64:33],
	       EN_toCore_instResp_enq ?
		 respQ_enqReq_lat_0$wget[32] :
		 respQ_enqReq_rl[32],
	       EN_toCore_instResp_enq ?
		 respQ_enqReq_lat_0$wget[31:0] :
		 respQ_enqReq_rl[31:0] } ;
  assign respQ_data_0$EN =
	     !respQ_clearReq_rl &&
	     IF_respQ_enqReq_lat_1_whas__0_THEN_respQ_enqRe_ETC___d79 ;

  // register respQ_deqReq_rl
  assign respQ_deqReq_rl$D_IN = 1'd0 ;
  assign respQ_deqReq_rl$EN = 1'd1 ;

  // register respQ_empty
  assign respQ_empty$D_IN =
	     respQ_clearReq_rl ||
	     (EN_toCore_instResp_enq ?
		!respQ_enqReq_lat_0$wget[66] :
		!respQ_enqReq_rl[66]) &&
	     (EN_bootRomResp || respQ_deqReq_rl || respQ_empty) ;
  assign respQ_empty$EN = 1'd1 ;

  // register respQ_enqReq_rl
  assign respQ_enqReq_rl$D_IN = 67'h2AAAAAAAAAAAAAAAA ;
  assign respQ_enqReq_rl$EN = 1'd1 ;

  // register respQ_full
  assign respQ_full$D_IN =
	     !respQ_clearReq_rl &&
	     (IF_respQ_enqReq_lat_1_whas__0_THEN_respQ_enqRe_ETC___d79 ||
	      !EN_bootRomResp && !respQ_deqReq_rl && respQ_full) ;
  assign respQ_full$EN = 1'd1 ;

  // register toHostAddr
  assign toHostAddr$D_IN = toCore_setHtifAddrs_toHost[63:3] ;
  assign toHostAddr$EN = EN_toCore_setHtifAddrs ;

  // submodule soc_map
  assign soc_map$m_is_IO_addr_addr = getFetchTarget_phyPc ;
  assign soc_map$m_is_mem_addr_addr = 64'h0 ;
  assign soc_map$m_is_near_mem_IO_addr_addr = 64'h0 ;

  // remaining internal signals
  assign IF_reqQ_enqReq_lat_1_whas_THEN_reqQ_enqReq_lat_ETC___d13 =
	     EN_bootRomReq ? reqQ_enqReq_lat_0$wget[65] : reqQ_enqReq_rl[65] ;
  assign IF_respQ_enqReq_lat_1_whas__0_THEN_respQ_enqRe_ETC___d79 =
	     EN_toCore_instResp_enq ?
	       respQ_enqReq_lat_0$wget[66] :
	       respQ_enqReq_rl[66] ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        fromHostAddr <= `BSV_ASSIGNMENT_DELAY 61'd0;
	pendQ_clearReq_rl <= `BSV_ASSIGNMENT_DELAY 1'd0;
	pendQ_deqReq_rl <= `BSV_ASSIGNMENT_DELAY 1'd0;
	pendQ_empty <= `BSV_ASSIGNMENT_DELAY 1'd1;
	pendQ_enqReq_rl <= `BSV_ASSIGNMENT_DELAY 1'd0;
	pendQ_full <= `BSV_ASSIGNMENT_DELAY 1'd0;
	reqQ_clearReq_rl <= `BSV_ASSIGNMENT_DELAY 1'd0;
	reqQ_data_0 <= `BSV_ASSIGNMENT_DELAY 65'd0;
	reqQ_deqReq_rl <= `BSV_ASSIGNMENT_DELAY 1'd0;
	reqQ_empty <= `BSV_ASSIGNMENT_DELAY 1'd1;
	reqQ_enqReq_rl <= `BSV_ASSIGNMENT_DELAY 66'h0AAAAAAAAAAAAAAAA;
	reqQ_full <= `BSV_ASSIGNMENT_DELAY 1'd0;
	respQ_clearReq_rl <= `BSV_ASSIGNMENT_DELAY 1'd0;
	respQ_data_0 <= `BSV_ASSIGNMENT_DELAY 66'h155555554AAAAAAAA;
	respQ_deqReq_rl <= `BSV_ASSIGNMENT_DELAY 1'd0;
	respQ_empty <= `BSV_ASSIGNMENT_DELAY 1'd1;
	respQ_enqReq_rl <= `BSV_ASSIGNMENT_DELAY 67'h2AAAAAAAAAAAAAAAA;
	respQ_full <= `BSV_ASSIGNMENT_DELAY 1'd0;
	toHostAddr <= `BSV_ASSIGNMENT_DELAY 61'd0;
      end
    else
      begin
        if (fromHostAddr$EN)
	  fromHostAddr <= `BSV_ASSIGNMENT_DELAY fromHostAddr$D_IN;
	if (pendQ_clearReq_rl$EN)
	  pendQ_clearReq_rl <= `BSV_ASSIGNMENT_DELAY pendQ_clearReq_rl$D_IN;
	if (pendQ_deqReq_rl$EN)
	  pendQ_deqReq_rl <= `BSV_ASSIGNMENT_DELAY pendQ_deqReq_rl$D_IN;
	if (pendQ_empty$EN)
	  pendQ_empty <= `BSV_ASSIGNMENT_DELAY pendQ_empty$D_IN;
	if (pendQ_enqReq_rl$EN)
	  pendQ_enqReq_rl <= `BSV_ASSIGNMENT_DELAY pendQ_enqReq_rl$D_IN;
	if (pendQ_full$EN)
	  pendQ_full <= `BSV_ASSIGNMENT_DELAY pendQ_full$D_IN;
	if (reqQ_clearReq_rl$EN)
	  reqQ_clearReq_rl <= `BSV_ASSIGNMENT_DELAY reqQ_clearReq_rl$D_IN;
	if (reqQ_data_0$EN)
	  reqQ_data_0 <= `BSV_ASSIGNMENT_DELAY reqQ_data_0$D_IN;
	if (reqQ_deqReq_rl$EN)
	  reqQ_deqReq_rl <= `BSV_ASSIGNMENT_DELAY reqQ_deqReq_rl$D_IN;
	if (reqQ_empty$EN)
	  reqQ_empty <= `BSV_ASSIGNMENT_DELAY reqQ_empty$D_IN;
	if (reqQ_enqReq_rl$EN)
	  reqQ_enqReq_rl <= `BSV_ASSIGNMENT_DELAY reqQ_enqReq_rl$D_IN;
	if (reqQ_full$EN) reqQ_full <= `BSV_ASSIGNMENT_DELAY reqQ_full$D_IN;
	if (respQ_clearReq_rl$EN)
	  respQ_clearReq_rl <= `BSV_ASSIGNMENT_DELAY respQ_clearReq_rl$D_IN;
	if (respQ_data_0$EN)
	  respQ_data_0 <= `BSV_ASSIGNMENT_DELAY respQ_data_0$D_IN;
	if (respQ_deqReq_rl$EN)
	  respQ_deqReq_rl <= `BSV_ASSIGNMENT_DELAY respQ_deqReq_rl$D_IN;
	if (respQ_empty$EN)
	  respQ_empty <= `BSV_ASSIGNMENT_DELAY respQ_empty$D_IN;
	if (respQ_enqReq_rl$EN)
	  respQ_enqReq_rl <= `BSV_ASSIGNMENT_DELAY respQ_enqReq_rl$D_IN;
	if (respQ_full$EN)
	  respQ_full <= `BSV_ASSIGNMENT_DELAY respQ_full$D_IN;
	if (toHostAddr$EN)
	  toHostAddr <= `BSV_ASSIGNMENT_DELAY toHostAddr$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    fromHostAddr = 61'h0AAAAAAAAAAAAAAA;
    pendQ_clearReq_rl = 1'h0;
    pendQ_deqReq_rl = 1'h0;
    pendQ_empty = 1'h0;
    pendQ_enqReq_rl = 1'h0;
    pendQ_full = 1'h0;
    reqQ_clearReq_rl = 1'h0;
    reqQ_data_0 = 65'h0AAAAAAAAAAAAAAAA;
    reqQ_deqReq_rl = 1'h0;
    reqQ_empty = 1'h0;
    reqQ_enqReq_rl = 66'h2AAAAAAAAAAAAAAAA;
    reqQ_full = 1'h0;
    respQ_clearReq_rl = 1'h0;
    respQ_data_0 = 66'h2AAAAAAAAAAAAAAAA;
    respQ_deqReq_rl = 1'h0;
    respQ_empty = 1'h0;
    respQ_enqReq_rl = 67'h2AAAAAAAAAAAAAAAA;
    respQ_full = 1'h0;
    toHostAddr = 61'h0AAAAAAAAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMMIOInst

