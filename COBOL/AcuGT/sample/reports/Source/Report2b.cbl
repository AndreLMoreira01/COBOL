      *{Bench}prg-comment
      * Report2b.cbl
      * Report2b.cbl is generated from C:\Acucorp\Acucbl720\AcuGT\sample\reports\Report2b.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Report2b.
       AUTHOR. bob.
       DATE-WRITTEN. Friday, May 12, 2006 2:53:22 PM.
       REMARKS. 
           A Column/Header Report
           * The Report Labels have been moved from the Detail Section to 
           the Page Header Section, and renamed.
           * The Report Entry-Fields have been re-positioned in a single line
           * A Report Date-Time control has been added to the Page Footer.
           Date Format has been changed to mm/dd/yyyy.  Justification
           has been changed to Center.
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
       COPY "Salesdata.sl".
      * print sl
       SELECT PRINTF
              ASSIGN TO PRINT PTR-DEV-NAME
              FILE   STATUS   IS STAT-PRINTF.
      *{Bench}end
       DATA                        DIVISION.
       FILE                        SECTION.
      *{Bench}file
       COPY "Salesdata.fd".
      * print fd
       FD PRINTF    LABEL   RECORD  OMITTED.
       01 PRINTF-R.
          05 PRINTF-01              PIC X OCCURS 1024 TIMES.
      *{Bench}end
       WORKING-STORAGE             SECTION.
      *{Bench}acu-def
       COPY "acugui.def".
       COPY "acucobol.def".
       COPY "crtvars.def".
       COPY "acureport.def".
       COPY "showmsg.def".
      *{Bench}end

      *{Bench}copy-working
       COPY "Report2b.wrk".
      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       COPY "Report2b.scr".
      *{Bench}end

      *{Bench}linkpara
       PROCEDURE DIVISION.
      *{Bench}end
      *{Bench}declarative
       DECLARATIVES.
       INPUT-ERROR SECTION.
           USE AFTER STANDARD ERROR PROCEDURE ON INPUT.
       0100-DECL.
           EXIT.
       I-O-ERROR SECTION.
           USE AFTER STANDARD ERROR PROCEDURE ON I-O.
       0200-DECL.
           EXIT.
       OUTPUT-ERROR SECTION.
           USE AFTER STANDARD ERROR PROCEDURE ON OUTPUT.
       0300-DECL.
           EXIT.
       Salesdata-ERROR SECTION.
           USE AFTER STANDARD EXCEPTION PROCEDURE ON Salesdata.
       END DECLARATIVES.
      *{Bench}end

       Acu-Main-Logic.
      *{Bench}entry-befprg
      *    Before-Program
      *{Bench}end
           PERFORM Acu-Initial-Routine

      * Acu-Report2b-PRINT-T PRINTs the Character Report .           
      *    PERFORM Acu-Report2b-PRINT-T

      * Acu-Report2b-PRINT-TOFILE-T writes the Character Report to disk
      * Output File Name is set in the Report's Property Sheet
           PERFORM Acu-Report2b-PRINT-TOFILE-T.
           CALL "C$SYSTEM" USING REPORT2B-DISPLAY-STRING. 

      * run main screen
      *{Bench}run-mainscr
      *{Bench}end
           PERFORM Acu-Exit-Rtn
           .

      *{Bench}copy-procedure
       COPY "showmsg.cpy".
       COPY "Report2b.prd".
       COPY "Report2b.evt".
       COPY "Report2b.rpt".
      *{Bench}end



      *{Bench}Report2b-masterprintpara-T
       Acu-RPT-Report2b-MASTER-PRINT-LOOP-T.
      *{Bench}end
      *
           PERFORM Before-Master-Print-Loop.
           PERFORM UNTIL NOT Valid-Salesdata
             PERFORM Acu-RPT-Report2b-DO-PRINT-RTN-T
             PERFORM End-Master-Print-Loop
           END-PERFORM
           .

