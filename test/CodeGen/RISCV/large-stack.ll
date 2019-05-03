; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I-FPELIM %s
; RUN: llc -mtriple=riscv32 -verify-machineinstrs -frame-pointer=all < %s \
; RUN:   | FileCheck -check-prefix=RV32I-WITHFP %s

; TODO: the quality of the generated code is poor

define void @test() nounwind {
; RV32I-FPELIM-LABEL: test:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: test:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    addi sp, sp, -16
; RV32I-WITHFP-NEXT:    sw ra, 12(sp)
; RV32I-WITHFP-NEXT:    sw s0, 8(sp)
; RV32I-WITHFP-NEXT:    addi s0, sp, 16
; RV32I-WITHFP-NEXT:    lw s0, 8(sp)
; RV32I-WITHFP-NEXT:    lw ra, 12(sp)
; RV32I-WITHFP-NEXT:    addi sp, sp, 16
; RV32I-WITHFP-NEXT:    ret
  %tmp = alloca [ 305419896 x i8 ] , align 4
  ret void
}

; This test case artificially produces register pressure which should force
; use of the emergency spill slot.

define void @test_emergency_spill_slot(i32 %a) nounwind {
; RV32I-FPELIM-LABEL: test_emergency_spill_slot:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    lui a1, 98
; RV32I-FPELIM-NEXT:    addi a1, a1, -1392
; RV32I-FPELIM-NEXT:    sub sp, sp, a1
; RV32I-FPELIM-NEXT:    lui a1, 98
; RV32I-FPELIM-NEXT:    addi a1, a1, -1396
; RV32I-FPELIM-NEXT:    add a1, sp, a1
; RV32I-FPELIM-NEXT:    sw s0, 0(a1)
; RV32I-FPELIM-NEXT:    lui a1, 98
; RV32I-FPELIM-NEXT:    addi a1, a1, -1400
; RV32I-FPELIM-NEXT:    add a1, sp, a1
; RV32I-FPELIM-NEXT:    sw s1, 0(a1)
; RV32I-FPELIM-NEXT:    lui a1, 78
; RV32I-FPELIM-NEXT:    addi a1, a1, 512
; RV32I-FPELIM-NEXT:    addi a2, sp, 8
; RV32I-FPELIM-NEXT:    add a1, a2, a1
; RV32I-FPELIM-NEXT:    #APP
; RV32I-FPELIM-NEXT:    nop
; RV32I-FPELIM-NEXT:    #NO_APP
; RV32I-FPELIM-NEXT:    sw a0, 0(a1)
; RV32I-FPELIM-NEXT:    #APP
; RV32I-FPELIM-NEXT:    nop
; RV32I-FPELIM-NEXT:    #NO_APP
; RV32I-FPELIM-NEXT:    lui a0, 98
; RV32I-FPELIM-NEXT:    addi a0, a0, -1400
; RV32I-FPELIM-NEXT:    add a0, sp, a0
; RV32I-FPELIM-NEXT:    lw s1, 0(a0)
; RV32I-FPELIM-NEXT:    lui a0, 98
; RV32I-FPELIM-NEXT:    addi a0, a0, -1396
; RV32I-FPELIM-NEXT:    add a0, sp, a0
; RV32I-FPELIM-NEXT:    lw s0, 0(a0)
; RV32I-FPELIM-NEXT:    lui a0, 98
; RV32I-FPELIM-NEXT:    addi a0, a0, -1392
; RV32I-FPELIM-NEXT:    add sp, sp, a0
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: test_emergency_spill_slot:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    lui a1, 98
; RV32I-WITHFP-NEXT:    addi a1, a1, -1376
; RV32I-WITHFP-NEXT:    sub sp, sp, a1
; RV32I-WITHFP-NEXT:    lui a1, 98
; RV32I-WITHFP-NEXT:    addi a1, a1, -1380
; RV32I-WITHFP-NEXT:    add a1, sp, a1
; RV32I-WITHFP-NEXT:    sw ra, 0(a1)
; RV32I-WITHFP-NEXT:    lui a1, 98
; RV32I-WITHFP-NEXT:    addi a1, a1, -1384
; RV32I-WITHFP-NEXT:    add a1, sp, a1
; RV32I-WITHFP-NEXT:    sw s0, 0(a1)
; RV32I-WITHFP-NEXT:    lui a1, 98
; RV32I-WITHFP-NEXT:    addi a1, a1, -1388
; RV32I-WITHFP-NEXT:    add a1, sp, a1
; RV32I-WITHFP-NEXT:    sw s1, 0(a1)
; RV32I-WITHFP-NEXT:    lui a1, 98
; RV32I-WITHFP-NEXT:    addi a1, a1, -1392
; RV32I-WITHFP-NEXT:    add a1, sp, a1
; RV32I-WITHFP-NEXT:    sw s2, 0(a1)
; RV32I-WITHFP-NEXT:    lui a1, 98
; RV32I-WITHFP-NEXT:    addi a1, a1, -1376
; RV32I-WITHFP-NEXT:    add s0, sp, a1
; RV32I-WITHFP-NEXT:    lui a1, 78
; RV32I-WITHFP-NEXT:    addi a1, a1, 512
; RV32I-WITHFP-NEXT:    lui a2, 1048478
; RV32I-WITHFP-NEXT:    addi a2, a2, 1388
; RV32I-WITHFP-NEXT:    add a2, s0, a2
; RV32I-WITHFP-NEXT:    mv a2, a2
; RV32I-WITHFP-NEXT:    add a1, a2, a1
; RV32I-WITHFP-NEXT:    #APP
; RV32I-WITHFP-NEXT:    nop
; RV32I-WITHFP-NEXT:    #NO_APP
; RV32I-WITHFP-NEXT:    sw a0, 0(a1)
; RV32I-WITHFP-NEXT:    #APP
; RV32I-WITHFP-NEXT:    nop
; RV32I-WITHFP-NEXT:    #NO_APP
; RV32I-WITHFP-NEXT:    lui a0, 98
; RV32I-WITHFP-NEXT:    addi a0, a0, -1392
; RV32I-WITHFP-NEXT:    add a0, sp, a0
; RV32I-WITHFP-NEXT:    lw s2, 0(a0)
; RV32I-WITHFP-NEXT:    lui a0, 98
; RV32I-WITHFP-NEXT:    addi a0, a0, -1388
; RV32I-WITHFP-NEXT:    add a0, sp, a0
; RV32I-WITHFP-NEXT:    lw s1, 0(a0)
; RV32I-WITHFP-NEXT:    lui a0, 98
; RV32I-WITHFP-NEXT:    addi a0, a0, -1384
; RV32I-WITHFP-NEXT:    add a0, sp, a0
; RV32I-WITHFP-NEXT:    lw s0, 0(a0)
; RV32I-WITHFP-NEXT:    lui a0, 98
; RV32I-WITHFP-NEXT:    addi a0, a0, -1380
; RV32I-WITHFP-NEXT:    add a0, sp, a0
; RV32I-WITHFP-NEXT:    lw ra, 0(a0)
; RV32I-WITHFP-NEXT:    lui a0, 98
; RV32I-WITHFP-NEXT:    addi a0, a0, -1376
; RV32I-WITHFP-NEXT:    add sp, sp, a0
; RV32I-WITHFP-NEXT:    ret
  %data = alloca [ 100000 x i32 ] , align 4
  %ptr = getelementptr inbounds [100000 x i32], [100000 x i32]* %data, i32 0, i32 80000
  %1 = tail call { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } asm sideeffect "nop", "=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r"()
  %asmresult0 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 0
  %asmresult1 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 1
  %asmresult2 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 2
  %asmresult3 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 3
  %asmresult4 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 4
  %asmresult5 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 5
  %asmresult6 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 6
  %asmresult7 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 7
  %asmresult8 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 8
  %asmresult9 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 9
  %asmresult10 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 10
  %asmresult11 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 11
  %asmresult12 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 12
  %asmresult13 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 13
  %asmresult14 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %1, 14
  store volatile i32 %a, i32* %ptr
  tail call void asm sideeffect "nop", "r,r,r,r,r,r,r,r,r,r,r,r,r,r,r"(i32 %asmresult0, i32 %asmresult1, i32 %asmresult2, i32 %asmresult3, i32 %asmresult4, i32 %asmresult5, i32 %asmresult6, i32 %asmresult7, i32 %asmresult8, i32 %asmresult9, i32 %asmresult10, i32 %asmresult11, i32 %asmresult12, i32 %asmresult13, i32 %asmresult14)
  ret void
}
