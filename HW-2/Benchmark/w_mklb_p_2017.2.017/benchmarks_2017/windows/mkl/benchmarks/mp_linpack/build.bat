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

echo    This is a SAMPLE build script for MP LINPACK.

SETLOCAL

IF "%MKLROOT%" == "" (
SET MKLROOT=..\..
)

SET MKL_DIRS=%MKLROOT%\lib\intel64

SET MKL_LIBS=%MKL_DIRS%\mkl_intel_lp64.lib %MKL_DIRS%\mkl_sequential.lib %MKL_DIRS%\mkl_core.lib

mpicc -I%MKLROOT%\include /Fexhpl HPL_main.c %MKLROOT%\interfaces\mklmpi\mklmpi-impl.c libhpl_intel64.lib %MKL_LIBS%
