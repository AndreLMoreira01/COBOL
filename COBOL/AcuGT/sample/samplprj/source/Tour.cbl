      *{Bench}prg-comment
      * Tour.cbl
      * Tour.cbl is generated from C:\Acucorp\Acucbl720\AcuGT\sample\samplprj\Tour.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Tour.
       AUTHOR. bob.
       DATE-WRITTEN. Friday, May 12, 2006 4:30:31 PM.
       REMARKS. 
           This program provides a brief tour through some of the
           features of ACUCOBOL-GT.
           It is provided as a sample program.
      *{Bench}end

       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       SPECIAL-NAMES.
      *{Bench}activex-def
      *{Bench}end
      *{Bench}decimal-point
      *{Bench}end
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *{Bench}file-control
      *{Bench}end
       DATA                        DIVISION.
       FILE                        SECTION.
      *{Bench}file
      *{Bench}end
       WORKING-STORAGE             SECTION.
       77  W-COR-LABEL PIC 9(18).
      *{Bench}acu-def
       COPY "acugui.def".
       COPY "acucobol.def".
       COPY "crtvars.def".
       COPY "showmsg.def".
      *{Bench}end

      *{Bench}copy-working
       COPY "Tour.wrk".
      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       COPY "Tour.scr".
      *{Bench}end

      *{Bench}linkpara
       PROCEDURE DIVISION.
      *{Bench}end
      *{Bench}declarative
      *{Bench}end

       Acu-Main-Logic.
      *{Bench}entry-befprg
      *    Before-Program
      *{Bench}end
           COMPUTE W-COR-LABEL = BCKGRND-YELLOW + BLACK
           PERFORM Acu-Initial-Routine
      * run main screen
      *{Bench}run-mainscr
           PERFORM Acu-Screen-1-Routine
      *{Bench}end
           PERFORM Acu-Exit-Rtn
           .

      *{Bench}copy-procedure
       COPY "showmsg.cpy".
       COPY "Tour.prd".
       COPY "Tour.evt".
      *{Bench}end
       REPORT-COMPOSER SECTION.
