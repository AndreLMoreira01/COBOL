identification division.
program-id.  treesamp.
*
*  This program demonstrates the use of the new Tree View Control first
*  available in Acucobol-GT version 4.2.
*
*  The concept of this program is to display a company hierarchy diagram
*  of a company.  In other words, the top level is the President/CEO.
*  Expanding that person show the Vice-Presidents and so on.
*
*  There are two files.  The first (empno-file) contains the 3 pieces of
*  information: The employee number that a particular employee works for,
*  the employee number of that employee and a flag indicating whether or
*  not that employee has someone else working for them (i.e. a "child" in
*  the concept of a Tree View).  The second file (title-name) contains
*  the name and title connected with an employee number.
*
*  When programming for a Tree View it is necessary to be able to find the
*  beginning or first entry in the tree.  This program does this by
*  specifying that the President/CEO works for employee number 0 (zero)
*  which does not exist in the title-name file.  This provides the
*  starting point from which to build the tree.
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
*
* Note - this alternate key is not used in this program.  However, actual
*        implementations might well use it for other purposes so I
*        included it.
*

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
* A zero here means this combination has no children (i.e. no employees
* working for them).

fd  title-name.
01  title-name-record.
    05  empno-key               pic 9(4).
    05  empno-name              pic x(30).
    05  empno-title             pic x(30).

working-storage section.

copy "def/acucobol.def".
copy "def/acugui.def".
copy "def/fonts.def".
copy "def/crtvars.def".
copy "def/stdfonts.def".
copy "def/winvers.def".

77  key-status
    is special-names crt status     pic 9(4).
       88  cancel-button-pushed  value 27.
       88  display-all-titles    value 104.
       88  display-all-names     value 105.

01  save-ev-2                    usage signed-long.
01  start-node                   usage pointer.
01  item-1                       usage pointer.

01  message-answer               pic 99.
01  hidden-info.
    05  hidden-empno             pic 9(4).

01  current-function             pic 9 value 0.
        88  showing-name           value 1.
        88  showing-title          value 0.
01  current-empno                pic 9(4) value 0.
01  out-data                     pic x(30).

77  filler                       pic x.
    88  eof                        value "Y" false "N".


screen section.
01  tv-screen.
    05  label "Sample Company Structure Tree View"
        line 1.5 column 20 size 40 center color red font large-font.
    05  co-tree tree-view
        line 4 column 5
        lines 20 size 40
        event procedure is tree-events
        buttons, show-lines, lines-at-root
        3-d.
    05  push-button "Display &Titles" size 15 line 6 column 51
        exception-value = 104.
    05  push-button "Display &Names" size 17 line 12 column 50
        exception-value = 105.
    05  push-button "E&xit" lines 1 size 8 line 18
        column 54 exception-value = 27.


procedure division.
start-it-up.

     accept terminal-abilities from terminal-info.
     if (has-graphical-interface)
         call "win$version" using winversion-data
         if win-wordsize-16
             display message box
                 "Tree View is Not Available with 16-bit Windows"
                 type is MB-OK
             stop run.

     display standard window background-low
       title "Accurate Cobol Company Tree" auto-resize
       size 70 lines 24
       system menu.

     open input empno-file,
                title-name.
     perform initialize-tree.
     perform until cancel-button-pushed
        accept tv-screen
        if display-all-names or
           display-all-titles
             perform change-whole-tree
        end-if
     end-perform.
     close empno-file, title-name.
     stop run.



initialize-tree.
     display tv-screen.
     move zero to works-for-number,
                  emp-id-number.
* Every tree structure needs a starting point.  One of the easiest
* ways is to have a key which is known.
     start empno-file key >= combo-key.
     read empno-file next record at end
        display message box
          "No records for company tree in database"
          type is mb-ok
          icon is mb-error-icon
          giving message-answer
        end-display
        stop run
     end-read.
     if works-for-number > 0
*  Oops.  The first record doesn't seem to exist. Abort!
        display message box
          "No beginning record for company tree"
          type is mb-ok
          icon is mb-error-icon
          giving message-answer
        end-display
        stop run
     end-if.

     move emp-id-number to empno-key.
     read title-name invalid key
        perform missing-empno
        stop run
     end-read.

     move empno-key to hidden-empno.
     set showing-title to true.
     modify co-tree, item-to-add = empno-title
       giving start-node has-children = has-employee-flag
       hidden-data = hidden-info.
* Add the record for the first person.  NOTE - hidden-info is information
* connected with the branch but not visable on the screen.

