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

rem Setting path to OpenMP library
set PATH=..\..\..\redist\ia32\compiler;%PATH%
set PATH=..\..\..\redist\ia32_win\compiler;%PATH%
rem Setting up affinity for better threading performance
set KMP_AFFINITY=nowarnings,compact,1,0,granularity=fine

date /t
time /t

echo Running linpack_xeon32.exe. Output could be found in win_xeon32.txt.
linpack_xeon32.exe lininput_xeon32 > win_xeon32.txt

date /t >> win_xeon32.txt
time /t >> win_xeon32.txt

echo    Done:
date /t
time /t

ENDLOCAL
