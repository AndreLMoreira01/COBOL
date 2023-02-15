      *{Bench}prg-comment
      * List-Box.cbl
      * List-Box.cbl is generated from C:\Acucorp\Acucbl720\AcuGT\sample\samplprj\List-Box.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. List-Box.
       AUTHOR. bob.
       DATE-WRITTEN. Friday, May 12, 2006 4:30:30 PM.
       REMARKS. 
           This program illustrates the different LISTBOX control types.
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
      *{Bench}acu-def
       COPY "acugui.def".
       COPY "acucobol.def".
       COPY "crtvars.def".
       COPY "showmsg.def".
      *{Bench}end

      *{Bench}copy-working
       COPY "List-Box.wrk".
      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end

       SCREEN                      SECTION.
      *{Bench}copy-screen
       COPY "List-Box.scr".
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
           PERFORM Acu-Initial-Routine
      * run main screen
      *{Bench}run-mainscr
           PERFORM Acu-Screen-1-Routine
      *{Bench}end
           PERFORM Acu-Exit-Rtn
           .

      *{Bench}copy-procedure
       COPY "showmsg.cpy".
       COPY "List-Box.prd".
       COPY "List-Box.evt".
      *{Bench}end



