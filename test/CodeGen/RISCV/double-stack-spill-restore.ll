; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IFD %s
; RUN: llc -mtriple=riscv64 -mattr=+d -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IFD %s

define double @func(double %d, i32 %n) nounwind {
; RV32IFD-LABEL: func:
; RV32IFD:       # %bb.0: # %entry
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw ra, 28(sp)
; RV32IFD-NEXT:    sw a0, 16(sp)
; RV32IFD-NEXT:    sw a1, 20(sp)
; RV32IFD-NEXT:    fld ft0, 16(sp)
; RV32IFD-NEXT:    beqz a2, .LBB0_2
; RV32IFD-NEXT:  # %bb.1: # %if.else
; RV32IFD-NEXT:    addi a2, a2, -1
; RV32IFD-NEXT:    fsd ft0, 16(sp)
; RV32IFD-NEXT:    lw a0, 16(sp)
; RV32IFD-NEXT:    lw a1, 20(sp)
; RV32IFD-NEXT:    fsd ft0, 8(sp)
; RV32IFD-NEXT:    call func
; RV32IFD-NEXT:    sw a0, 16(sp)
; RV32IFD-NEXT:    sw a1, 20(sp)
; RV32IFD-NEXT:    fld ft0, 16(sp)
; RV32IFD-NEXT:    fld ft1, 8(sp)
; RV32IFD-NEXT:    fadd.d ft0, ft0, ft1
; RV32IFD-NEXT:    fsd ft0, 16(sp)
; RV32IFD-NEXT:    lw a0, 16(sp)
; RV32IFD-NEXT:    lw a1, 20(sp)
; RV32IFD-NEXT:    lw ra, 28(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
; RV32IFD-NEXT:  .LBB0_2: # %return
; RV32IFD-NEXT:    fsd ft0, 16(sp)
; RV32IFD-NEXT:    lw a0, 16(sp)
; RV32IFD-NEXT:    lw a1, 20(sp)
; RV32IFD-NEXT:    lw ra, 28(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: func:
; RV64IFD:       # %bb.0: # %entry
; RV64IFD-NEXT:    addi sp, sp, -16
; RV64IFD-NEXT:    sd ra, 8(sp)
; RV64IFD-NEXT:    fmv.d.x ft0, a0
; RV64IFD-NEXT:    slli a0, a1, 32
; RV64IFD-NEXT:    srli a0, a0, 32
; RV64IFD-NEXT:    beqz a0, .LBB0_2
; RV64IFD-NEXT:  # %bb.1: # %if.else
; RV64IFD-NEXT:    addi a1, a1, -1
; RV64IFD-NEXT:    fmv.x.d a0, ft0
; RV64IFD-NEXT:    fsd ft0, 0(sp)
; RV64IFD-NEXT:    call func
; RV64IFD-NEXT:    fmv.d.x ft0, a0
; RV64IFD-NEXT:    fld ft1, 0(sp)
; RV64IFD-NEXT:    fadd.d ft0, ft0, ft1
; RV64IFD-NEXT:    fmv.x.d a0, ft0
; RV64IFD-NEXT:    ld ra, 8(sp)
; RV64IFD-NEXT:    addi sp, sp, 16
; RV64IFD-NEXT:    ret
; RV64IFD-NEXT:  .LBB0_2: # %return
; RV64IFD-NEXT:    fmv.x.d a0, ft0
; RV64IFD-NEXT:    ld ra, 8(sp)
; RV64IFD-NEXT:    addi sp, sp, 16
; RV64IFD-NEXT:    ret
entry:
  %cmp = icmp eq i32 %n, 0
  br i1 %cmp, label %return, label %if.else

if.else:
  %sub = add i32 %n, -1
  %call = tail call double @func(double %d, i32 %sub)
  %add = fadd double %call, %d
  ret double %add

return:
  ret double %d
}
