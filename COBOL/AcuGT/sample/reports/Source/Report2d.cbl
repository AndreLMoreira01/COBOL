      *{Bench}prg-comment
      * Report2d.cbl
      * Report2d.cbl is generated from C:\Acucorp\Acucbl720\AcuGT\sample\reports\Report2d.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Report2d.
       AUTHOR. bob.
       DATE-WRITTEN. Friday, May 12, 2006 2:53:23 PM.
       REMARKS. 
           A Report with two breakpoints, Sales-State and Sales-Branch-No,
           a Report Header, and a Report Footer
           Report also illustrates how a Before-Print paragraph is used to 
           prepare a formatted field for printing. 
           * Note that the formatted numeric fields reference formatted fields
           in Working-Storage as their VALUE VARIABLE, not the numeric
           field in the FD.  
           * Note that the Before-Print paragraph for Heavy-Equipment-
           Sales contains the MOVE statement: 
           MOVE Heavy-Equipment-Sales to PR-Heavy-Sales.  The other
           numeric fields are handled similarly.
           * Before-Print paragraphs can be entered by double-clicking a 
           control, or through the Event tab of the Property Sheet for a 
           control.
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
       COPY "Report2d.wrk".
      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       COPY "Report2d.scr".
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
           
      * Acu-Report2d-PRINT-T PRINTs the Character Report .           
      *    PERFORM Acu-Report2d-PRINT-T

      * Acu-Report2d-PRINT-TOFILE-T writes the Character Report to disk
      * Output File Name is set in the Report's Property Sheet
           PERFORM Acu-Report2d-PRINT-TOFILE-T.
           CALL "C$SYSTEM" USING REPORT2D-DISPLAY-STRING. 

      * run main screen
      *{Bench}run-mainscr
      *{Bench}end
           PERFORM Acu-Exit-Rtn
           .

      *{Bench}copy-procedure
       COPY "showmsg.cpy".
       COPY "Report2d.prd".
       COPY "Report2d.evt".
       COPY "Report2d.rpt".
      *{Bench}end



      *{Bench}Report2d-masterprintpara-T
       Acu-RPT-Report2d-MASTER-PRINT-LOOP-T.
      *{Bench}end
      *
           PERFORM Before-Master-Print-Loop.
           PERFORM UNTIL NOT Valid-Salesdata
             PERFORM Acu-RPT-Report2d-DO-PRINT-RTN-T
             PERFORM End-Master-Print-Loop
           END-PERFORM
           .

