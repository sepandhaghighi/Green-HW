:: Do not run this script directly. Use runme_intel64.bat instead. 
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

SET ERROR_MSG="This usage model is not supported. Please change the number of MPI processes per node (MPI_PER_NODE variable inside runme_intel64_dynamic.bat)!"
SET ERROR_1MIC="For 1 Intel(R) Xeon Phi(TM) co-processor, use 1 or 2 MPI processes per node. Current value = %MPI_PER_NODE%."
SET ERROR_2MIC="For 2 Intel(R) Xeon Phi(TM) co-processors, use 1, 2 or 4 MPI processes per node. Current value = %MPI_PER_NODE%."
SET ERROR_3MIC="For 3 Intel(R) Xeon Phi(TM) co-processors, use 1, 2 or 3 MPI processes per node. Current value = %MPI_PER_NODE%."
SET ERROR_4MIC="For 4 Intel(R) Xeon Phi(TM) co-processors, use 1, 2 or 4 MPI processes per node. Current value = %MPI_PER_NODE%."

IF "%PMI_RANK%"=="" (
	SET /A PMI_RANK=%PMI_ID%
)

IF "%PMI_SIZE%"=="" (
	SET /A PMI_SIZE=%MPI_PROC_NUM%
)

SET /A MPI_RANK_FOR_NODE=%PMI_RANK% %% %MPI_PER_NODE%

SET HPL_LOG=1

SET HPL_LARGEPAGE=0
REM SET HPL_NUMSWAPS=0
REM SET HPL_MIC_EXQUEUES=256

SET /A HPL_HOST_NODE=%MPI_RANK_FOR_NODE%

IF %NUMMIC% EQU 0 (
	SET HPL_PNUMMICS=0
)

IF %MPI_PER_NODE% EQU 1 (
        SET /A HPL_PNUMMICS=%NUMMIC% 
) 

IF %MPI_PER_NODE% EQU 2 (
	IF %NUMMIC% EQU 1 (
		SET HPL_MIC_DEVICE=0
		IF %MPI_RANK_FOR_NODE% EQU 0 (
			SET HPL_MIC_SHAREMODE=1		
		)		
		IF %MPI_RANK_FOR_NODE% EQU 1 (
			SET HPL_MIC_SHAREMODE=2
		)	
	)
	IF %NUMMIC% EQU 2 (
		SET /A HPL_MIC_DEVICE=%MPI_RANK_FOR_NODE%
	)
	
	IF %NUMMIC% EQU 3 (
		IF %MPI_RANK_FOR_NODE% EQU 0 (
			SET HPL_MIC_DEVICE=0,2
			SET HPL_MIC_SHAREMODE=0,1		
		)		
		IF %MPI_RANK_FOR_NODE% EQU 1 (
			SET HPL_MIC_DEVICE=1,2
			SET HPL_MIC_SHAREMODE=0,2		
		)
	)
	
	IF %NUMMIC% EQU 4 (
		IF %MPI_RANK_FOR_NODE% EQU 0 (
			SET HPL_MIC_DEVICE=0,1			
		)		
		IF %MPI_RANK_FOR_NODE% EQU 1 (
			SET HPL_MIC_DEVICE=2,3			
		)
	)
)

IF %MPI_PER_NODE% EQU 3 (
	IF %NUMMIC% EQU 1 (
		echo %ERROR_MSG%		
		echo %ERROR_1MIC%
		EXIT /B
	)
	
	IF %NUMMIC% EQU 2 (
		echo %ERROR_MSG%
		echo %ERROR_2MIC%
		EXIT /B
	)
	
	IF %NUMMIC% EQU 3 (
		SET /A HPL_MIC_DEVICE=%MPI_RANK_FOR_NODE%
	)
	
	IF %NUMMIC% EQU 4 (
		echo %ERROR_MSG%		
		echo %ERROR_4MIC%
		EXIT /B
	)
)

IF %MPI_PER_NODE% EQU 4 (
	IF %NUMMIC% EQU 1 (
		echo %ERROR_MSG%
		echo %ERROR_1MIC%
		EXIT /B
	)
	
	IF %NUMMIC% EQU 2 (
		IF %MPI_RANK_FOR_NODE% EQU 0 (
			SET HPL_MIC_DEVICE=0
			SET HPL_MIC_SHAREMODE=1
		)
		
		IF %MPI_RANK_FOR_NODE% EQU 1 (
			SET HPL_MIC_DEVICE=0		
			SET HPL_MIC_SHAREMODE=2
		)
		
		IF %MPI_RANK_FOR_NODE% EQU 2 (
			SET HPL_MIC_DEVICE=1		
			SET HPL_MIC_SHAREMODE=1
		)
		
		IF %MPI_RANK_FOR_NODE% EQU 3 (
			SET HPL_MIC_DEVICE=1		
			SET HPL_MIC_SHAREMODE=2
		)		
	)
	
	IF %NUMMIC% EQU 3 (
		echo %ERROR_MSG%
		echo %ERROR_3MIC%
		EXIT /B
	)
	
	IF %NUMMIC% EQU 4 (
		SET /A HPL_MIC_DEVICE=%MPI_RANK_FOR_NODE%
	)
)

echo PMI_RANK = %PMI_RANK%
echo RANK = %MPI_RANK_FOR_NODE%
echo DEVICE = %HPL_MIC_DEVICE%
echo ShareMode = %HPL_MIC_SHAREMODE%

xhpl_intel64_dynamic %*
