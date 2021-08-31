@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=func_overlapMaxProjectionStack_mex
set MEX_NAME=func_overlapMaxProjectionStack_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for func_overlapMaxProjectionStack > func_overlapMaxProjectionStack_mex.mki
echo COMPILER=%COMPILER%>> func_overlapMaxProjectionStack_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> func_overlapMaxProjectionStack_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> func_overlapMaxProjectionStack_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> func_overlapMaxProjectionStack_mex.mki
echo LINKER=%LINKER%>> func_overlapMaxProjectionStack_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> func_overlapMaxProjectionStack_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> func_overlapMaxProjectionStack_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> func_overlapMaxProjectionStack_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> func_overlapMaxProjectionStack_mex.mki
echo OMPFLAGS= >> func_overlapMaxProjectionStack_mex.mki
echo OMPLINKFLAGS= >> func_overlapMaxProjectionStack_mex.mki
echo EMC_COMPILER=msvc110>> func_overlapMaxProjectionStack_mex.mki
echo EMC_CONFIG=optim>> func_overlapMaxProjectionStack_mex.mki
"C:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f func_overlapMaxProjectionStack_mex.mk
