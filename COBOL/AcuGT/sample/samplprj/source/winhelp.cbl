program-id.  WinHelp.
remarks.
	This program is an "AcuHelp" program that calls Windows Help.

working-storage section.
78  help-file			value "HelpDemo.hlp".

copy "winhelp.def".

linkage section.
01  event-data.
    03  event-type		pic x(4) comp-x.
    03  event-window-handle     handle of window.
    03  event-control-handle    handle.
    03  event-control-id        pic xx comp-x.
    03  event-data-1            signed-short.
    03  event-data-2            signed-long.
    03  event-action            pic x comp-x.
           
procedure division using event-data.
main-logic.
	call "$winhelp" using help-file, help-contextpopup, event-data-2.
	exit program.
