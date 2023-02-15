       identification division.
       program-id.  Win_Font_size.
       date-written.  8-July-95

      * Copyright (c) 1996-2006 by Acucorp, Inc.  Users of ACUCOBOL
      * may freely modify and redistribute this program.

       remarks.
           This program demonstrates the differences due to
           fonts using the PUSH BUTTON control type.

      *************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       copy "def/acucobol.def".
       copy "def/acugui.def".

       77  large-font                  USAGE   HANDLE.
       77  medium-font                 USAGE   HANDLE.
       77  small-font                  USAGE   HANDLE.
       77  fixed-font                  USAGE   HANDLE.
       77  traditional-font            USAGE   HANDLE.
       77  default-font                USAGE   HANDLE.

       77  key-status
                is SPECIAL-NAMES  CRT STATUS   pic 9(4).
                88  exit-button-pushed         value 13.
       77  push-button-data                    pic 9 value 9.
       77  push-choice-field                   pic x(10).

      *************************************************
       screen section.
       01  screen-1.
           03  push-button, "Exit",
               ok-button,
               line 18, column 25, size 20,
               FONT LARGE-FONT.

           03  push-button, "PUSH BUTTON",
               default-button,
               column 5, line 3, size 20,
               FONT FIXED-FONT.

           03  label, "FIXED font, buttonsize 20",
               column 28
               FONT FIXED-FONT.

           03  push-button, "PUSH BUTTON",
               column 5, line + 2, size 20,
               FONT TRADITIONAL-FONT.

           03  label, "TRADITIONAL font, buttonsize 20",
               column 28
               FONT TRADITIONAL-FONT.

           03  push-button, "PUSH BUTTON",
               column 5, line + 2, size 20,
               FONT DEFAULT-FONT.

           03  label, "DEFAULT font, buttonsize 20",
               column 28
               FONT DEFAULT-FONT.

           03  push-button, "PUSH BUTTON",
               column 5, line + 2, size 20,
               FONT LARGE-FONT.

           03  label, "LARGE font, buttonsize 20",
               column 28
               FONT LARGE-FONT.

           03  push-button, "PUSH BUTTON",
               column 5, line + 2, size 20,
               FONT MEDIUM-FONT.

           03  label, "MEDIUM font, buttonsize 20",
               column 28
               FONT MEDIUM-FONT.

           03  push-button, "PUSH BUTTON",
               column 5, line + 2, size 20,
               FONT SMALL-FONT.

           03  label, "SMALL font, buttonsize 20",
               column 28
               FONT SMALL-FONT.

           03  push-button, "PUSH BUTTON",
               column 5, line + 2, size 20.

           03  label, "no font, buttonsize 20",
               column 28.

      *************************************************
       procedure division.
       main-logic.
      *    Setup a gray screen background
           display standard window,
               title "Font Size Sample - fontsize.cbl",
               lines 20, size 65,
               background-low.

      *    Grab all the fonts
           accept large-font from standard object "large-font".
           accept medium-font from standard object "medium-font".
           accept small-font from standard object "small-font".
           accept fixed-font from standard object "fixed-font".
           accept traditional-font from
                                standard object "traditional-font".
           accept default-font from standard object "default-font".

           display screen-1.
             perform, with test after, until exit-button-pushed
                accept screen-1
                      on exception display screen-1
                end-accept
                display screen-1
             end-perform.
           stop run.
