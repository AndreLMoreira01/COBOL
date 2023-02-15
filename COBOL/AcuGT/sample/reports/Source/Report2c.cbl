      *{Bench}prg-comment
      * Report2c.cbl
      * Report2c.cbl is generated from C:\Acucorp\Acucbl720\AcuGT\sample\reports\Report2c.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Report2c.
       AUTHOR. bob.
       DATE-WRITTEN. Friday, May 12, 2006 2:53:22 PM.
       REMARKS. 
           A report with two breakpoints, Sales-State and Sales-Branch-No
           * Section Controller was used to create Group Headers
           * Report Label/Entry-field combinations associated with the 
           Group Header fields have been added to the respective Group 
           Headers.
           * A Date-Time control has been added to the Page Footer.
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
       COPY "Report2c.wrk".
      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       COPY "Report2c.scr".
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

      * Acu-Report2c-PRINT-T PRINTs the Character Report .           
      *    PERFORM Acu-Report2c-PRINT-T

      * Acu-Report2c-PRINT-TOFILE-T writes the Character Report to disk
      * Output File Name is set in the Report's Property Sheet
           PERFORM Acu-Report2c-PRINT-TOFILE-T.
           CALL "C$SYSTEM" USING REPORT2C-DISPLAY-STRING. 

      * run main screen
      *{Bench}run-mainscr
      *{Bench}end
           PERFORM Acu-Exit-Rtn
           .

      *{Bench}copy-procedure
       COPY "showmsg.cpy".
       COPY "Report2c.prd".
       COPY "Report2c.evt".
       COPY "Report2c.rpt".
      *{Bench}end



      *{Bench}Report2c-masterprintpara-T
       Acu-RPT-Report2c-MASTER-PRINT-LOOP-T.
      *{Bench}end
      *
           PERFORM Before-Master-Print-Loop.
           PERFORM UNTIL NOT Valid-Salesdata
             PERFORM Acu-RPT-Report2c-DO-PRINT-RTN-T
             PERFORM End-Master-Print-Loop
           END-PERFORM
           .

