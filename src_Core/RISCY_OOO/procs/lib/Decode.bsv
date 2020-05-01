
// Copyright (c) 2017 Massachusetts Institute of Technology
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use, copy,
// modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
// BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

`include "ProcConfig.bsv"

import Types::*;
import ProcTypes::*;
import MemoryTypes::*;
import Vector::*;
import DefaultValue::*;
import ISA_Decls_CHERI::*;

Bit#(3) memWU   = 3'b110;

// Smaller decode functions
function Maybe#(MemInst) decodeMemInst(Instruction inst);
    MemInst mem_inst = MemInst{ mem_func: ?,
                                amo_func: None,
                                unsignedLd: False,
                                byteEn: replicate(False),
                                aq: False,
                                rl: False };
    Bool illegalInst = False;
    Opcode opcode = unpackOpcode(inst[6:0]);
    let funct5 = inst[31:27];
    let funct3 = inst[14:12];

    // mem_func + amo_func
    MemFunc mem_func = Ld;
    AmoFunc amo_func = None;
    if (opcode == Load || opcode == LoadFp || opcode == MemMisc) begin
        mem_func = Ld;
    end else if (opcode == Store || opcode == StoreFp) begin
        mem_func = St;
    end else if (opcode == Amo) begin
        case (funct5)
            fnLR       : mem_func = Lr;
            fnSC       : mem_func = Sc;
            fnAMOSWAP,
            fnAMOADD,
            fnAMOXOR,
            fnAMOAND,
            fnAMOOR,
            fnAMOMIN,
            fnAMOMAX,
            fnAMOMINU,
            fnAMOMAXU  : mem_func = Amo;
            default    : illegalInst = True;
        endcase
        // now for amo_func
        case (funct5)
            fnAMOSWAP : amo_func = Swap;
            fnAMOADD  : amo_func = Add;
            fnAMOXOR  : amo_func = Xor;
            fnAMOAND  : amo_func = And;
            fnAMOOR   : amo_func = Or;
            fnAMOMIN  : amo_func = Min;
            fnAMOMAX  : amo_func = Max;
            fnAMOMINU : amo_func = Minu;
            fnAMOMAXU : amo_func = Maxu;
        endcase
    end else begin
        illegalInst = True;
    end

    // unsignedLd
    // it doesn't matter if this is set to True for stores
    Bool unsignedLd = False;
    case (funct3)
        memB, memH, memW, memD:
            unsignedLd = False;
        memBU, memHU, memWU:
            unsignedLd = True;
        default:
            illegalInst = True;
    endcase
    // This is a minor fix to make our processor's results match spike since
    // they don't sign extend when loading single precision values from memory
    if (opcode == LoadFp) begin
        unsignedLd = True;
    end

    Bool capWidth = (mem_func == St      && funct3 == 3'b100)
                 || (opcode   == MemMisc && funct3 == 3'b010);

    // byteEn
    // TODO: Some combinations of operations and byteEn's are illegal.
    // They should be detected here.
    MemDataByteEn byteEn = (capWidth) ? replicate(True):replicate(False);
    if (!capWidth) begin
        case (funct3)
            memB, memBU : byteEn[0] = True;
            memH, memHU : begin
                              byteEn[0] = True;
                              byteEn[1] = True;
                          end
            memW, memWU : begin
                              byteEn[0] = True;
                              byteEn[1] = True;
                              byteEn[2] = True;
                              byteEn[3] = True;
                          end
            memD        : begin
                              byteEn[0] = True;
                              byteEn[1] = True;
                              byteEn[2] = True;
                              byteEn[3] = True;
                              byteEn[4] = True;
                              byteEn[5] = True;
                              byteEn[6] = True;
                              byteEn[7] = True;
                          end
            default     : illegalInst = True;
        endcase
    end

    // aq + rl
    Bool aq = False;
    Bool rl = False;
    if (opcode == Amo) begin
        // aq and rl are only defined for Amo operations
        aq = unpack(inst[ 26 ]);
        rl = unpack(inst[ 25 ]);
    end

    if (illegalInst) begin
        return tagged Invalid;
    end else begin
        return tagged Valid ( MemInst{
                                mem_func: mem_func,
                                amo_func: amo_func,
                                unsignedLd: unsignedLd,
                                byteEn: byteEn,
                                aq: aq,
                                rl: rl } );
    end
endfunction

(* noinline *)
function DecodeResult decode(Instruction inst);
    RiscVISASubset isa = defaultValue;

    // initialize dInst with default values
    DecodedInst dInst = DecodedInst {
        iType: Unsupported,
        execFunc: tagged Other,
        csr: tagged Invalid,
        scr: tagged Invalid,
        imm: tagged Invalid,
        capChecks: unpack(0)
    };
    ArchRegs regs = ArchRegs {
        src1: tagged Invalid,
        src2: tagged Invalid,
        src3: tagged Invalid,
        dst: tagged Invalid
    };
    Bool illegalInst = False;

    Opcode opcode = unpackOpcode(inst[  6 :  0 ]);
    let rd        =              inst[ 11 :  7 ];
    let funct3    =              inst[ 14 : 12 ];
    let rs1       =              inst[ 19 : 15 ];
    let rs2       =              inst[ 24 : 20 ];
    let funct7    =              inst[ 31 : 25 ];
    // For "F" and "D" ISA extensions
    let funct5    =              inst[ 31 : 27 ];
    let fmt       =              inst[ 26 : 25 ];
    let rs3       =              inst[ 31 : 27 ];
    let funct2    =              inst[ 26 : 25 ];
    // For "A" ISA extension
    Bool aq       =       unpack(inst[ 26 ]);
    Bool rl       =       unpack(inst[ 25 ]);
    // For "xCHERI" ISA extension
    let funct5rs2 =              inst[ 24 : 20 ];

    ImmData immI  = signExtend(inst[31:20]);
    ImmData immS  = signExtend({ inst[31:25], inst[11:7] });
    ImmData immB  = signExtend({ inst[31], inst[7], inst[30:25], inst[11:8], 1'b0});
    ImmData immU  = signExtend({ inst[31:12], 12'b0 });
    ImmData immJ  = signExtend({ inst[31], inst[19:12], inst[20], inst[30:21], 1'b0});
    ImmData immIunsigned = zeroExtend(inst[31:20]);

    // Results of mini-decoders
    Maybe#(MemInst) mem_inst = decodeMemInst(inst);

    // TODO better detection of illegal insts
    case (opcode)
        OpImm: begin
            dInst.iType = Alu;
            dInst.execFunc = tagged Alu (case (funct3)
                fnADD: Add;
                fnSLT: Slt;
                fnSLTU: Sltu;
                fnAND: And;
                fnOR: Or;
                fnXOR: Xor;
                fnSLL: Sll;
                fnSR: (immI[10] == 0 ? Srl : Sra);
            endcase);
            regs.dst  = Valid(tagged Gpr rd);
            regs.src1 = Valid(tagged Gpr rs1);
            regs.src2 = Invalid;
            dInst.imm = Valid(immI);
            dInst.csr = tagged Invalid;
        end

        OpImm32: begin
            dInst.iType = Alu;
            dInst.execFunc = tagged Alu (case (funct3)
                fnADD: Addw;
                fnSLL: Sllw;
                fnSR: (immI[10] == 0 ? Srlw : Sraw);
            endcase);
            regs.dst  = Valid(tagged Gpr rd);
            regs.src1 = Valid(tagged Gpr rs1);
            regs.src2 = Invalid;
            dInst.imm = Valid(immI);
            dInst.csr = tagged Invalid;
        end

        Op: begin
            dInst.iType = Alu;
            regs.dst  = Valid(tagged Gpr rd);
            regs.src1 = Valid(tagged Gpr rs1);
            regs.src2 = Valid(tagged Gpr rs2);
            dInst.imm = Invalid;
            dInst.csr = tagged Invalid;
            case (funct7)
                opALU1: begin
                    dInst.execFunc = tagged Alu (case(funct3)
                        fnADD: Add;
                        fnSLT: Slt;
                        fnSLTU: Sltu;
                        fnAND: And;
                        fnOR: Or;
                        fnXOR: Xor;
                        fnSLL: Sll;
                        fnSR: Srl;
                    endcase);
                end
                opALU2: begin
                    dInst.execFunc = tagged Alu (case (funct3)
                        fnADD: Sub;
                        fnSR: Sra;
                    endcase);
                end
                opMULDIV: begin
                    if (isa.m) begin
                        // Processor includes "M" extension
                        MulDivFunc func = (case(funct3)
                            fnMUL    : Mul;
                            fnMULH   : Mulh;
                            fnMULHSU : Mulh;
                            fnMULHU  : Mulh;
                            fnDIV    : Div;
                            fnDIVU   : Div;
                            fnREM    : Rem;
                            fnREMU   : Rem;
                        endcase);
                        Bool w = False;
                        MulDivSign sign = (case(funct3)
                            fnMUL    : Signed;
                            fnMULH   : Signed;
                            fnMULHSU : SignedUnsigned;
                            fnMULHU  : Unsigned;
                            fnDIV    : Signed;
                            fnDIVU   : Unsigned;
                            fnREM    : Signed;
                            fnREMU   : Unsigned;
                        endcase);
                        dInst.execFunc = tagged MulDiv (MulDivInst {
                            func: func, w: w, sign: sign
                        });
                    end else begin
                        // Processor doesn't include "M" extension
                        illegalInst = True;
                    end
                end
            endcase
        end

        Op32: begin
            dInst.iType = Alu;
            case (funct7)
                opALU1: begin
                    dInst.execFunc = tagged Alu (case(funct3)
                        fnADD: Addw;
                        fnSLL: Sllw;
                        fnSR: Srlw;
                    endcase);
                end
                opALU2: begin
                    dInst.execFunc = tagged Alu (case (funct3)
                        fnADD: Subw;
                        fnSR: Sraw;
                    endcase);
                end
                opMULDIV: begin
                    if (isa.m) begin
                        // Processor includes "M" extension
                        // TODO mark MULH as illegal inst
                        MulDivFunc func = (case(funct3)
                            fnMUL    : Mul;
                            fnMULH   : Mulh; // illegal
                            fnMULHSU : Mulh; // illegal
                            fnMULHU  : Mulh; // illegal
                            fnDIV    : Div;
                            fnDIVU   : Div;
                            fnREM    : Rem;
                            fnREMU   : Rem;
                        endcase);
                        Bool w = True;
                        MulDivSign sign = (case(funct3)
                            fnMUL    : Signed;
                            fnMULH   : Signed; // illegal
                            fnMULHSU : SignedUnsigned; // illegal
                            fnMULHU  : Unsigned; // illegal
                            fnDIV    : Signed;
                            fnDIVU   : Unsigned;
                            fnREM    : Signed;
                            fnREMU   : Unsigned;
                        endcase);
                        dInst.execFunc = tagged MulDiv (MulDivInst{
                            func: func, w: w, sign: sign
                        });
                    end else begin
                        // Processor doesn't include "M" extension
                        illegalInst = True;
                    end
                end
            endcase
            regs.dst  = Valid(tagged Gpr rd);
            regs.src1 = Valid(tagged Gpr rs1);
            regs.src2 = Valid(tagged Gpr rs2);
            dInst.imm = Invalid;
            dInst.csr = tagged Invalid;
        end

        Lui: begin // treated as an x0 + immU
            dInst.iType = Alu;
            dInst.execFunc = tagged Alu Add;
            regs.dst = Valid(tagged Gpr rd);
            regs.src1 = Valid(tagged Gpr 0);
            regs.src2 = Invalid;
            dInst.imm = Valid(immU);
            dInst.csr = tagged Invalid;
        end

        Auipc: begin
            dInst.iType = Auipc;
            dInst.execFunc = tagged Alu Add;
            regs.dst  = Valid(tagged Gpr rd);
            regs.src1 = Invalid;
            regs.src2 = Invalid;
            dInst.imm = Valid(immU);
            dInst.csr = tagged Invalid;
        end

        Jal: begin
            dInst.iType = J;
            regs.dst  = Valid(tagged Gpr rd);
            regs.src1 = Invalid;
            regs.src2 = Invalid;
            dInst.imm = Valid(immJ);
            dInst.csr = tagged Invalid;
            dInst.execFunc = tagged Br AT;
            dInst.capChecks.check_enable = True;
            dInst.capChecks.check_authority_src = Pcc;
            dInst.capChecks.check_low_src = Src1Addr;
            dInst.capChecks.check_high_src = Src1AddrPlus2;
            dInst.capChecks.check_inclusive = True;
        end

        Jalr: begin
            dInst.iType = Jr;
            regs.dst  = Valid(tagged Gpr rd);
            regs.src1 = Valid(tagged Gpr rs1);
            regs.src2 = Invalid;
            dInst.imm = Valid(immI);
            dInst.csr = tagged Invalid;
            dInst.execFunc = tagged Br AT;
            dInst.capChecks.check_enable = True;
            dInst.capChecks.check_authority_src = Pcc;
            dInst.capChecks.check_low_src = Src1Addr;
            dInst.capChecks.check_high_src = Src1AddrPlus2;
            dInst.capChecks.check_inclusive = True;
        end

        Branch: begin
            dInst.iType = Br;
            dInst.execFunc = tagged Br (case(funct3)
                fnBEQ: Eq;
                fnBNE: Neq;
                fnBLT: Lt;
                fnBLTU: Ltu;
                fnBGE: Ge;
                fnBGEU: Geu;
            endcase);
            regs.dst  = Invalid;
            regs.src1 = Valid(tagged Gpr rs1);
            regs.src2 = Valid(tagged Gpr rs2);
            dInst.imm = Valid(immB);
            dInst.csr = tagged Invalid;
            dInst.capChecks.check_enable = True;
            dInst.capChecks.check_authority_src = Pcc;
            dInst.capChecks.check_low_src = Src1Addr;
            dInst.capChecks.check_high_src = Src1AddrPlus2;
            dInst.capChecks.check_inclusive = True;
        end

        Load, MemMisc: begin
            dInst.iType = Ld;
            if (isValid(mem_inst)) begin
                dInst.execFunc = tagged Mem fromMaybe(?, mem_inst);
            end else begin
                illegalInst = True;
            end
            regs.dst  = Valid(tagged Gpr rd);
            regs.src1 = Valid(tagged Gpr rs1);
            regs.src2 = Invalid;
            dInst.imm = Valid(immI);
            dInst.csr = tagged Invalid;
        end

        Store: begin
            dInst.iType = St;
            if (isValid(mem_inst)) begin
                dInst.execFunc = tagged Mem fromMaybe(?, mem_inst);
            end else begin
                illegalInst = True;
            end
            regs.dst  = Invalid;
            regs.src1 = Valid(tagged Gpr rs1);
            regs.src2 = Valid(tagged Gpr rs2);
            dInst.imm = Valid(immS);
            dInst.csr = tagged Invalid;
        end

        Amo: begin
            if (!isa.a) begin
                // unsupported
                illegalInst = True;
            end else begin
                // AMO defaults
                dInst.iType = Amo;
                regs.dst  = Valid(tagged Gpr rd);
                regs.src1 = Valid(tagged Gpr rs1);
                regs.src2 = Valid(tagged Gpr rs2);
                dInst.imm = Valid(0);
                dInst.csr = Invalid;

                case (funct5)
                    fnLR: begin
                        dInst.iType = Lr;
                        if (isValid(mem_inst)) begin
                            dInst.execFunc = tagged Mem fromMaybe(?, mem_inst);
                        end else begin
                            illegalInst = True;
                        end
                        regs.dst  = Valid(tagged Gpr rd);
                        regs.src1 = Valid(tagged Gpr rs1);
                        regs.src2 = Invalid;
                        dInst.imm = Valid(0);
                        dInst.csr = Invalid;
                    end

                    fnSC: begin
                        dInst.iType = Sc;
                        if (isValid(mem_inst)) begin
                            dInst.execFunc = tagged Mem fromMaybe(?, mem_inst);
                        end else begin
                            illegalInst = True;
                        end
                        regs.dst  = Valid(tagged Gpr rd);
                        regs.src1 = Valid(tagged Gpr rs1);
                        regs.src2 = Valid(tagged Gpr rs2);
                        dInst.imm  = Valid(0);
                        dInst.csr  = Invalid;
                    end

                    fnAMOSWAP,
                    fnAMOADD,
                    fnAMOXOR,
                    fnAMOAND,
                    fnAMOOR,
                    fnAMOMIN,
                    fnAMOMAX,
                    fnAMOMINU,
                    fnAMOMAXU: begin
                        if (isValid(mem_inst)) begin
                            dInst.execFunc = tagged Mem fromMaybe(?, mem_inst);
                        end else begin
                            illegalInst = True;
                        end
                    end

                    default: begin
                        illegalInst = True;
                    end
                endcase
            end
        end

        // Instructions for "F" and "D" ISA extensions - FPU
        OpFp: begin
            // check if instruction is supported
            if ((fmt == fmtS && !isa.f) || (fmt == fmtD && !isa.d) || (fmt != fmtS && fmt != fmtD)) begin
                illegalInst = True;
            end else begin
                // Instruction is supported
                dInst.iType = Fpu;
                regs.dst  = Valid(tagged Fpu rd);
                regs.src1 = Valid(tagged Fpu rs1);
                regs.src2 = Valid(tagged Fpu rs2);
                dInst.imm  = Invalid;
                dInst.csr = tagged Invalid;
                FpuFunc func = (case (funct5)
                    opFADD:     FAdd;
                    opFSUB:     FSub;
                    opFMUL:     FMul;
                    opFDIV:     FDiv;
                    opFSQRT:    FSqrt;
                    opFSGNJ:    ((funct3 == 0) ? FSgnj : ((funct3 == 1) ? FSgnjn : FSgnjx));
                    opFMINMAX:  ((funct3 == 0) ? FMin : FMax);
                    opFCMP:     ((funct3 == 0) ? FLe : ((funct3 == 1) ? FLt : FEq));
                    opFMV_XF:   ((funct3 == 0) ? FMv_XF : FClass); // also CLASS
                    opFMV_FX:   FMv_FX;
                    opFCVT_FF:  FCvt_FF;
                    opFCVT_WF:  ((rs2 == 0) ? FCvt_WF : ((rs2 == 1) ? FCvt_WUF : ((rs2 == 2) ? FCvt_LF : FCvt_LUF)));
                    opFCVT_FW:  ((rs2 == 0) ? FCvt_FW : ((rs2 == 1) ? FCvt_FWU : ((rs2 == 2) ? FCvt_FL : FCvt_FLU)));
                endcase);
                FpuPrecision precision = (fmt == fmtS) ? Single : Double;
                dInst.execFunc = tagged Fpu(FpuInst{func: func, rm: unpack(funct3), precision: precision});
                // Special cases
                case (funct5)
                    opFSQRT: begin
                        regs.dst  = Valid(tagged Fpu rd);
                        regs.src1 = Valid(tagged Fpu rs1);
                        regs.src2 = Invalid;
                    end
                    opFCMP: begin
                        regs.dst  = Valid(tagged Gpr rd);
                        regs.src1 = Valid(tagged Fpu rs1);
                        regs.src2 = Valid(tagged Fpu rs2);
                    end
                    opFMV_XF: begin
                        regs.dst  = Valid(tagged Gpr rd);
                        regs.src1 = Valid(tagged Fpu rs1);
                        regs.src2 = Invalid;
                    end
                    opFMV_FX: begin
                        regs.dst  = Valid(tagged Fpu rd);
                        regs.src1 = Valid(tagged Gpr rs1);
                        regs.src2 = Invalid;
                    end
                    opFCVT_FF: begin
                        regs.dst  = Valid(tagged Fpu rd);
                        regs.src1 = Valid(tagged Fpu rs1);
                        regs.src2 = Invalid;
                    end
                    opFCVT_WF: begin
                        regs.dst  = Valid(tagged Gpr rd);
                        regs.src1 = Valid(tagged Fpu rs1);
                        regs.src2 = Invalid;
                    end
                    opFCVT_FW: begin
                        regs.dst  = Valid(tagged Fpu rd);
                        regs.src1 = Valid(tagged Gpr rs1);
                        regs.src2 = Invalid;
                    end
                endcase
            end
        end
        LoadFp: begin
            // check if instruction is supported
            if (!isa.f && !isa.d) begin
                // FIXME: Check more cases
                illegalInst = True;
            end else begin
                // Same decode logic as Int Ld
                dInst.iType = Ld;
                if (isValid(mem_inst)) begin
                    dInst.execFunc = tagged Mem fromMaybe(?, mem_inst);
                end else begin
                    illegalInst = True;
                end
                regs.dst  = Valid(tagged Fpu rd);
                regs.src1 = Valid(tagged Gpr rs1);
                regs.src2 = Invalid;
                dInst.imm = Valid(immI);
                dInst.csr = tagged Invalid;
            end
        end
        StoreFp: begin
            // check if instruction is supported
            if (!isa.f && !isa.d) begin
                // FIXME: Check more cases
                illegalInst = True;
            end else begin
                // Same decode logic as Int St
                dInst.iType = St;
                if (isValid(mem_inst)) begin
                    dInst.execFunc = tagged Mem fromMaybe(?, mem_inst);
                end else begin
                    illegalInst = True;
                end
                regs.dst  = Invalid;
                regs.src1 = Valid(tagged Gpr rs1);
                regs.src2 = Valid(tagged Fpu rs2);
                dInst.imm = Valid(immS);
                dInst.csr = tagged Invalid;
            end
        end
        Fmadd, Fmsub, Fnmsub, Fnmadd: begin
            // check if instruction is supported
            if ((fmt == fmtS && !isa.f) ||
                (fmt == fmtD && !isa.d) ||
                (fmt != fmtS && fmt != fmtD)) begin
                dInst.iType = Unsupported;
                illegalInst = True;
            end else begin
                // Instruction is supported
                dInst.iType = Fpu;
                FpuFunc func = ?;
                case (opcode)
                    Fmadd:  func = FMAdd;
                    Fmsub:  func = FMSub;
                    Fnmsub: func = FNMSub;
                    Fnmadd: func = FNMAdd;
                    default: illegalInst = True;
                endcase
                dInst.execFunc = tagged Fpu (FpuInst {
                    func: func,
                    rm: unpack(funct3),
                    precision: fmt == fmtS ? Single : Double
                });
                regs.src1 = Valid(tagged Fpu rs1);
                regs.src2 = Valid(tagged Fpu rs2);
                regs.src3 = Valid(rs3);
                regs.dst = Valid(tagged Fpu rd);
                dInst.csr = Invalid;
                dInst.imm = Invalid;
            end
        end

        MiscMem: begin
            case (funct3)
                fnFENCEI: begin
                    dInst.iType = FenceI;
                    dInst.execFunc = tagged Other;
                end
                fnFENCE: begin
                    // extract bits for P/S IORW
                    Bool old_st = unpack(inst[26] | inst[24]); // PO, PW
                    Bool young_ld = unpack(inst[23] | inst[21]); // SI, SR
                    // get acq/reconcile and rel/commit needed to enforce
                    // different orderings
`ifdef TSO_MM
                    // Orderings enfored by fence in TSO:
                    // St -> Ld: commit
                    // Others: N/A
                    Bool reconcile = False;
                    Bool commit = old_st && young_ld;
