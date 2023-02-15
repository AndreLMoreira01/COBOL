identification division.
program-id.  makesamp.
*
* This program is used to create a database for use with the
* treesamp sample program.  The data base structure contains two
* files.  The first file's records contain two fields.  The second
* field is the person's employee number.  The first field contains
* the employee number which that person works for.  In addition, any
* person who has noone working for him has a record with his employee
* number in field 1 and a zero in field 2.  The "top dog" of the company
* has a zero in field 1 and their emp. number in field 2.  This allows 
* for easy finding of the top of the tree (first field = 0).  The
* "Add to end of chain" option means that this person has on one who
* works for them.  Hence, HAS-EMPLOYEE is set to zero indicating no more
* children (employees) below this level for this combination.
*
environment division.
configuration section.

input-output section.
file-control.

select optional empno-file assign to "empnos"
    organization is indexed
    access is dynamic
    record key is combo-key
    alternate key is emp-id-number.

select optional title-name assign to "titles"
    organization is indexed
    access is dynamic
    record key is empno-key.

data division.
file section.

fd  empno-file.
01  empno-record.
    05  combo-key.
        10  works-for-number    pic 9(4).
        10  emp-id-number       pic 9(4).
    05  has-employee-flag   pic 9.
        88  has-employee  value 1 false 0.
* A zero here means this combination has no children.



fd  title-name.
01  title-name-record.
    05  empno-key               pic 9(4).
    05  empno-name              pic x(30).
    05  empno-title             pic x(30).

working-storage section.

77  key-status
    is special-names crt status     pic 9(4).
       88  cancel-button-pushed  value 27.
       88  add-record            value 40.
       88  add-record-chain-end  value 41.
       88  exit-program          value 42.

01  screen-control is special-names screen control.
    05  accept-control           pic 9.
    05  control-value            pic 999.
    05  control-handle           handle.
    05  control-id               pic xx comp-x.


copy "acucobol.def".
copy "acugui.def".
copy "fonts.def".

01  current-name             pic x(30).
01  current-title            pic x(30).
01  current-empno            pic 9(4) value 0.
01  current-works-for        pic 9(4) value 0.
01  fixed-font               handle of font.
01  large-font               handle of font.
01  filler                   pic x.
    88  data-ok                value "Y" false "N".
01  filler                   pic x.
    88  eof                    value "Y" false "N".    
01  list-box-initialized-flag  pic x value "N".
    88  list-box-initialized     value "Y".

01  listbox-line.
    05  listbox-title        pic x(30).
    05  listbox-name         pic x(30).
    05  listbox-number       pic 9999.    

01  msg-return               pic 9.
    88  msg-ok                 value mb-ok.
    88  msg-cancel             value mb-cancel.

screen section.
01  main-screen.
    05  label "Create Company Tree Information"
          line 1.5 column 25 size 30 center color red
          font large-font.
    05  label "Title" line 4 column 5.
    05  entry-field using current-title  line 4 column 11.
    05  label "Name" line 6 column 5.
    05  entry-field using current-name  line 6 column 11.
    05  label "Employee Number" line 8 column 5.
    05  curr-emp entry-field using current-empno line 8 column 22.
    05  label "Works For Employee Number" line 8 column 30.
    05  entry-field using current-works-for line 8 column 55.
    05  push-button cancel-button "&Cancel" line 12 column 7 size 10.
    05  push-button "&Add Record" line 12 column 20 size 12
        exception-value = 40.
    05  push-button "Add with &No Children" line 12 column 36 size 17
        exception-value = 41.
    05  push-button "E&xit Program" line 12 column 57 size 15 
        exception-value = 42.        
    05  label "Current Title/Employee List" line 14 column 25
        size 30 center font large-font.
    05  user-list list-box line 16 column 8 size 70 lines 10
        using listbox-line data-columns = (1,31, 61)     
        display-columns = (1,32,64)  dividers = (2,2).

procedure division.
start-it.
*
* This is truely meant to be a quick and dirty program to create
* the data for the tree view sample program.  It is provided to
* display how the data is stored and an explaination of how it will
* be used.  It is NOT meant to be an example of good, solid coding 
* practice.  There is also no modify nor display function as most 
* programs of this type would have.  
*
     open i-o empno-file,
              title-name.
     accept fixed-font from standard object "fixed-font".         
     accept large-font from standard object "large-font".         
     display standard graphical window background-low
       title "Build Tree Sample Data" auto-resize
       system menu  cell size is label font fixed-font.
     perform until exit-program
        display main-screen
        if not list-box-initialized
           perform initialize-existing
           set list-box-initialized to true
        end-if   
        perform setup-for-next
        set data-ok to false
        perform until data-ok
           accept main-screen on exception
              continue
           end-accept   
           perform validate-info thru validate-info-exit
        end-perform   
        if add-record or
           add-record-chain-end
             perform add-record-info
        end-if     
     end-perform.    
     stop run.


initialize-existing.
     set eof to false.
     modify user-list mass-update = 1.
     move low-values to title-name-record.
     start title-name key >= empno-key.
     read title-name next record at end
        set eof to true.
     perform until eof
        move empno-key to listbox-number
        move empno-name to listbox-name
        move empno-title to listbox-title
        modify user-list item-to-add = listbox-line
        read title-name next record at end
          set eof to true
        end-read
     end-perform.     
     modify user-list mass-update = 0.
     move spaces to listbox-line.

setup-for-next.
     move spaces to current-name,
                    current-title.
     move 9999 to empno-key.
     start title-name key is <= empno-key  invalid key
       move zero to empno-key
        not invalid key  
           read title-name previous record at end
           move zero to empno-key
           end-read
     end-start.   
     compute current-empno = empno-key + 1.   
     display main-screen.


validate-info.
     if cancel-button-pushed or
        exit-program
           set data-ok to true
           go to validate-info-exit
     end-if.   
     if current-works-for > 0
        move current-works-for to empno-key
        read title-name invalid key
           display message box
             "Employee number " empno-key " does not exist"
              type is mb-ok-cancel
              default is mb-ok
              giving msg-return
              move 1 to control-value
              go to validate-info-exit
        end-read      
     end-if.   
     move current-works-for to works-for-number.
     move current-empno to emp-id-number.
     read empno-file
        invalid key continue
        not invalid key
        display message box
          "Employee Number " emp-id-number
          " already works for " works-for-number
           type is mb-ok-cancel
           default is mb-ok
           giving msg-return
           move 1 to control-value
           go to validate-info-exit.
     set data-ok to true.      

validate-info-exit.
     exit.


add-record-info.
     move current-name to empno-name,
                          listbox-name.
     move current-title to empno-title,
                           listbox-title.
     move current-empno to emp-id-number,
                           empno-key,
                           listbox-number.
     move current-works-for to works-for-number.
     if add-record-chain-end
        set has-employee to false
     else
        set has-employee to true
     end-if.
     write empno-record.
     write title-name-record.                            
     modify user-list item-to-add = listbox-line.
     move spaces to listbox-line.

