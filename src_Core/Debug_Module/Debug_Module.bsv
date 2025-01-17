// Copyright (c) 2017-2019 Bluespec, Inc. All Rights Reserved.
//
//-
// RVFI_DII + CHERI modifications:
//     Copyright (c) 2020 Alexandre Joannou
//     Copyright (c) 2020 Peter Rugg
//     Copyright (c) 2020 Jonathan Woodruff
//     All rights reserved.
//
//     This software was developed by SRI International and the University of
//     Cambridge Computer Laboratory (Department of Computer Science and
//     Technology) under DARPA contract HR0011-18-C-0016 ("ECATS"), as part of the
//     DARPA SSITH research programme.
//
//     This work was supported by NCSC programme grant 4212611/RFA 15971 ("SafeBet").
//-

package Debug_Module;

// ================================================================
// This is the top-level package of a collection that implements the
// "Debug Module" specified in:
//
//     "RISC-V External Debug Support"
//     Version 0.13
//     7c760b0151e43523ab3d2180e7852cd6f27d942c
//     Mon Jul 3 17:04:59 2017 -0700

// Note: the spec actually represents three (almost) completely
// independent functionalities:
//   Run Control:       to start/stop harts, query their start/stop status, etc.
//   Abstract Commands: to read/write RISC-V registers and RISC-V CSRs
//   System Bus Access: to read/write RISC-V memory/devices

// The only exception to complete independence is that the Run Control
// part has a 'reset' for the Debug Module itself, which includes all
// three parts.

// Unfortunately the spec is not written to make this three-part
// organization clear--aspects of the three parts are completely
// intermingled.  Even the address map mixes registers from the three
// parts.

// Here, this top-level package is merely a wrapper that dispatches
// DMI requests to the three packages that implement the three parts:
//     DM_Run_Control
//     DM_Abstract_Commands
//     DM_System_Bus

// DM_Common contains common spec-level (implementation-independent) definitions.

// ================================================================
// Our Debug Module (DM) has a two sides:
//   - GDB/Host-facing
//   - CPU/Platform-facing

// The GDB/Host-facing side is called DMI (Debug Module Interface) in
// the spec, and is a simple memory-like read/write interface, into a
// debug module address space (unrelated to the RISC-V memory address
// space).

// The CPU/Platform-facing side has request/response interfaces for
// CPU run-control, CPU register/CSR access and RISC-V system memory
// access.

// ================================================================
// BSV library imports

import Memory       :: *;
import FIFO         :: *;
import GetPut       :: *;
import ClientServer :: *;
import SpecialFIFOs :: *;
import Vector       :: *;

// ----------------
// Other library imports

import Semi_FIFOF :: *;
import Cur_Cycle  :: *;
import AXI4       :: *;

// ================================================================
// Project imports

import ISA_Decls    :: *;
import Fabric_Defs  :: *;
import ProcTypes    :: *;

import DM_Common            :: *;
import DM_CPU_Req_Rsp       :: *;
import DM_Run_Control       :: *;
import DM_Abstract_Commands :: *;
import DM_System_Bus        :: *;

// ================================================================

export DM_Common :: *;
export Debug_Module_IFC (..);
export mkDebug_Module;

// ================================================================
// Interface to the Debug Module

interface Debug_Module_IFC;
   // ----------------
   // DMI (Debug Module Interface) facing remote debugger

   interface DMI dmi;

   // ----------------
   // Facing CPU
   // This section replicated for additional harts.

   // Reset and run-control
   interface Vector #(CoreNum, Client #(Bool, Bool)) harts_reset_client;
   interface Vector #(CoreNum, Client #(Bool, Bool)) harts_client_run_halt;
   interface Vector #(CoreNum, Get #(Bit #(4)))      harts_get_other_req;
   interface Vector #(CoreNum, Put #(Bool))          harts_is_running;

   // GPR access
   interface Vector #(CoreNum, Client #(DM_CPU_Req #(5,  XLEN), DM_CPU_Rsp #(XLEN))) harts_gpr_mem_client;

   // FPR access
