! ****************************************************************
!                            
! InitSaveData - Opens the data file for writing
!   Parameters :                                                  
!
! ****************************************************************

      SUBROUTINE InitSaveData ()

      USE KPP_ROOT_Parameters
      USE KPP_ROOT_Monitor

      INTEGER i

      open(10, file='KPP_ROOT.dat')

      WRITE(10,998) 'TIME',  &
                   (TRIM(SPC_NAMES(LOOKAT(i))), i=1,NLOOKAT)
998   FORMAT(A25,100(1X,A25))

      END SUBROUTINE InitSaveData

! End of InitSaveData function
! ****************************************************************

! ****************************************************************
!                            
! SaveData - Write LOOKAT species in the data file 
!   Parameters :                                                  
!
! ****************************************************************

      SUBROUTINE SaveData ()

      USE KPP_ROOT_Global
      USE KPP_ROOT_Monitor

      INTEGER i

      WRITE(10,999) (TIME-TSTART)/3600.D0,  &
                   (C(LOOKAT(i))/CFACTOR, i=1,NLOOKAT)
999   FORMAT(ES25.16E3,100(1X,ES25.16E3))

      END SUBROUTINE SaveData

! End of SaveData function
! ****************************************************************

! ****************************************************************
!                            
! CloseSaveData - Close the data file 
!   Parameters :                                                  
!
! ****************************************************************

      SUBROUTINE CloseSaveData ()

      USE KPP_ROOT_Parameters

      CLOSE(10)

      END SUBROUTINE CloseSaveData

! End of CloseSaveData function
! ****************************************************************

! ****************************************************************
!                            
! GenerateMatlab - Generates MATLAB file to load the data file 
!   Parameters : 
!                It will have a character string to prefix each 
!                species name with.                                                 
!
! ****************************************************************

      SUBROUTINE GenerateMatlab ( PREFIX )

      USE KPP_ROOT_Parameters
      USE KPP_ROOT_Global
      USE KPP_ROOT_Monitor

      
      CHARACTER(LEN=8) PREFIX 
      INTEGER i

      open(20, file='KPP_ROOT.m')
      write(20,*) 'load KPP_ROOT.dat;'
      write(20,990) PREFIX
990   FORMAT(A1,'c = KPP_ROOT;')
      write(20,*) 'clear KPP_ROOT;'
      write(20,991) PREFIX, PREFIX
991   FORMAT(A1,'t=',A1,'c(:,1);')
      write(20,992) PREFIX
992   FORMAT(A1,'c(:,1)=[];')

      do i=1,NLOOKAT
        write(20,993) PREFIX, SPC_NAMES(LOOKAT(i)), PREFIX, i
993     FORMAT(A1,A6,' = ',A1,'c(:,',I2,');')
      end do
      
      CLOSE(20)

      END SUBROUTINE GenerateMatlab

! End of GenerateMatlab function
! ****************************************************************


