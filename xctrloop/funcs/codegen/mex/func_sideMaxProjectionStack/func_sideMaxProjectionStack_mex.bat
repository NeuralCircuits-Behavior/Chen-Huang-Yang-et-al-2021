@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=func_sideMaxProjectionStack_mex
set MEX_NAME=func_sideMaxProjectionStack_mex
set MEX_EXT=.mexw64
call "C:\PROGRA~1\MATLAB\R2017b\sys\lcc64\lcc64\mex\lcc64opts.bat"
echo # Make settings for func_sideMaxProjectionStack > func_sideMaxProjectionStack_mex.mki
echo COMPILER=%COMPILER%>> func_sideMaxProjectionStack_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> func_sideMaxProjectionStack_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> func_sideMaxProjectionStack_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> func_sideMaxProjectionStack_mex.mki
echo LINKER=%LINKER%>> func_sideMaxProjectionStack_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> func_sideMaxProjectionStack_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> func_sideMaxProjectionStack_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> func_sideMaxProjectionStack_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> func_sideMaxProjectionStack_mex.mki
echo OMPFLAGS= >> func_sideMaxProjectionStack_mex.mki
echo OMPLINKFLAGS= >> func_sideMaxProjectionStack_mex.mki
echo EMC_COMPILER=lcc64>> func_sideMaxProjectionStack_mex.mki
echo EMC_CONFIG=optim>> func_sideMaxProjectionStack_mex.mki
"C:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f func_sideMaxProjectionStack_mex.mk
