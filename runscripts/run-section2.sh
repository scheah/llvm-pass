#!/bin/bash

CPPFLAGS=
LLVMLIBS=
LDFLAGS=
# if your instrumentation code calls into LLVM libraries, then comment out the above and use these instead:
#CPPFLAGS=`llvm-config --cppflags`
#LLVMLIBS=`llvm-config --libs`
#LDFLAGS=`llvm-config --ldflags`

filename=$(basename "$1")

opt -load $LLVMLIB/CSE231.so -dynamic < $1/$filename.bc > $1/$filename.pass.bc

## compile the instrumentation module to bitcode
clang $CPPFLAGS -O0 -emit-llvm -c $INSTRUMENTATION/dynamic/CountDynamicInstructionsInstrumentation.cpp -o $INSTRUMENTATION/dynamic/CountDynamicInstructionsInstrumentation.bc

## link instrumentation module
llvm-link $1/$filename.pass.bc $INSTRUMENTATION/dynamic/CountDynamicInstructionsInstrumentation.bc -o $INSTRUMENTATION/dynamic/$filename.linked.bc

## compile to native object file
llc -filetype=obj $INSTRUMENTATION/dynamic/$filename.linked.bc -o=$INSTRUMENTATION/dynamic/$filename.o

## generate native executable
g++ $INSTRUMENTATION/dynamic/$filename.o $LLVMLIBS $LDFLAGS -o $INSTRUMENTATION/dynamic/$filename.exe

pushd . > /dev/null
cd $BENCHMARKS/$filename
$INSTRUMENTATION/dynamic/$filename.exe > $OUTPUTLOGS/$filename.dynamic.log
popd > /dev/null

