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

echo This is a SAMPLE run script for MP LINPACK. Change it to reflect the correct
echo number of CPUs/threads, number of nodes, MPI processes per node, etc..

SETLOCAL

rem Set total number of MPI processes for the HPL (should be equal to PxQ).
set MPI_PROC_NUM=2

rem Set the MPI per node and number of MICs attached to each node.
rem MPI_PER_NODE should be equal to 1 or number of sockets in the system. Otherwise,
rem the HPL performance will be low. 
rem MPI_PER_NODE is same as -perhost or -ppn paramaters in mpiexec/mpirun
set MPI_PER_NODE=2
set NUMMIC=2

rem You can find description of all Intel MPI parameters in the
rem Intel MPI Reference Manual.
rem See <intel mpi installdir>/doc/Reference_manual.pdf

set I_MPI_DAPL_DIRECT_COPY_THRESHOLD=655360

rem     "export I_MPI_PIN_CELL=core"
rem     You can use this variable (beginning Intel MPI 4.0.1 for cases if HT is enabled.
rem     The variable forces to pin MPI processes and threads to real cores,
rem     so logical processors will not be involved.
rem     It can be used together with the variable below, when Hydra Process Manager:
rem     "export I_MPI_PIN_DOMAIN=auto" This allows uniform distribution of
rem     the processes and thread domains

rem     set I_MPI_EAGER_THRESHOLD=128000
rem     This setting may give 1-2% of performance increase over the
rem     default value of 262000 for large problems and high number of cores

set OUT=xhpl_intel64_dynamic_outputs.txt
set EXE=runme_intel64_prv.bat

echo This run started on:
date /T
time /T

echo Capturing output into: %OUT%
rem Capture some meaningful data for future reference:
echo.
echo This run was done on: >> %OUT%
date /T >> %OUT%
time /T >> %OUT%
echo.   >> %OUT%
echo HPL.dat: >> %OUT%
type HPL.dat >> %OUT%
echo.   >> %OUT%
echo.   >> %OUT%
echo Binary name: >> %OUT%
dir /B %EXE% >> %OUT%
echo.   >> %OUT%
echo This script: >> %OUT%
type runme_intel64_dynamic.bat >> %OUT%
echo.   >> %OUT%
echo.   >> %OUT%
echo Environment variables: >> %OUT%
set >> %OUT%
echo.   >> %OUT%
echo.   >> %OUT%
echo Actual run: >> %OUT%

rem Environment variables can also be set on the Intel MPI command line
rem using the -genv option (to appear before the -np 1):
echo.   >> %OUT%

mpiexec -np %MPI_PROC_NUM% .\%EXE% %* >> %OUT%

rem In case of multiple nodes involved, please set the number of MPI processes
rem per node (ppn=1,2 typically) through the -perhost option (because the
rem default is all cores):

rem mpiexec -perhost %MPI_PER_NODE% -np %MPI_PROC_NUM% .\%EXE% %* >> %OUT%

echo.   >> %OUT%
echo.   >> %OUT%
echo Done: >> %OUT%
date /T >> %OUT%
time /T >> %OUT%

echo Done:
date /T
time /T

ENDLOCAL
