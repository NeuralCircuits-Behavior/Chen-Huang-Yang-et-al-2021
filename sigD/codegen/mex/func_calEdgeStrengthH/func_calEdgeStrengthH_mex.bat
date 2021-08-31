@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=func_calEdgeStrengthH_mex
set MEX_NAME=func_calEdgeStrengthH_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for func_calEdgeStrengthH > func_calEdgeStrengthH_mex.mki
echo COMPILER=%COMPILER%>> func_calEdgeStrengthH_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> func_calEdgeStrengthH_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> func_calEdgeStrengthH_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> func_calEdgeStrengthH_mex.mki
echo LINKER=%LINKER%>> func_calEdgeStrengthH_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> func_calEdgeStrengthH_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> func_calEdgeStrengthH_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> func_calEdgeStrengthH_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> func_calEdgeStrengthH_mex.mki
echo OMPFLAGS= >> func_calEdgeStrengthH_mex.mki
echo OMPLINKFLAGS= >> func_calEdgeStrengthH_mex.mki
echo EMC_COMPILER=msvc110>> func_calEdgeStrengthH_mex.mki
echo EMC_CONFIG=optim>> func_calEdgeStrengthH_mex.mki
"C:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f func_calEdgeStrengthH_mex.mk
