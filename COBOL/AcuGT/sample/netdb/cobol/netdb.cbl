       identification division.
       program-id.  NetDB.
      * Copyright (c) 1996-2003 by Acucorp, Inc.  Users of ACUCOBOL
      * may freely modify and redistribute this program.
      *
      * remarks.
      *    This program demostrates the grid control.
      *    The About Window is an INDEPENDENT WINDOW, and
      *    may be minimized independently of the Main Window.
      *    The program demonstrates the usage of integrated popup menus,
      *    and the new "Handle of Menu" usage
      *    The program demonstrates the COPY RESOURCE syntax, which
      *    allows bitmaps to be compiled into your program.
      *    The program how to put a spinning bitmap in a grid cell.
      *
       environment division.
       configuration section.
       special-names.
       copy "def/NetDB.def".
       .
       data division.
       working-storage section.

      * Copybooks

       copy "def/acucobol.def".
       copy "def/acugui.def".
       copy "def/crtvars.def".
       copy "def/controls.def".
       copy "def/opensave.def".
       copy resource "littlegt.bmp".

      * Constants

       78  max-rows                          value 18.
       78  max-cols                          value 3.

      * Crt-Status

       77  key-status is special-names crt status pic 9(4) value 0.
         88  exit-pressed                    value 10.
         88  about-pressed                   value 15.
         88  exit-about-screen               value 201.

      * Handles

       77  window-0                          handle of window.
       77  window-1                          handle of window.
       77  about-thread                      handle of thread.
       77  grid-menu                         handle of menu.
       77  gt-bitmap                         pic s9(9) comp-4.
       77  MY-ASSY-HANDLE                    USAGE IS HANDLE.
       77  DB-PATH            pic X(18) VALUE "E:\NETDB\NETDB.MDB".
       77  QUERY-STRING       pic X(20) VALUE "SELECT * FROM Orders".
       77  ERROR-MESSAGE      pic x(128).
       77  BOOL-RTN           SIGNED-INT VALUE 1.
       77  ORDER-QUANT        SIGNED-INT. 

      * Data Items for Screen Handling

       77  ctr                               pic 99    value 0.
       77  grid-y                            pic 99    value 0.
         88 in-column-headings                         value 1.
       77  grid-x                            pic 99    value 0.
         88 in-row-headings                            value 1.
       77  bmp-num                           pic 99    value 0.
       77  scratch                           pic x(80) value spaces.

      * Grid Data
      
       01 GRID_RECORD.
          05 FILLER                            pic x(4).
          05 ORDER-NUMBER                      pic x(18).
          05 PRODUCT-NAME                      pic x(44).
          05 DISPLAY-ORDER-QUANT               pic 9999.

       01 grid-header.
         05 filler                           pic x(80)
           value "      ORDER-NUMBER    PRODUCT-NAME                                              
      -  "            QUANTITY".
      
      *
       screen section.
       01 main-screen exception procedure exception-handler.
         03 grid-1, grid,
               line 2.5, col 2,
               size 75, lines 13,
               3-d,
               vscroll,
               data-columns       = ( 4, 22, 65)
               display-columns    = ( 4, 22, 65)
               alignment          = ("C","C","C")
               row-dividers       = (1,3)
               column-dividers    = (2,2,2)
               divider-color      = bright-red
               cursor-color       = 80
               heading-color      = 144
               cursor-frame-width = -1
               vpadding           = 50
               virtual-width      = 75
               hscroll
               adjustable-columns
               use-tab
               column-headings
               row-headings
               centered-headings
               tiled-headings
               pop-up menu          grid-menu
               event procedure is   grid-1-handler.

         05 about-pb, push-button,
               line 25, col 25,
               size 14 cells
               title "&About",
               self-act,
               exception-value    = 15.

         05 push-button,
               line 25, col 41,
               size 14 cells
               title "E&xit",
               self-act,
               exception-value    = 10.
      *
       01 about-screen exception exception-handler.
         05 comments-listbox, list-box,
               line + 1.5, column 2
               size 62, lines 14
               3-d,
               unsorted.

         05 push-button,
               line 16, col 26.5,
               title "E&xit",
               self-act,
               exception-value = 201.
      *
       procedure division.
       main-logic.
      *
           perform initialization.
           display standard graphical window,
                   title "Net DB Demo",
                   size 80, lines 27, background-low
                   modeless, link to thread,
                   handle window-0.
      *
           call "w$bitmap" using wbitmap-load, "littlegt.bmp",
                giving gt-bitmap.

      *   The menu is a popup menu, activated by right-clicking the mouse.
      *   In this program, you can also activate this menu by clicking on
      *   the spinning bitmap.  You will notice that the menu handle is
      *   referred to in the screen section description of the Grid control,
      *   and described in Working-Storage as USAGE HANDLE OF MENU.

           perform build-main-popup.
           move menu-handle to grid-menu.

           display main-screen.
           perform load-grid.
           perform thread animate-bitmap.

           perform, with test after, until exit-pressed
             accept main-screen on exception continue end-accept
           end-perform.

           stop run.

      *  Grids are loaded with the MODIFY.....RECORD-TO-ADD syntax.
      *  After loading the grid, the cursor is placed in cell 2,2
      *  because this grid has COLUMN-HEADINGS occupying row 1, and
      *  ROW-HEADINGS occupying column 1.

       load-grid.
       
           modify grid-1, record-to-add = grid-header.
           
           CREATE "NetDB"
                NAMESPACE IS "NetDB",
                CLASS-NAME IS "NetDB_MGR",
                CONSTRUCTOR IS CONSTRUCTOR1(DB-PATH, QUERY-STRING),
                HANDLE IS MY-ASSY-HANDLE.
                
           INQUIRE MY-ASSY-HANDLE @LastErrMsg IN ERROR-MESSAGE;
           perform until BOOL-RTN EQUAL 0
              MODIFY MY-ASSY-HANDLE "GetNext"(ORDER-NUMBER,
					     PRODUCT-NAME,
					      ORDER-QUANT) 
					      GIVING BOOL-RTN
	      MOVE ORDER-QUANT TO DISPLAY-ORDER-QUANT
	      If BOOL-RTN NOT EQUAL 0 
	         modify grid-1, record-to-add = GRID-RECORD
	      END-IF    				      
           end-perform.
	
           modify grid-1, cursor-x = 2, cursor-y = 2.

      * Bitmaps can be place into grid cells, but bitmap controls cannot.
      * To animate a bitmap in a grid cell, set up an infinite loop, and
      * perform it in a thread of its own.  To achieve the spinning effect,
      * MODIFY the bitmap number on a time interval.  In this example,
      * the interval is 2/10 of a second, and is regulated by a call to
      * C$SLEEP.

       animate-bitmap.

           perform until 2 = 1
             perform varying bmp-num from 1 by 1 until bmp-num > 15
               modify grid-1,
                 x = 1, y = 1,
                 bitmap = gt-bitmap
                 bitmap-number = bmp-num
                 bitmap-width = 16,
                 bitmap-trailing = 1

                 call "c$sleep" using 0.2
             end-perform
           end-perform.

      * The ABOUT window is an INDEPENDENT WINDOW, and can be minimized
      * independently of the Main Window.  It is also a MODELESS WINDOW,
      * and is executed in its own THREAD.

       explain-the-program.
           display independent window line 10 col 10
                   title-bar, system menu,
                   title "About GridCtl",
                   lines 17 size 60
                   auto-minimize
                   modeless bind to thread
                   handle window-1.

           display about-screen.
           perform load-comments.

           perform until exit-about-screen
             accept about-screen on exception continue end-accept
           end-perform.

           modify about-pb, enabled = 1.
           call "w$menu" using wmenu-enable, grid-menu, 15.

      * An unsorted Listbox is an excellent tool for presenting comments

       load-comments.
           modify comments-listbox, reset-list = 1                    .
           move "Using the Grid Control Demo Program" to scratch      .
           modify comments-listbox, item-to-add = scratch             .
           move "-" to scratch                                        .
           modify comments-listbox, item-to-add = scratch             .
           move "Drag the Mouse across Column Headings" to scratch    .
           modify comments-listbox, item-to-add = scratch             .
           move "Drag the Mouse down Row Headings" to scratch         .
           modify comments-listbox, item-to-add = scratch             .
           move "Left-click on a Grid Cell, and Drag Mouse" to scratch.
           modify comments-listbox, item-to-add = scratch             .
           move "Click on a Column Heading" to scratch                .
           modify comments-listbox, item-to-add = scratch             .
           move "Click on a Row Heading" to scratch                   .
           modify comments-listbox, item-to-add = scratch             .
           move "Click on a Column Heading Divider, and " to scratch  .
           modify comments-listbox, item-to-add = scratch             .
           move "  adjust column width by dragging divider" to scratch.
           modify comments-listbox, item-to-add = scratch             .
           move "Launch Vertical Popup Menu by: " to scratch          .
           modify comments-listbox, item-to-add = scratch             .
           move "  Clicking on Bitmap in Cell (1,1) " to scratch      .
           modify comments-listbox, item-to-add = scratch             .
           move "  Right-clicking on the Grid Control" to scratch     .
           modify comments-listbox, item-to-add = scratch             .
           move "Click on cell, and enter data" to scratch            .
           modify comments-listbox, item-to-add = scratch             .
           move "To cancel entry, press the ESC key" to scratch       .
           modify comments-listbox, item-to-add = scratch             .

      * Since the ABOUT screen is a MODELESS WINDOW, it must be launched
      * in its own THREAD.

       exception-handler.
           evaluate true
             when about-pressed
               modify about-pb, enabled = 0
               call "w$menu" using wmenu-disable, grid-menu, 15
               perform thread explain-the-program handle about-thread
           end-evaluate.

      * We have selected a subset of the GRID control's events, and
      * programmed responses to them.  In each case, the programmed response
      * is that a color change occur, and that the color change affect a
      * prescribed range of cells in the GRID.

       grid-1-handler.
           evaluate event-type

             when msg-goto-cell
             when msg-goto-cell-mouse
                 modify grid-1, region-color = 0

             when msg-bitmap-clicked
                 call "w$menu" using wmenu-popup, grid-menu

             when msg-goto-cell-drag
                 modify grid-1,
                   drag-color = bright-white + bckgrnd-red

              when msg-heading-clicked
              when msg-heading-dragged
                  inquire grid-1, x in grid-x, y in grid-y

                  evaluate true
                    when grid-x = 1 and grid-y = 1
                       modify grid-1, region-color = 0
                    when in-row-headings
                       modify grid-1,
                         start-x = 2, start-y = grid-y
                         x = max-cols, y = grid-y,
                         region-color = bright-white + bckgrnd-black

                    when in-column-headings
                      modify grid-1,
                        start-x = grid-x, start-y = 2,
                        x = grid-x, y = max-rows
                        region-color = bright-white + bckgrnd-black

                  end-evaluate

           end-evaluate.
      *
       copy "gridctl.cpy".

       initialization.
           accept terminal-abilities from terminal-info.
           if not has-graphical-interface
             display message box
               "This program requires a GUI runtime"
             stop run
           end-if.
