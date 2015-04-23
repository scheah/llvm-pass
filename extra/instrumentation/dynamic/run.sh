#!/usr/bin/env bash
# linking example

CPPFLAGS=
LLVMLIBS=
LDFLAGS=
# if your instrumentation code calls into LLVM libraries, then comment out the above and use these instead:
#CPPFLAGS=`llvm-config --cppflags`
#LLVMLIBS=`llvm-config --libs`
#LDFLAGS=`llvm-config --ldflags`

## compile the instrumentation module to bitcode
clang $CPPFLAGS -O0 -emit-llvm -c CountDynamicInstructionsInstrumentation.cpp -o CountDynamicInstructionsInstrumentation.bc

## link instrumentation module
#llvm-link $BENCHMARKS/welcome/welcome.bc CountDynamicInstructionsInstrumentation.bc -o welcome.linked.bc
llvm-link $CSE231ROOT/foo.bc CountDynamicInstructionsInstrumentation.bc -o welcome.linked.bc

## compile to native object file
llc -filetype=obj welcome.linked.bc -o=welcome.o

## generate native executable
g++ welcome.o $LLVMLIBS $LDFLAGS -o welcome.exe

./welcome.exe