`ifdef ISA_F
   interface Vector #(CoreNum, Client #(DM_CPU_Req #(5,  FLEN), DM_CPU_Rsp #(FLEN))) harts_fpr_mem_client;
`endif

   // CSR access
   interface Vector #(CoreNum, Client #(DM_CPU_Req #(12, XLEN), DM_CPU_Rsp #(XLEN))) harts_csr_mem_client;

   // ----------------
   // Facing Platform

   // Non-Debug-Module Reset (reset all except DM)
   // Bool indicates 'running' hart state.
   interface Client #(Bool, Bool) ndm_reset_client;

   // Read/Write RISC-V memory
   interface AXI4_Master #( Wd_CoreW_Bus_MId, Wd_Addr, Wd_Data_Periph
                          , Wd_AW_User_Periph, Wd_W_User_Periph, Wd_B_User_Periph
                          , Wd_AR_User_Periph, Wd_R_User_Periph) master;
endinterface

// ================================================================

(* synthesize *)
module mkDebug_Module (Debug_Module_IFC);

   // Local verbosity: 0 = quiet; 1 = print DMI transactions
   Integer verbosity = 0;

   // The three parts
   DM_Run_Control_IFC        dm_run_control       <- mkDM_Run_Control;
   DM_Abstract_Commands_IFC  dm_abstract_commands <- mkDM_Abstract_Commands;
   DM_System_Bus_IFC         dm_system_bus        <- mkDM_System_Bus;

   FIFO#(DM_Addr) f_read_addr <- mkFIFO1;

   // ================================================================
   // Reset all three parts when dm_run_control.dmactive is low

   rule rl_reset (! dm_run_control.dmactive);
      $display ("%0d: Debug_Module reset", cur_cycle);
      dm_run_control.reset;
      dm_abstract_commands.reset;
      dm_system_bus.reset;
   endrule

   // ================================================================
   // INTERFACE

   // ----------------
   // Facing GDB/DMI (Debug Module Interface)

   interface DMI dmi;
      method Action read_addr  (DM_Addr dm_addr) if (dm_run_control.dmactive);
	 f_read_addr.enq(dm_addr);

	 if (verbosity != 0)
	    $display ("%0d: %m.DMI read: dm_addr 0x%0h", cur_cycle, dm_addr);
      endmethod

      method ActionValue #(DM_Word) read_data;
	 let dm_addr = f_read_addr.first;
	 f_read_addr.deq;

	 DM_Word dm_word = ?;

	 if (   (dm_addr == dm_addr_dmcontrol)
	    || (dm_addr == dm_addr_dmstatus)
	    || (dm_addr == dm_addr_hartinfo)
	    || (dm_addr == dm_addr_haltsum0)
	    || (dm_addr == dm_addr_hawindowsel)
	    || (dm_addr == dm_addr_hawindow)
	    || (dm_addr == dm_addr_devtreeaddr0)
	    || (dm_addr == dm_addr_authdata)
	    || (dm_addr == dm_addr_verbosity))

	    dm_word <- dm_run_control.av_read (dm_addr);

	 else if (   (dm_addr == dm_addr_abstractcs)
		  || (dm_addr == dm_addr_command)
		  || (dm_addr == dm_addr_data0)
		  || (dm_addr == dm_addr_data1)
		  || (dm_addr == dm_addr_data2)
		  || (dm_addr == dm_addr_data3)
		  || (dm_addr == dm_addr_data4)
		  || (dm_addr == dm_addr_data5)
		  || (dm_addr == dm_addr_data6)
		  || (dm_addr == dm_addr_data7)
		  || (dm_addr == dm_addr_data8)
		  || (dm_addr == dm_addr_data9)
		  || (dm_addr == dm_addr_data10)
		  || (dm_addr == dm_addr_data11)
		  || (dm_addr == dm_addr_abstractauto)
		  || (dm_addr == dm_addr_progbuf0))

	    dm_word <- dm_abstract_commands.av_read (dm_addr);

	 else if (   (dm_addr == dm_addr_sbcs)
		  || (dm_addr == dm_addr_sbaddress0)
		  || (dm_addr == dm_addr_sbaddress1)
		  || (dm_addr == dm_addr_sbaddress2)
		  || (dm_addr == dm_addr_sbdata0)
		  || (dm_addr == dm_addr_sbdata1)
		  || (dm_addr == dm_addr_sbdata2)
		  || (dm_addr == dm_addr_sbdata3))

	    dm_word <- dm_system_bus.av_read (dm_addr);

	 else begin
	    // TODO: set error status?
	    dm_word = 0;
	 end

	 if (verbosity != 0)
	    $display ("%0d: %m.DMI read response: dm_addr 0x%0h, dm_word 0x%0h",
		      cur_cycle, dm_addr, dm_word);

	 return dm_word;
      endmethod

      method Action write (DM_Addr dm_addr, DM_Word dm_word) if (dm_run_control.dmactive);

	 Bool handled = False;

	 if (   (dm_addr == dm_addr_dmcontrol)
	    || (dm_addr == dm_addr_dmstatus)
	    || (dm_addr == dm_addr_hartinfo)
	    || (dm_addr == dm_addr_haltsum0)
	    || (dm_addr == dm_addr_hawindowsel)
	    || (dm_addr == dm_addr_hawindow)
	    || (dm_addr == dm_addr_devtreeaddr0)
	    || (dm_addr == dm_addr_authdata)
	    || (dm_addr == dm_addr_verbosity)) begin

	    dm_run_control.write (dm_addr, dm_word);
	    handled = True;
	 end

	 if (  (dm_addr == dm_addr_dmcontrol)
	    || (dm_addr == dm_addr_abstractcs)
		  || (dm_addr == dm_addr_command)
		  || (dm_addr == dm_addr_data0)
		  || (dm_addr == dm_addr_data1)
		  || (dm_addr == dm_addr_data2)
		  || (dm_addr == dm_addr_data3)
		  || (dm_addr == dm_addr_data4)
		  || (dm_addr == dm_addr_data5)
		  || (dm_addr == dm_addr_data6)
		  || (dm_addr == dm_addr_data7)
		  || (dm_addr == dm_addr_data8)
		  || (dm_addr == dm_addr_data9)
		  || (dm_addr == dm_addr_data10)
		  || (dm_addr == dm_addr_data11)
		  || (dm_addr == dm_addr_abstractauto)
	    || (dm_addr == dm_addr_progbuf0)) begin

	    dm_abstract_commands.write (dm_addr, dm_word);
	    handled = True;
	 end

	 if (  (dm_addr == dm_addr_sbcs)
		  || (dm_addr == dm_addr_sbaddress0)
		  || (dm_addr == dm_addr_sbaddress1)
		  || (dm_addr == dm_addr_sbaddress2)
		  || (dm_addr == dm_addr_sbdata0)
		  || (dm_addr == dm_addr_sbdata1)
		  || (dm_addr == dm_addr_sbdata2)
	    || (dm_addr == dm_addr_sbdata3)) begin

	    dm_system_bus.write (dm_addr, dm_word);
	    handled = True;
	 end

	 if (! handled) begin
	    // TODO: set error status?
	    noAction;
	 end

	 if (verbosity != 0)
	    $display ("%0d: %m.DMI write: dm_addr 0x%0h, dm_word 0x%0h",
		      cur_cycle, dm_addr, dm_word);
      endmethod
   endinterface

   // ----------------
   // Facing CPU/harts

   // Reset and run-control
   interface harts_reset_client    = dm_run_control.harts_reset_client;
   interface harts_client_run_halt = dm_run_control.harts_client_run_halt;
   interface harts_get_other_req   = dm_run_control.harts_get_other_req;
   interface harts_is_running      = dm_run_control.harts_is_running;

   // GPR access
   interface harts_gpr_mem_client = dm_abstract_commands.harts_gpr_mem_client;

   // FPR access
`ifdef ISA_F
   interface harts_fpr_mem_client = dm_abstract_commands.harts_fpr_mem_client;
`endif

   // CSR access
   interface harts_csr_mem_client = dm_abstract_commands.harts_csr_mem_client;

   // ----------------
   // Facing Platform

   // Non-Debug-Module Reset (reset all except DM)
   interface Client ndm_reset_client = dm_run_control.ndm_reset_client;

   // Read/Write RISC-V memory
   interface master = dm_system_bus.master;
endmodule

// ================================================================

endpackage
