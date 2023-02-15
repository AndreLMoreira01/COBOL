      *{Bench}prg-comment
      * Report2e.cbl
      * Report2e.cbl is generated from C:\Acucorp\Acucbl720\AcuGT\sample\reports\Report2e.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Report2e.
       AUTHOR. bob.
       DATE-WRITTEN. Friday, May 12, 2006 2:53:23 PM.
       REMARKS. 
           A Report with 2  Breakpoints, Sales-State and Sales-Branch-No,
           marked by the inclusion of both Group Headers and 
           Group Footers
           * Report also contains a Report Header and Report Footer. 
           * The Group Footer for Sales-Branch-No contains TOTALS for 
           the Branch for Heavy-Equipment-Sales and Supplies-Sales
           * The Group Footer for Sales-State contains TOTALS for the 
           State for Heavy-Equipment-Sales and Supplies-Sales
           * Note the usage of the Group Header After-Print paragraph to 
           save the Group Footer title.
           * Note the usage of the Detail Before-Print paragraph to perform 
           the ADD operation, accumulating totals for Branch, and State
           Footers
           * Note the usage of the Total-Field Before-Print paragraph to 
           move the numeric Total field into a Formatted field for printing
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
       COPY "Report2e.wrk".
      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       COPY "Report2e.scr".
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

      * Acu-Report2e-PRINT-T PRINTs the Character Report .           
      *    PERFORM Acu-Report2e-PRINT-T

      * Acu-Report2e-PRINT-TOFILE-T writes the Character Report to disk
      * Output File Name is set in the Report's Property Sheet
           PERFORM Acu-Report2e-PRINT-TOFILE-T.           
           CALL "C$SYSTEM" USING REPORT2E-DISPLAY-STRING. 

      * run main screen
      *{Bench}run-mainscr
      *{Bench}end
           PERFORM Acu-Exit-Rtn
           .

      *{Bench}copy-procedure
       COPY "showmsg.cpy".
       COPY "Report2e.prd".
       COPY "Report2e.evt".
       COPY "Report2e.rpt".
      *{Bench}end



      *{Bench}Report2e-masterprintpara-T
       Acu-RPT-Report2e-MASTER-PRINT-LOOP-T.
      *{Bench}end
      *
           PERFORM Before-Master-Print-Loop.
           PERFORM UNTIL NOT Valid-Salesdata
             PERFORM Acu-RPT-Report2e-DO-PRINT-RTN-T
             PERFORM End-Master-Print-Loop
           END-PERFORM
           .

