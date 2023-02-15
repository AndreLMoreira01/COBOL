      *{Bench}prg-comment
      * Report1h.cbl
      * Report1h.cbl is generated from C:\Acucorp\Acucbl720\AcuGT\sample\reports\Report1h.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Report1h.
       AUTHOR. bob.
       DATE-WRITTEN. Friday, May 12, 2006 2:53:21 PM.
       REMARKS. 
           Report1h replaces the Report Entry-Fields in the Detail Line with 
           a Report Grid Control consisting of 4 evenly-sized columns
           corresponding to the four fields.
           Technical Tips for using the Report Grid Control: 
           * When using a Report Grid Control on a Detail Line, and also 
           using Group Headers and Footers, it is appropriate to set 
           COLUMN-HEADERS to FALSE on the Grid Control.
           * To make sure that subsequent Grid Lines join, set the LINES 
           setting for the Detail Line Section equal ( or very close ) to the 
           LINES setting for the Report Grid Control.  If the LINES setting for 
           the Detail Line Section is significantly larger than the LINES 
           setting for the Report Grid control, you will see spaces between 
           the Grid Detail lines.
           
           Note that Report1g was created from a Report Template (*.wtf )
           file, which was derived from Report1f.  To create a Report 
           Template, right-click on the body of the Report Designer, and 
           select the function "Generate .WTF Document... ".    This 
           will write out the contents of your report in a text file format.  In 
           a subsequent program, you can then use the "Add Report" 
           function to locate the .WTF file, and load it into the Report 
           Designer.  The new report reproduces the names of the Report 
           Controls, and Property Sheet settings.  
           
           Some alterations were then made to create Report1g, notably:
           * Report/Output File Name was changed to Report1g.html.
           * Report/Report Type was changed from Standard to N-Top
           * Report-GH-1/Skip page before Print was changed to FALSE
           * Event Editor code is not preserved in the .WTF file, so it was 
           necessary to add this code back in, before doing the final 
           code generation.
           
           Report uses the Report Image, Date-Time, and Report Table 
           Controls, and incorporates a Report Header, and Report Footer.
           Skip Page properties are applied to the Group Headers, 
           allowing for the production of a Sales Report, with page breaks 
           for each State.
           
           Note the usage of the Table control in the Group Header.
           The Data Image cell type allows for the selection of the 
           appropriate JPEG file to display, based on context, in the 
           Before-Print paragraph of the Table control.
           
           A Report with 2  Breakpoints, Sales-State and Sales-Branch-No,
           marked by the inclusion of both Group Headers and 
           Group Footers. 
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
           move the numeric Total field into a Formatted field for printing.
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
       COPY "Report1h.wrk".
      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       COPY "Report1h.scr".
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
           PERFORM Acu-Report1h-Preview
      * run main screen
      *{Bench}run-mainscr
      *{Bench}end
           PERFORM Acu-Exit-Rtn
           .

      *{Bench}copy-procedure
       COPY "showmsg.cpy".
       COPY "Report1h.prd".
       COPY "Report1h.evt".
       COPY "Report1h.rpt".
      *{Bench}end

       REPORT-COMPOSER SECTION.
      *{Bench}Report1h-masterprintpara
       Acu-RPT-Report1h-MASTER-PRINT-LOOP.
      *{Bench}end
      *
           PERFORM Before-Master-Print-Loop.
           PERFORM UNTIL NOT Valid-Salesdata
             PERFORM Acu-RPT-Report1h-DO-PRINT-RTN
             PERFORM End-Master-Print-Loop
           END-PERFORM
           .
            
      *{Bench}Report1f-RwGd-1-doprintrtn
       Acu-Report1f-RwGd-1-TABBODY.
           PERFORM Acu-Initialize-Report1f-RwGd-1
      *{Bench}end
      *
      *{Bench}Report1f-RwGd-1-tabbodyprintloop
           PERFORM Acu-Report1f-RwGd-1-TabbodyPrintLoop
      *{Bench}end
      *
      *{Bench}Report1f-RwGd-1-closegrid
           PERFORM Acu-CLOSE-Report1f-RwGd-1
           .
      *{Bench}end
      