*
* NOTE -  there are at least two ways of handling the expansion and collapsing
*         on a branch.  Both ways are noted below.  The first way is to empty
*         the branch when it is collapsed and re-add the children when
*         expanded.  The second way is to check to let the Tree View itself
*         take care of the collapsing.  When the user wishes to expand the
*         tree, you must check to see if you have already added the children
*         and add them ONLY if you haven't done so before.  To see how
*         this works, comment out the first occurance of the tree-events
*         paragraph below and uncomment the second one.
*

*tree-events.
*     evaluate true
*       when event-type = msg-tv-expanding
*         if event-data-1 = tvflag-expand
*            perform add-children
*         end-if
*       when event-type = msg-tv-expanded
*         if event-data-1 = tvflag-collapse
*            modify co-tree, item-to-empty = event-data-2
*         end-if
*     end-evaluate.
*
*  Additional NOTE - the above method has one major drawback.  It is
*  possible to create a MSG-TV-EXPANDING by using the "+" or "*" key
*  in the numeric key pad.  This presents a problem since this method
*  doesn't check to see if it has already been expanded and therefore
*  does the expansion a second time. You can see this by changing which
*  paragraph is used, expanding the first level with the mouse, arrow
*  down to any entry and then press either the * or + key in the key
*  pad.  You will see that expansion takes places multiple times.  The
*  program is that normally you can't expand twice if you are using the
*  mouse.  But, even if there is a "-" in the small box to the left
*  which indicates that that level is expanded already, windows generates
*  a MSG-TV-EXPAND with these two keys anyway.  This is beyond Acucobol's
*  control.
*

tree-events.
     evaluate event-type
       when msg-tv-expanding
         if event-data-1 = tvflag-expand
            modify co-tree (event-data-2)
              next-item = tvni-child giving item-1
* Try to get the first child of this item
            if item-1 = null
** There are no children so we'll need to add them
               perform add-children
            end-if
         end-if
     end-evaluate.


add-children.
     inquire co-tree (event-data-2)
        hidden-data in hidden-info.
     move event-data-2 to  save-ev-2.
     move hidden-empno to works-for-number,
                          current-empno.
     move zero to emp-id-number.
     set eof to false.
     start empno-file key is > combo-key
       invalid key set eof to true
         not invalid key
       read empno-file next record at end
         set eof to true
       end-read
     end-start.
     move emp-id-number to empno-key.
     read title-name invalid key
        perform missing-empno
     end-read.
     if works-for-number not = current-empno
        set eof to true
     end-if.
     perform until eof
        move empno-key to hidden-empno
        if showing-name
           move empno-name to out-data
        else
           move empno-title to out-data
        end-if
        modify co-tree,
          parent = save-ev-2
          item-to-add = out-data
*
* IMPORTANT NOTE --- The order here (first parent then item-to-add)
*                     is VERY important.  Otherwise the item will get
*                     added to the wrong parent.
*
          placement = tvplace-last
* I want it last in the list in the current parent group
          has-children = has-employee-flag
          hidden-data = hidden-info
          read empno-file next record at end
            set eof to true
            not at end
              if works-for-number not = current-empno
                 set eof to true
              end-if
          end-read
          if not eof
             move emp-id-number to empno-key
             read title-name invalid key
                perform missing-empno
             end-read
          end-if
     end-perform.

missing-empno.
     display message box
         "No Name/Title record for employee " emp-id-number
          type is mb-ok
          icon is mb-error-icon
          giving message-answer
      end-display.
      stop run.

change-whole-tree.
     if display-all-titles
        set showing-title to true
     else
        set showing-name to true
     end-if.
     modify co-tree, next-item = tvni-root giving item-1.
*
*  Visit each element
*
     perform until item-1 = zero
        modify co-tree, item = item-1
        perform set-title-name thru set-title-name-exit
        modify co-tree, next-item = tvni-child giving item-1
        if item-1 = zero
*  No children, see if there is a sibling
           modify co-tree, next-item = tvni-next giving item-1
           perform until item-1 not = zero
*  No siblings either, see if one of my parents has a sibling
             modify co-tree, next-item = tvni-parent giving item-1
             if item-1 = zero
*  Ran out of parents, we must be done
                exit perform
             end-if
             modify co-tree, item = item-1,
                             next-item = tvni-next giving item-1
           end-perform
        end-if
     end-perform.



set-title-name.
     inquire co-tree (item-1)
        hidden-data in hidden-info.
     move hidden-empno to empno-key.
     read title-name invalid key
       display message box
         "No Name/Title Record found for " empno-key
         stop run
     end-read.
     if display-all-names
        move empno-name to out-data
     else
        move empno-title to out-data
     end-if.
     modify co-tree (item-1)
        hidden-data = hidden-info
        item-text = out-data.

set-title-name-exit.
     exit.
