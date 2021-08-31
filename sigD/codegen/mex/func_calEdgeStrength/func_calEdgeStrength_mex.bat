@echo off
set MATLAB=E:\Prog\MATLAB\2018b
set MATLAB_ARCH=win64
set MATLAB_BIN="E:\Prog\MATLAB\2018b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=func_calEdgeStrength_mex
set MEX_NAME=func_calEdgeStrength_mex
set MEX_EXT=.mexw64
call "E:\Prog\MATLAB\2018b\sys\lcc64\lcc64\mex\lcc64opts.bat"
echo # Make settings for func_calEdgeStrength > func_calEdgeStrength_mex.mki
echo COMPILER=%COMPILER%>> func_calEdgeStrength_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> func_calEdgeStrength_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> func_calEdgeStrength_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> func_calEdgeStrength_mex.mki
echo LINKER=%LINKER%>> func_calEdgeStrength_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> func_calEdgeStrength_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> func_calEdgeStrength_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> func_calEdgeStrength_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> func_calEdgeStrength_mex.mki
echo OMPFLAGS= >> func_calEdgeStrength_mex.mki
echo OMPLINKFLAGS= >> func_calEdgeStrength_mex.mki
echo EMC_COMPILER=lcc64>> func_calEdgeStrength_mex.mki
echo EMC_CONFIG=optim>> func_calEdgeStrength_mex.mki
"E:\Prog\MATLAB\2018b\bin\win64\gmake" -j 1 -B -f func_calEdgeStrength_mex.mk
