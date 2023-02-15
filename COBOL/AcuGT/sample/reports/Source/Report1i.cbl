      *{Bench}prg-comment
      * Report1i.cbl
      * Report1i.cbl is generated from C:\Acucorp\Acucbl720\AcuGT\sample\reports\Report1i.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Report1i.
       AUTHOR. bob.
       DATE-WRITTEN. Friday, May 12, 2006 2:53:22 PM.
       REMARKS. 
           Report1i illustrates an alternative usage of the Report Grid
           Control.  
           
           If you wish to run a simple report, in which consecutive detail 
           lines are added to a Report Grid Control, then you can build 
           your Master Loop into the Grid Tabbody code.
           
           In this report, code is added around the tags slightly differently- 
           note the way the code straddles the GridLoop tag.  Note also 
           that when using this device, you do not have access to the 
           Before-Print paragraph of the Grid, so MOVEs to formatted fields 
           must be entered into the code outside of the tags as well.
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
       COPY "Report1i.wrk".
      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       COPY "Report1i.scr".
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
           PERFORM Acu-Report1i-Preview
      * run main screen
      *{Bench}run-mainscr
      *{Bench}end
           PERFORM Acu-Exit-Rtn
           .

      *{Bench}copy-procedure
       COPY "showmsg.cpy".
       COPY "Report1i.prd".
       COPY "Report1i.evt".
       COPY "Report1i.rpt".
      *{Bench}end

       REPORT-COMPOSER SECTION.
      *{Bench}Report1i-masterprintpara
       Acu-RPT-Report1i-MASTER-PRINT-LOOP.
      *{Bench}end
      *
           PERFORM Acu-RPT-Report1i-DO-PRINT-RTN
           .
            
      *{Bench}Report1i-RwGd-1-doprintrtn
       Acu-Report1i-RwGd-1-TABBODY.
           PERFORM Acu-Initialize-Report1i-RwGd-1
      *{Bench}end
      *
           PERFORM Before-Master-Print-Loop.
           MOVE Heavy-Equipment-Sales to PR-Heavy-Sales.
           MOVE Supplies-Sales to PR-Supplies-Sales.
           MOVE Sales-Quota to PR-Quota.
           PERFORM UNTIL NOT Valid-Salesdata
      *{Bench}Report1i-RwGd-1-tabbodyprintloop
           PERFORM Acu-Report1i-RwGd-1-TabbodyPrintLoop
      *{Bench}end
             PERFORM End-Master-Print-Loop
             MOVE Heavy-Equipment-Sales to PR-Heavy-Sales
             MOVE Supplies-Sales to PR-Supplies-Sales
             MOVE Sales-Quota to PR-Quota
           END-PERFORM
           .
      *
      *{Bench}Report1i-RwGd-1-closegrid
           PERFORM Acu-CLOSE-Report1i-RwGd-1
           .
      *{Bench}end
      
