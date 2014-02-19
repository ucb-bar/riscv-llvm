//===-- RISCVSubtarget.h - RISCV subtarget information -----*- C++ -*--===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file declares the RISCV specific subclass of TargetSubtargetInfo.
//
//===----------------------------------------------------------------------===//

#ifndef RISCVSUBTARGET_H
#define RISCVSUBTARGET_H

#include "llvm/ADT/Triple.h"
#include "llvm/Target/TargetSubtargetInfo.h"
#include <string>

#define GET_SUBTARGETINFO_HEADER
#include "RISCVGenSubtargetInfo.inc"

namespace llvm {
class GlobalValue;
class StringRef;

class RISCVSubtarget : public RISCVGenSubtargetInfo {
private:
  Triple TargetTriple;

protected:
  enum RISCVArchEnum {
    RV32,
    RV64
  };

  RISCVArchEnum RISCVArchVersion;

  bool HasM;
  bool HasA;
  bool HasF;
  bool HasD;

public:
  RISCVSubtarget(const std::string &TT, const std::string &CPU,
                   const std::string &FS);

  bool isRV32() const { return RISCVArchVersion == RV32; };
  bool isRV64() const { return RISCVArchVersion == RV64; };

  bool hasM() const { return HasM; };
  bool hasA() const { return HasA; };
  bool hasF() const { return HasF; };
  bool hasD() const { return HasD; };

  // Automatically generated by tblgen.
  void ParseSubtargetFeatures(StringRef CPU, StringRef FS);

  // Return true if GV can be accessed using LARL for reloc model RM
  // and code model CM.
  bool isPC32DBLSymbol(const GlobalValue *GV, Reloc::Model RM,
                       CodeModel::Model CM) const;

  bool isTargetELF() const { return TargetTriple.isOSBinFormatELF(); }
};
} // end namespace llvm

#endif
