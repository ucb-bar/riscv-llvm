; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s

; This test checks that LLVM can do basic stripping and reapplying of branches
; to basic blocks.

declare void @test_true()
declare void @test_false()

; !0 corresponds to a branch being taken, !1 to not being takne.
!0 = !{!"branch_weights", i32 64, i32 4}
!1 = !{!"branch_weights", i32 4, i32 64}

define void @test_bcc_fallthrough_taken(i32 %in) nounwind {
; RV32I-LABEL: test_bcc_fallthrough_taken:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    addi a1, zero, 42
; RV32I-NEXT:    bne a0, a1, .LBB0_2
; RV32I-NEXT:  # %bb.1: # %true
; RV32I-NEXT:    call test_true
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB0_2: # %false
; RV32I-NEXT:    call test_false
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
  %tst = icmp eq i32 %in, 42
  br i1 %tst, label %true, label %false, !prof !0

; Expected layout order is: Entry, TrueBlock, FalseBlock
; Entry->TrueBlock is the common path, which should be taken whenever the
; conditional branch is false.

true:
  call void @test_true()
  ret void

false:
  call void @test_false()
  ret void
}

define void @test_bcc_fallthrough_nottaken(i32 %in) nounwind {
; RV32I-LABEL: test_bcc_fallthrough_nottaken:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    addi a1, zero, 42
; RV32I-NEXT:    beq a0, a1, .LBB1_2
; RV32I-NEXT:  # %bb.1: # %false
; RV32I-NEXT:    call test_false
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB1_2: # %true
; RV32I-NEXT:    call test_true
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
  %tst = icmp eq i32 %in, 42
  br i1 %tst, label %true, label %false, !prof !1

; Expected layout order is: Entry, FalseBlock, TrueBlock
; Entry->FalseBlock is the common path, which should be taken whenever the
; conditional branch is false

true:
  call void @test_true()
  ret void

false:
  call void @test_false()
  ret void
}

; TODO: how can we expand the coverage of the branch analysis functions?
