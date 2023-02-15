      *{Bench}prg-comment
      * Report1d.cbl
      * Report1d.cbl is generated from C:\Acucorp\Acucbl720\AcuGT\sample\reports\Report1d.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Report1d.
       AUTHOR. bob.
       DATE-WRITTEN. Friday, May 12, 2006 2:53:20 PM.
       REMARKS. 
           A Report with two breakpoints, Sales-State and Sales-Branch-No,
           a Report Header, and a Report Footer
           Report also illustrates the usage of the Report Radio-Button, 
           Report Check-box, and Report Occurs Controls.
           Report also illustrates how a Before-Print paragraph is used to 
           prepare a formatted field for printing. 
           * Note that the formatted numeric fields reference formatted fields
           in Working-Storage as their VALUE VARIABLE, not the numeric
           field in the FD.  
           * Note that the Before-Print paragraph for Heavy-Equipment-
           Sales contains the MOVE statement: 
           MOVE Heavy-Equipment-Sales to PR-Heavy-Sales.  The other
           numeric fields are handled similarly.
           * Before-Print paragraphs are also used to format the 
           Report Radio-button and Report Check-box controls.
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
       COPY "Report1d.wrk".
      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       COPY "Report1d.scr".
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
      *     Acu-Report1d-PRINT-TOFILE writes the HTML file to disk
      *     PERFORM Acu-Report1d-PRINT-TOFILE

      *     Acu-Report1d-PRINT writes and PRINTs the HTML file
      *     PERFORM Acu-Report1d-PRINT

      *     Acu-Report1d-PREVIEW writes and PREVIEWs the HTML file
           PERFORM Acu-Report1d-Preview
      * run main screen
      *{Bench}run-mainscr
      *{Bench}end
           PERFORM Acu-Exit-Rtn
           .

      *{Bench}copy-procedure
       COPY "showmsg.cpy".
       COPY "Report1d.prd".
       COPY "Report1d.evt".
       COPY "Report1d.rpt".
      *{Bench}end



      *{Bench}Report1d-masterprintpara
       Acu-RPT-Report1d-MASTER-PRINT-LOOP.
      *{Bench}end
      *
           PERFORM Before-Master-Print-Loop.
           PERFORM UNTIL NOT Valid-Salesdata
             PERFORM Acu-RPT-Report1d-DO-PRINT-RTN
             PERFORM End-Master-Print-Loop
           END-PERFORM
           .

