      *{Bench}prg-comment
      * SpellChecker.cbl
      * SpellChecker.cbl is generated from C:\Acucorp\Acucbl700\AcuGT\sample\activex\SpellChecker.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. SpellChecker.
       AUTHOR. bhenn.
       DATE-WRITTEN. Saturday, July 02, 2005 9:41:11 AM.
       REMARKS. 
      *{Bench}end

       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       SPECIAL-NAMES.
      *{Bench}activex-def
       COPY "SpellChecker.def".
       COPY "Acuclass.Def".
           .
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
       COPY "fonts.def".
       COPY "activex.def".
       COPY "showmsg.def".
      *{Bench}end

      *{Bench}copy-working
       COPY "SpellChecker.wrk".
      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end

       SCREEN                      SECTION.
      *{Bench}copy-screen
       COPY "SpellChecker.scr".
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
           PERFORM Acu-DataEntryScreen-Routine
      *{Bench}end
           PERFORM Acu-Exit-Rtn
           .

      *{Bench}copy-procedure
       COPY "showmsg.cpy".
       COPY "SpellChecker.prd".
       COPY "SpellChecker.evt".
      *{Bench}end



