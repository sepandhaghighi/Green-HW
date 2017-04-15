@echo off
rem ============================================================================
rem Copyright 2001-2017 Intel Corporation All Rights Reserved.
rem
rem The source code,  information and material ("Material")  contained herein is
rem owned by Intel Corporation or its suppliers or licensors,  and title to such
rem Material remains with Intel Corporation or its suppliers  or licensors.  The
rem Material contains  proprietary  information  of Intel  or its  suppliers and
rem licensors.  The Material is protected by worldwide copyright laws and treaty
rem provisions.  No part  of the  Material   may be  used,  copied,  reproduced,
rem modified,  published,   uploaded,   posted,   transmitted,   distributed  or
rem disclosed in any way without Intel's prior  express written  permission.  No
rem license under any patent,  copyright  or other intellectual  property rights
rem in the Material is granted to or conferred upon you,  either  expressly,  by
rem implication,  inducement,  estoppel  or otherwise.  Any  license  under such
rem intellectual  property  rights must  be  express and  approved  by  Intel in
rem writing.
rem
rem Unless otherwise  agreed by  Intel in writing,  you may not  remove or alter
rem this notice or  any other notice  embedded in Materials by  Intel or Intel's
rem suppliers or licensors in any way.
rem ============================================================================

echo    This is a SAMPLE run script for SMP LINPACK.  Change it to reflect
echo    the correct number of CPUs/threads, problem input files, etc..

SETLOCAL

rem Turn on Automatic Offload
SET MKL_MIC_ENABLE=1

rem Setting path to OpenMP library
set PATH=..\..\..\redist\intel64\compiler;%PATH%
set PATH=..\..\..\redist\intel64_win\compiler;%PATH%
rem Setting path to binaries for Intel(R) Xeon Phi(TM) coprocessor side (libmkl_ao_worker.so and libiomp5.so)
SET MIC_LD_LIBRARY_PATH=..\..\lib\mic;..\..\..\compiler\lib\mic;%MIC_LD_LIBRARY_PATH%
SET MIC_LD_LIBRARY_PATH=..\..\lib\intel64_win_mic;..\..\..\compiler\lib\intel64_win_mic;%MIC_LD_LIBRARY_PATH%

rem Setting up affinity for better threading performance
set KMP_AFFINITY=nowarnings,compact,1,0,granularity=fine
rem Setting up affinity for better threading performance on Intel(R) Xeon Phi(TM) coprocessor side
set MIC_KMP_AFFINITY=compact,granularity=fine
rem Amount of pre-allocated memory (as much as possible by default) on Intel(R) Xeon Phi(TM) coprocessor
set MKL_MIC_MAX_MEMORY=16G

rem Limit the number of CPU threads so that Intel(R) Xeon Phi(TM) coprocessor will get most of work
rem set OMP_NUM_THREADS=1

rem Force LINPACK to stop if Intel(R) Xeon Phi(TM) coprocessor can't be used
rem set MKL_MIC_DISABLE_HOST_FALLBACK=1

date /t
time /t

echo Running linpack_xeon64.exe. Output could be found in win_xeon64_ao.txt.
linpack_xeon64.exe lininput_xeon64_ao > win_xeon64_ao.txt

date /t >> win_xeon64_ao.txt
time /t >> win_xeon64_ao.txt

echo    Done:
date /t
time /t

ENDLOCAL