`else
                    // Orderings enforced by fence in WMM
                    // St -> St: commit
                    // St -> Ld: commit + reconcile
                    // Ld -> Ld: reconcile
                    // Ld -> St: N/A
                    Bool reconcile = young_ld; // reconcile when younger load is in ordering
                    Bool commit = old_st; // commit when older store is in ordering
`endif
                    // set up fence inst
                    if (reconcile || commit) begin
                        dInst.iType = Fence;
                        dInst.execFunc = tagged Mem (MemInst {
                            mem_func: Fence,
                            amo_func: None,
                            unsignedLd: False,
                            byteEn: replicate(False),
                            aq: reconcile,
                            rl: commit
                        });
                    end
                    else begin
                        dInst.iType = Nop;
                        dInst.execFunc = tagged Other;
                    end
                end
                default: illegalInst = True;
            endcase
            regs.dst  = Invalid;
            regs.src1 = Invalid;
            regs.src2 = Invalid;
            dInst.imm  = Invalid;
            dInst.csr  = Invalid;
        end

        System: begin
            if (funct3 == fnPRIV) begin
                if (funct7 == privSFENCEVMA) begin
                    dInst.iType = SFence;
                    // FIXME SFENCE.VMA is implemented in coarse grain,
                    // ignoring rs1 and rs2
                end
                else begin
                    case (truncate(immI))
                        privSRET: dInst.iType = Sret;
                        privMRET: dInst.iType = Mret;
                        privECALL: dInst.iType = Ecall;
                        privEBREAK: dInst.iType = Ebreak;
                        privWFI: dInst.iType = Nop; // treat as NOP
                        default: illegalInst = True;
                    endcase
                end
                regs.dst  = Invalid;
                regs.src1 = Invalid;
                regs.src2 = Invalid;
                dInst.csr = Invalid;
                dInst.imm = Invalid;
            end
            else begin // fnCSRRWI, fnCSRRW, fnCSRRSI, fnCSRRS, fnCSRRCI, fnCSRRC
                dInst.iType = Csr;
                dInst.execFunc = (case (funct3)
                    fnCSRRWI, fnCSRRW: tagged Alu Csrw;
                    fnCSRRSI, fnCSRRS: tagged Alu Csrs;
                    fnCSRRCI, fnCSRRC: tagged Alu Csrc;
                endcase);

                regs.dst = Valid(tagged Gpr rd);
                regs.src1 = Invalid; // going to be CSR Reg
                regs.src2 = (funct3[2] == 0 ? Valid(tagged Gpr rs1) : Invalid);
                dInst.imm = (funct3[2] == 0 ? Invalid : Valid(zeroExtend(rs1)));
                dInst.csr = Valid(unpackCSR(truncate(immI)));
            end
        end

        OpCHERI: begin
            case (funct3)
                f3_cap_CIncOffsetImmediate: begin
                    dInst.capChecks.src1_unsealed = True;

                    dInst.iType = Alu;
                    regs.dst = Valid(tagged Gpr rd);
                    regs.src1 = Valid(tagged Gpr rs1);
                    dInst.imm = Valid(immI);
                    dInst.execFunc = CapModify (ModifyOffset (IncOffset));
                end
                f3_cap_CSetBoundsImmediate: begin
                    dInst.capChecks.src1_tag = True;
                    dInst.capChecks.src1_unsealed = True;

                    dInst.capChecks.check_enable = True;
                    dInst.capChecks.check_authority_src = Src1;
                    dInst.capChecks.check_low_src = Src1Addr;
                    dInst.capChecks.check_high_src = ResultTop;
                    dInst.capChecks.check_inclusive = True;

                    dInst.iType = Alu;
                    regs.dst = Valid(tagged Gpr rd);
                    regs.src1 = Valid(tagged Gpr rs1);
                    regs.src2 = Invalid;
                    dInst.imm = Valid (immIunsigned);
                    dInst.execFunc = CapModify (SetBounds (SetBounds));
                end
                f3_cap_ThreeOp: begin
                    case (funct7)
                        f7_cap_CSpecialRW: begin
                            // TODO capChecks

                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            regs.src2 = Invalid;
                            dInst.scr = Valid (unpackSCR(rs2));

                            let scrType = case (rs2[1:0])
                                              0: TCC;
                                              3: EPCC;
                                              default: Normal;
                                          endcase;

                            dInst.execFunc = CapModify (SpecialRW (scrType));
                        end
                        f7_cap_CSetBounds: begin
                            dInst.capChecks.src1_tag = True;
                            dInst.capChecks.src1_unsealed = True;

                            dInst.capChecks.check_enable = True;
                            dInst.capChecks.check_authority_src = Src1;
                            dInst.capChecks.check_low_src = Src1Addr;
                            dInst.capChecks.check_high_src = ResultTop;
                            dInst.capChecks.check_inclusive = True;

                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            regs.src2 = Valid(tagged Gpr rs2);
                            dInst.imm = Invalid;
                            dInst.execFunc = CapModify (SetBounds (SetBounds));
                        end
                        f7_cap_CSetBoundsExact: begin
                            illegalInst = True;
                            dInst.capChecks.src1_tag = True;
                            dInst.capChecks.src1_unsealed = True;
                            // TODO assert exact

                            dInst.capChecks.check_enable = True;
                            dInst.capChecks.check_authority_src = Src1;
                            dInst.capChecks.check_low_src = Src1Addr;
                            dInst.capChecks.check_high_src = ResultTop;
                            dInst.capChecks.check_inclusive = True;

                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            regs.src2 = Valid(tagged Gpr rs2);
                            dInst.imm = Invalid;
                            dInst.execFunc = CapModify (SetBounds (SetBounds));
                        end
                        f7_cap_CSetOffset: begin
                            dInst.capChecks.src1_unsealed = True;

                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            regs.src2 = Valid(tagged Gpr rs2);
                            dInst.imm = Invalid;
                            dInst.execFunc = CapModify (ModifyOffset (SetOffset));
                        end
                        f7_cap_CSetAddr: begin
                            dInst.capChecks.src1_unsealed = True;

                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            regs.src2 = Valid(tagged Gpr rs2);
                            dInst.imm = Invalid;
                            dInst.execFunc = CapModify (SetAddr (Src2Addr));
                        end
                        f7_cap_CIncOffset: begin
                            dInst.capChecks.src1_unsealed = True;

                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            regs.src2 = Valid(tagged Gpr rs2);
                            dInst.imm = Invalid;
                            dInst.execFunc = CapModify (ModifyOffset (IncOffset));
                        end
                        f7_cap_CSeal: begin
                            dInst.capChecks.src1_tag = True;
                            dInst.capChecks.src2_tag = True;
                            dInst.capChecks.src1_unsealed = True;
                            dInst.capChecks.src2_unsealed = True;
                            dInst.capChecks.src2_permit_seal = True;
                            dInst.capChecks.src2_addr_valid_type = True;

                            dInst.capChecks.check_enable = True;
                            dInst.capChecks.check_authority_src = Src2;
                            dInst.capChecks.check_low_src = Src2Addr;
                            dInst.capChecks.check_high_src = Src2Addr;
                            dInst.capChecks.check_inclusive = False;

                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            regs.src2 = Valid(tagged Gpr rs2);
                            dInst.imm = Invalid;
                            dInst.execFunc = CapModify (Seal);
                        end
                        f7_cap_CCSeal: begin
                            illegalInst = True;
                            // TODO problematic because checks depend on register value
                        end
                        f7_cap_TwoSrc: begin
                            case (rd)
                                rd_cap_CCall: begin
                                    dInst.capChecks.src1_tag = True;
                                    dInst.capChecks.src2_tag = True;
                                    dInst.capChecks.src1_sealed = True;
                                    dInst.capChecks.src2_sealed = True;
                                    dInst.capChecks.src1_src2_types_match = True;
                                    dInst.capChecks.src1_permit_x = True;
                                    dInst.capChecks.src2_no_permit_x = True;
                                    dInst.capChecks.src1_permit_ccall = True;
                                    dInst.capChecks.src2_permit_ccall = True;

                                    dInst.iType = Jr;
                                    dInst.execFunc = tagged Br AT;
                                    regs.dst = Valid(tagged Gpr 31);
                                    regs.src1 = Valid(tagged Gpr rs1);
                                    regs.src2 = Valid(tagged Gpr rs2);
                                    dInst.imm = Invalid;
                                end
                                default: begin
                                    illegalInst = True;
                                end
                            endcase
                        end
                        f7_cap_CUnseal: begin
                            dInst.capChecks.src1_tag = True;
                            dInst.capChecks.src2_tag = True;
                            dInst.capChecks.src1_sealed_with_type = True;
                            dInst.capChecks.src2_unsealed = True;
                            dInst.capChecks.src2_points_to_src1_type = True;
                            dInst.capChecks.src2_permit_unseal = True;

                            dInst.capChecks.check_enable = True;
                            dInst.capChecks.check_authority_src = Src2;
                            dInst.capChecks.check_low_src = Src2Addr;
                            dInst.capChecks.check_high_src = Src2Addr;
                            dInst.capChecks.check_inclusive = False;

                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            regs.src2 = Valid(tagged Gpr rs2);
                            dInst.imm = Invalid;
                            dInst.execFunc = CapModify (Unseal (Src1));
                        end
                        f7_cap_CTestSubset: begin
                            illegalInst = True;
                            // TODO
                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            regs.src2 = Valid(tagged Gpr rs2);
                            dInst.imm = Invalid;
                            dInst.execFunc = CapInspect (TestSubset);
                        end
                        f7_cap_CCopyType: begin
                            dInst.capChecks.src1_tag = True;
                            dInst.capChecks.src1_unsealed = True;

                            dInst.capChecks.check_enable = True;
                            dInst.capChecks.check_authority_src = Src1;
                            dInst.capChecks.check_low_src = Src2Type;
                            dInst.capChecks.check_high_src = Src2Type;
                            dInst.capChecks.check_inclusive = False;

                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            regs.src2 = Valid(tagged Gpr rs2);
                            dInst.imm = Invalid;
                            dInst.execFunc = CapModify (SetAddr (Src2Type));
                        end
                        f7_cap_CAndPerm: begin
                            dInst.capChecks.src1_tag = True;
                            dInst.capChecks.src1_unsealed = True;

                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            regs.src2 = Valid(tagged Gpr rs2);
                            dInst.imm = Invalid;
                            dInst.execFunc = CapModify (AndPerm);
                        end
                        f7_cap_CSetFlags: begin
                            dInst.capChecks.src1_unsealed = True;

                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            regs.src2 = Valid(tagged Gpr rs2);
                            dInst.imm = Invalid;
                            dInst.execFunc = CapModify (SetFlags);
                        end
                        f7_cap_CToPtr: begin
                            dInst.capChecks.src1_unsealed = True;
                            dInst.capChecks.src2_tag = True;

                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            if (rs2 == 0) begin
                                regs.src2 = Invalid;
                                dInst.scr = Valid (SCR_DDC);
                            end else begin
                                regs.src2 = Valid (tagged Gpr rs2);
                                dInst.scr = Invalid;
                            end
                            dInst.imm = Invalid;
                            dInst.execFunc = CapInspect (ToPtr);
                        end
                        f7_cap_CFromPtr: begin
                            illegalInst = True;
                            //TODO these should only be checked when b non-zero
                            dInst.capChecks.src1_tag = True;
                            dInst.capChecks.src1_unsealed = True;

                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            regs.src2 = Valid(tagged Gpr rs2);
                            dInst.imm = Invalid;
                            dInst.execFunc = CapModify (SetAddr (Src2Addr));
                        end
                        f7_cap_CSub: begin
                            // CSub is just a riscv subtract
                            dInst.iType = Alu;
                            regs.dst  = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs1);
                            regs.src2 = Valid(tagged Gpr rs2);
                            dInst.imm = Invalid;
                            dInst.csr = Invalid;
                            dInst.execFunc = Alu (Sub);
                        end
                        f7_cap_CBuildCap: begin
                            dInst.capChecks.src2_tag = True;
                            dInst.capChecks.src2_unsealed = True;
                            dInst.capChecks.src1_perm_subset_src2 = True;
                            dInst.capChecks.src1_derivable = True;

                            dInst.capChecks.check_enable = True;
                            dInst.capChecks.check_authority_src = Src2;
                            dInst.capChecks.check_low_src = Src1Base;
                            dInst.capChecks.check_high_src = Src1Top;
                            dInst.capChecks.check_inclusive = True;

                            // Swap arguments so SCR possibly goes in RS2
                            dInst.iType = Alu;
                            regs.dst = Valid(tagged Gpr rd);
                            regs.src1 = Valid(tagged Gpr rs2);
                            if (rs1 == 0) begin
                                dInst.scr = Valid(SCR_DDC);
                            end else begin
                                regs.src2 = Valid(tagged Gpr rs1);
                            end
                            dInst.imm = Invalid;
                            dInst.execFunc = CapModify (BuildCap);
                        end
                        f7_cap_Loads: begin
                            illegalInst = True;
                            //TODO
                        end
                        f7_cap_Stores: begin
                            illegalInst = True;
                            //TODO
                        end
                        f7_cap_TwoOp: begin
                            case (funct5rs2)
                                f5rs2_cap_CGetLen: begin
                                    dInst.iType = Alu;
                                    regs.dst = Valid(tagged Gpr rd);
                                    regs.src1 = Valid(tagged Gpr rs1);
                                    dInst.imm = Invalid;
                                    dInst.execFunc = CapInspect (GetLen);
                                end
                                f5rs2_cap_CGetBase: begin
                                    dInst.iType = Alu;
                                    regs.dst = Valid(tagged Gpr rd);
                                    regs.src1 = Valid(tagged Gpr rs1);
                                    dInst.imm = Invalid;
                                    dInst.execFunc = CapInspect (GetBase);
                                end
                                f5rs2_cap_CGetTag: begin
                                    dInst.iType = Alu;
                                    regs.dst = Valid(tagged Gpr rd);
                                    regs.src1 = Valid(tagged Gpr rs1);
                                    dInst.imm = Invalid;
                                    dInst.execFunc = CapInspect (GetTag);
                                end
                                f5rs2_cap_CGetSealed: begin
                                    dInst.iType = Alu;
                                    regs.dst = Valid(tagged Gpr rd);
                                    regs.src1 = Valid(tagged Gpr rs1);
                                    dInst.imm = Invalid;
                                    dInst.execFunc = CapInspect (GetSealed);
                                end
                                f5rs2_cap_CRRL: begin
                                     dInst.iType = Alu;
                                     regs.dst = Valid(tagged Gpr rd);
                                     regs.src1 = Valid(tagged Gpr 0); // Operate on nullcap
                                     regs.src2 = Valid(tagged Gpr rs1);
                                     dInst.imm = Invalid;
                                     dInst.execFunc = CapModify (SetBounds (CRRL));
                                end
                                f5rs2_cap_CRAM: begin
                                    dInst.iType = Alu;
                                    regs.dst = Valid(tagged Gpr rd);
                                    regs.src1 = Valid(tagged Gpr 0); // Operate on nullcap
                                    regs.src2 = Valid(tagged Gpr rs1);
                                    dInst.imm = Invalid;
                                    dInst.execFunc = CapModify (SetBounds (CRAM));
                                end
                                f5rs2_cap_CMove: begin
                                    dInst.iType = Alu;
                                    regs.dst = Valid(tagged Gpr rd);
                                    regs.src1 = Valid(tagged Gpr rs1);
                                    dInst.imm = Invalid;
                                    dInst.execFunc = CapModify (Move);
                                end
                                f5rs2_cap_CClearTag: begin
                                    dInst.iType = Alu;
                                    regs.dst = Valid(tagged Gpr rd);
                                    regs.src1 = Valid(tagged Gpr rs1);
                                    dInst.imm = Invalid;
                                    dInst.execFunc = CapModify (ClearTag);
                                end
                                f5rs2_cap_CGetAddr: begin
                                    dInst.iType = Alu;
                                    regs.dst = Valid(tagged Gpr rd);
                                    regs.src1 = Valid(tagged Gpr rs1);
                                    dInst.imm = Invalid;
                                    dInst.execFunc = CapInspect (GetAddr);
                                end
                                f5rs2_cap_CGetOffset: begin
                                    dInst.iType = Alu;
                                    regs.dst = Valid(tagged Gpr rd);
                                    regs.src1 = Valid(tagged Gpr rs1);
                                    dInst.imm = Invalid;
                                    dInst.execFunc = CapInspect (GetOffset);
                                end
                                f5rs2_cap_CGetFlags: begin
                                    dInst.iType = Alu;
                                    regs.dst = Valid(tagged Gpr rd);
                                    regs.src1 = Valid(tagged Gpr rs1);
                                    dInst.imm = Invalid;
                                    dInst.execFunc = CapInspect (GetFlags);
                                end
                                f5rs2_cap_CGetPerm: begin
                                    dInst.iType = Alu;
                                    regs.dst = Valid(tagged Gpr rd);
                                    regs.src1 = Valid(tagged Gpr rs1);
                                    dInst.imm = Invalid;
                                    dInst.execFunc = CapInspect (GetPerm);
                                end
                                f5rs2_cap_CJALR: begin
                                    dInst.capChecks.src1_tag = True;
                                    dInst.capChecks.src1_permit_x = True;
                                    dInst.capChecks.src1_unsealed = True;

                                    dInst.capChecks.check_enable = True;
                                    dInst.capChecks.check_authority_src = Src1;
                                    dInst.capChecks.check_low_src = Src1Addr;
                                    dInst.capChecks.check_high_src = Src1AddrPlus2;
                                    dInst.capChecks.check_inclusive = True;

                                    dInst.iType = Jr;
                                    dInst.execFunc = tagged Br AT;
                                    regs.dst  = Valid(tagged Gpr rd);
                                    regs.src1 = Valid(tagged Gpr rs1);
                                    regs.src2 = Invalid;
                                    dInst.imm = Invalid;
                                end
                                f5rs2_cap_CGetType: begin
                                    dInst.iType = Alu;
                                    regs.dst = Valid(tagged Gpr rd);
                                    regs.src1 = Valid(tagged Gpr rs1);
                                    dInst.imm = Invalid;
                                    dInst.execFunc = CapInspect (GetType);
                                end
                                default: begin
                                    illegalInst = True;
                                end
                            endcase
                        end
                        default: begin
                            illegalInst = True;
                        end
                    endcase
                end
                default: begin
                    illegalInst = True;
                end
            endcase
            dInst.capChecks.rn1 = {1'b0, regs.src1.Valid.Gpr};
            dInst.capChecks.rn2 = {1'b0, regs.src2.Valid.Gpr};
        end
        default: begin
            illegalInst = True;
        end
    endcase

    // XXX to ensure renaming + phy regs works correctly, must remove any write
    // to x0
    if(regs.dst matches tagged Valid .dst &&& dst == tagged Gpr 0) begin
        regs.dst = tagged Invalid;
    end

    return DecodeResult{dInst: dInst, regs: regs, illegalInst: illegalInst};
endfunction

// All this does is add the CSR state to the decoding
function FpuInst updateRoundingMode(FpuInst fpu_f, CsrDecodeInfo csrState);
    let new_fpu_f = fpu_f;
    new_fpu_f.rm = (fpu_f.rm == RDyn) ? unpack(csrState.frm) : fpu_f.rm;
    return new_fpu_f;
endfunction
