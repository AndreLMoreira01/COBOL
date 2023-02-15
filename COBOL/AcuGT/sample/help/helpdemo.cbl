program-id.  HelpDemo.
remarks.
	This program demonstrates the basics of supplying context
	sensitive help using Windows Help.

working-storage section.
copy "../def/acugui.def".
copy "helpids.def".

* The following two "modes" are the exception values this program
* assigns to trigger help.  The values were chosen to match the
* default exception values of the F1 and Shift-F1 keys.
78  item-help-mode			value 1.
78  help-cursor-mode			value 11.

77  toolbar-1				handle of window.
77  help-cursor-bitmap			pic s9(9) comp-4.
77  small-font				handle of font.

77  key-value
    is special-names crt status		pic 9(5).

screen section.
01  tools-1.
    03  push-button, bitmap, self-act,
	col 57, size 16, lines 15
	exception-value = help-cursor-mode,
	bitmap-handle = help-cursor-bitmap,
	bitmap-number = 1.

01  screen-1, help-id = no-help.
    03  label "Field &1:", line 3, col 2.
    03  entry-field, col 10, 3-d, help-id = field-1-help.
    03  label "Field &2:", line + 2, col 2.
    03  entry-field, col 10, size 15, 3-d, help-id = field-2-help.
    03  frame, raised, line + 3, col 6, lines 6 cells, size 50 cells.
    03  label, "This program provides a simple demonstration of how 
-              "to build context-sensitive help.  You can use the 
-              "mouse, menu or keyboard (F1 and Shift-F1) to get help 
-              "on the two entry fields.", font small-font
               line + 1, col 8, size 44 cells, lines 4
	       help-id = text-help.
    03  push-button, "E&xit", ok-button, size 10, line 16, col 26,
	help-id = exit-help.


procedure division.
main-logic.

* Construct the screen

	call "w$bitmap" using wbitmap-load, "helpcur.bmp"
		giving help-cursor-bitmap.
	accept small-font from standard object "small-font".

	display standard graphical window, background-low,
		lines 18, size 60.

	display tool-bar, handle in toolbar-1.
	display tools-1 upon toolbar-1.

	perform build-helpdemo-menu.
	call "w$menu" using wmenu-show, menu-handle.

	display screen-1.

* Setup help automation

	set exception values help-cursor-mode to help-cursor,
			     item-help-mode to item-help.
	set environment "HELP-PROGRAM" to "winhelp".

* Run the screen until the user exits

	perform until key-value = 13
	    accept screen-1 on exception continue end-accept
	end-perform.

	stop run.

	copy "helpmenu.cpy".
