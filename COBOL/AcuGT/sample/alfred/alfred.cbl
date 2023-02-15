identification division.
program-id.	Alfred is initial program.
author.		Randy Zack, Acucorp, Inc.
		This program is a generic Data File Editor.
		It has two modes: editing with an XFD file, and editing
		without.  With an XFD, field names are used, and editing
		is more like a standard File Maintenance Program.  Without
		an XFD, all you get is Hex or Octal, and ASCII editing.
		This program requires version 3.0.0 or later.

	RCS INFO: $Id: alfred.cbl 45102 2006-01-12 19:46:07Z merge $


environment division.
configuration section.
special-names.
	switch-1  on status is sw-1-on
		 off status is sw-1-off
	class map-chars is " ADOX"	| Alpha, Decimal, Octal, heX
	class hex-chars is " 0123456789aAbBcCdDeEfF"
	class octal-chars is "01234567"
	class printable-euro is 32 thru 127 129 thru 160 162 thru 256
	class printable-ascii is 32 thru 126
	event status is event-status-group
	screen control is control-name.

input-output section.
file-control.
select	optional allow-file assign to input allow-filename
	organization line sequential
	access sequential
	file status is allow-file-status.

select	optional print-file assign to output printer-name
	organization line sequential
	access sequential
	file status is printer-status.

data division.
file section.
fd  allow-file.
01  allow-file-rec.
    03  allow-name		pic x(12).
    03  allow-file		pic x(68).

fd  print-file.
01  print-rec			pic x(80).

working-storage section.

78  NEWLINE			value H"0A".
78  first-binary-col		value 7.
78  binary-col-sep		value 35.
78  first-ascii-col		value 64.
78  ascii-col-sep		value 72.
78  record-window-line		value 2.
78  shift-bytes			value 30.
78  max-seg-bytes		value 70.
78  max-seg-map-string-bytes	value 500.
78  max-text-length		value 500.
78  number-of-controls		value 75.
78  print-width			value 80.

***  Values used in radio buttons
78  radio-input-value		value 1.
78  radio-io-value		value 2.

***  Values used in exc-key
78  key-no-key			value 0.
78  key-backspace		value 8.
78  key-tab-key			value 9.
78  key-shift-tab-key		value 11.
78  key-return-key		value 13.
78  key-next-key		value 14.
78  key-previous-key		value 16.
78  key-toggle-key		value 19.
78  key-undo-key		value 20.
78  key-escape-key		value 27.
78  key-left-arrow		value 50.
78  key-right-arrow		value 51.
78  key-up-arrow		value 52.
78  key-down-arrow		value 53.
78  key-home-key		value 65.
78  key-end-key			value 66.
78  key-page-up			value 67.
78  key-page-down		value 68.
78  key-about-key		value 254.
78  key-help-key		value 255.
78  key-button-pressed		value 80.
78  key-button-double-clicked	value 81.
78  key-event-happened		value 96.
78  key-browse-selected		value 128.

***  When in undo-pos, undo-byte is a count
78  count-position		value 50000.

***  Level 78's for alfred menus

78  file-submenu		value 180.
78  menu-open-file		value 181.
78  menu-reference-key		value 182.
78  menu-open-io		value 183.
78  menu-open-input		value 184.
78  menu-print			value 185.
78  menu-exit			value  27.

78  edit-submenu		value 190.
78  menu-undo			value 191.

78  start-submenu		value 200.
78  menu-start-nlt		value 201.
78  menu-start-ngt		value 202.
78  menu-start-first		value 203.
78  menu-start-last		value 204.

78  record-submenu		value 210.
78  menu-add-record		value 211.
78  menu-delete-record		value 212.
78  menu-save-record		value 213.
78  menu-next-record		value 214.
78  menu-previous-record	value 215.

78  options-submenu		value 220.
78  menu-hex			value 221.
78  menu-octal			value 222.
78  menu-ascii-area		value 223.
78  menu-raw-area		value 224.
78  menu-eval-conditions	value 225.
78  menu-next-page		value 226.
78  menu-previous-page		value 227.

78  help-submenu		value 250.
78  menu-about			value key-about-key.
78  menu-help			value key-help-key.

01  handles.
    03  std-font-handle		handle of font.
    03  main-window-handle	handle of window.
    03  help-window-handle	handle of window.
    03  toolbar-handle		handle of window.
    03  pic-handle		pic s9(9) comp-4 value 0.
    03  entry-style		pic xxxx comp-x.
    03  base-style		pic xxxx comp-x.
    03  entry-handles		handle of entry-field
				occurs number-of-controls times
				indexed by handle-idx.
    03  label-handles		handle of label
				occurs number-of-controls times.

01  event-status-group.
    03  event-type		pic x(4) comp-x.
    03  event-window-handle	handle.
    03  event-control-handle	handle.
    03  event-control-id	pic xx comp-x.
    03  event-data-1		unsigned-short.
    03  event-data-2		unsigned-long.

77  alfred-main-menu		pic s9(9) comp-4.
 
copy "def/acucobol.def".
copy "def/acugui.def".
copy "def/controls.def".
copy "def/opensave.def".
copy "ParseXFD.ws".
copy "alfred.ws".

01  alfred-version-message.
    05				pic x(7) value "Alfred".
    05				pic x(6) value "7.0.0".
    05				pic x value NEWLINE.
    05				pic x(40) value "Copyright (c) 1995-2006".
    05				pic x value NEWLINE.
    05				pic x(20) value "Acucorp, Inc.".
01  created-by-alfred		pic x(22) value "Created by Alfred on".
01  message-group.
    03  icon-type		pic 9.
    03  response		pic 9.
	88  respond-yes			value 1.
	88  respond-no			value 2.
	88  respond-cancel		value 3.

01  alfred-print-header-line-info.
    03  alfred-special-locations.
	05  month-loc		pic 999.		| %m
	05  year-loc		pic 999.		| %y
	05  century-loc		pic 999.		| %c
	05  day-of-month-loc	pic 999.		| %d
	05  full-date-loc	pic 999.		| %D
	05  hour-loc		pic 999.		| %H
	05  minute-loc		pic 999.		| %M
	05  second-loc		pic 999.		| %S
	05  full-time-loc	pic 999.		| %T
	05  abbrev-weekday-loc	pic 999.		| %a
	05  abbrev-month-loc	pic 999.		| %h
	05  full-ampm-time-loc	pic 999.		| %r
	05  page-number-loc	pic 999.		| %p
	05  filename-loc	pic 999.		| %f
    03  location-decoder.
        05  location-line	pic 9.
        05  location-column	pic 99.
    03  alfred-date		pic 9(8).
    03  alfred-time		pic 9(8).
    03  alfred-full-date.
	05  alfred-century	pic 99.
	05  alfred-year		pic 99.
	05  filler		pic x	value '/'.
    	05  alfred-month	pic 99.
	05  filler		pic x	value '/'.
	05  alfred-day-of-month	pic 99.
    03  alfred-full-time.
	05  alfred-hour		pic 99.
	05  filler		pic x	value ':'.
	05  alfred-minute	pic 99.
	05  filler		pic x	value ':'.
	05  alfred-second	pic 99.
    03  alfred-full-ampm-time.
	05  alfred-ampm-hour	pic 99.
	05  filler		pic x(6).
	05  alfred-ampm		pic xx.
    03  alfred-weekday		pic xxx.
    03  alfred-abbrev-month	pic xxx.
    03  page-number		pic 999.
    03  disp-page-number	pic zz9.
    03  number-of-header-lines	pic 9.
    03  alfred-header-lines	pic x(print-width)
    				occurs 9 times.

*  All displayed messages and strings are in this copy file.
copy "alfmsgs.cpy".

01  acumsg-group.
    03	msg-text		pic x(80).
    03	msg-size		pic 99.
01  toolbar-info.
    03  toolbar-page-up-enabled	pic 9	value 0.
    03  toolbar-page-dn-enabled	pic 9	value 1.
    03  bitmap-file-name	pic x(80).
    03  tools-bitmap		pic s9(9) comp-4.
    03  toolbar-sizes.
***  These values should be the length of the corresponding strings below
***  Though if there is a .bmp file that has graphical buttons, these
***  values will be reset to the bitmap number
	05  toolbar-input-sz	pic 999 value 6.
	05  toolbar-io-sz	pic 999 value 4.
	05  toolbar-pg-up-sz	pic 999 value 8.
	05  toolbar-pg-dn-sz	pic 999 value 10.
	05  toolbar-prev-rec-sz	pic 999 value 16.
	05  toolbar-next-rec-sz	pic 999 value 12.
    03  toolbar-sizes-table redefines toolbar-sizes
				pic 999
				occurs 6 times.
    03  toolbar-titles.
	05  toolbar-input	pic x(20) value "Input".
	05  toolbar-io		pic x(20) value "I/O".
	05  toolbar-pg-up	pic x(20) value "Page Up".
	05  toolbar-pg-dn	pic x(20) value "Page Down".
	05  toolbar-prev-rec	pic x(20) value "Previous Record".
	05  toolbar-next-rec	pic x(20) value "Next Record".
    03  toolbar-titles-table redefines toolbar-titles
				pic x(20)
				occurs 6 times.

77  f-int-errno-disp		pic s9(4).
77  f-errno-disp		pic s9(4).
77  save-area1			pic x(10).
77  save-area2			pic x(10).
77  new-file-area		pic x(10).
77  logical-info-area		pic x(10).
77  seg-num			pic 99.
77  next-seg			pic 99 value 0.
77  disp-key-num		pic 999	value 0.
77  save-key-num		pic 999.
77  disp-seg-offset		pic zzzzzzzzz9.
77  disp-seg-len		pic zz9.
77  temp-idx			pic 99.
77  temp-idx2			pic 99.
77  init-value			pic x.
77  convert-function		pic x(10).
77  allow-filename		pic x(20).
77  allow-file-status		pic xx.
77  allow-present		pic xx.
    88  allow-not-present		value "05".
77  deny-present		pic xx.
    88  deny-not-present		value "05".
77  printer-status		pic xx.
77  extended-printer-status	pic x(10).
77  rec-size-prompt		pic x(45).
77  rec-size			pic 9(5).
77  key-num-text-msg		pic x(80).

01  num-key-segs-table.
    03  num-key-segs		occurs max-keys times
				pic 99.
01  reset-this-key-list		pic 9	value 0.

01  directory-name		pic x(78).
01  base-filename		pic x(78).
01  file-extension		pic x(10).
01  file-info.
    03  file-size		pic x(8) comp-x.
    03  file-date		pic 9(8) comp-x.
    03  file-time		pic 9(8) comp-x.

01  control-name.
    03  accept-control		pic 9.
    03  control-value		pic 999.

01  flags.
    03	file-open-flag		pic x	value space.
	88  file-closed			value 'n'.
	88  file-open-input		value 'i'.
	88  file-open-io		value 'o'.
    03  yn-flag			pic xx	value 'NY'.
    03  printer-open-flag	pic x	value space.
	88  printer-open		value 'y' false 'n'.
    03  input-output-flag	pic 9	value 0.
	88  radio-file-open-input	value radio-input-value.
	88  radio-file-open-io		value radio-io-value.
    03	need-ext-errno-flag	pic x	value space.
	88  need-ext-errno		value 'y' false 'n'.
    03  filename-given-flag	pic x	value space.
	88  have-filename		value 'y' false 'n'.
    03	xfd-available-flag	pic x	value space.
	88  xfd-available		value 'y' false 'n'.
    03  redraw-screen-flag	pic x	value space.
	88  redraw-screen		value 'y' false 'n'.
    03  valid-keymap-flag	pic x	value space.
	88  valid-keymap		values 'y' 'Y' false 'n'.
    03  done-flag		pic x	value space.
	88  done			value 'y' false 'n'.
    03  mode-flag		pic x	value space.
	88  add-mode			values 'a' 'A'.
	88  change-mode			values 'c' 'C'.
	88  quit-mode			values 'q' 'Q'.
	88  view-mode			values 'v' 'V'.
    03  right-left-flag		pic x	value space.
	88  left-half			value 'l'.
	88  right-half			value 'r'.
    03  file-error-flag		pic x	value space.
	88  file-error			value 'y' false 'n'.
    03  hex-mode-flag		pic x	value 'x'.
	88  hex-mode			value 'x' false 'o'.
	88  octal-mode			value 'o' false 'x'.
    03  data-area-flag		pic x	value 'b'.
	88  binary-data			value 'b' false 'a'.
	88  ascii-data			value 'a' false 'b'.
    03  record-modified-flag	pic x	value space.
	88  record-modified		value 'y' false 'n'.
    03  field-modified-flag	pic x	value space.
	88  field-modified		value 'y' false 'n'.
    03  primary-key-flag	pic x	value space.
	88  primary-key-changed		value 'y' false 'n'.
    03  need-field-info-flag	pic x	value space.
	88  need-field-info		value 'y' false 'n'.
    03  terminate-field-flag	pic x	value space.
	88  terminate-field		value 'y' false 'n'.
    03  bad-char-flag		pic x	value space.
	88  bad-chars			value 'y' false 'n'.
    03  have-record-flag	pic x	value space.
	88  have-a-record		value 'y' false 'n'.
    03  allow-flag		pic x	value space.
	88  allowed			value 'y' false 'n'.
    03  found-in-file-flag	pic x	value space.
	88  found-in-file		value 'y' false 'n'.
    03  segment-chars-state	pic x	value space.
	88  parsing-paren		value 'y' false 'n'.
    03  back-fore-flag		pic x	value space.
	88  background			value 'y' false 'n'.
    03  use-text-toolbar-flag	pic x	value space.
	88  use-text-toolbar		value 'y' false 'n'.
    03  using-japanese-flag	pic x	value space.
	88  test-printable-ascii	value 'a'.
	88  test-printable-euro		value 'e'.
    03  printable-flag		pic x	value space.
	88  printable			value 'y' false 'n'.
    03  file-browse-flag	pic x	value space.
	88  browse-datafile		value 'd' false 'x'.
    03  confirm-on-delete-flag	pic x	value 'y'.
	88  confirm-on-delete		value 'y' false 'n'.
    03  confirm-on-write-flag	pic x	value 'y'.
	88  confirm-on-write		value 'y' false 'n'.
    03  field-on-page-flag	pic x	value 'y'.
	88  field-on-page		value 'y' false 'n'.
    03  save-exc-key		pic 999	value 0.
    03  exc-key			pic 999.
	88  no-key			value key-no-key.
	88  backspace			value key-backspace.
	88  tab-key			value key-tab-key.
	88  shift-tab-key		value key-shift-tab-key.
	88  return-key			value key-return-key.
	88  next-key			value key-next-key.
	88  previous-key		value key-previous-key.
	88  toggle-key			value key-toggle-key.
	88  undo-key			value key-undo-key.
	88  escape-key			value key-escape-key.
	88  left-arrow			value key-left-arrow.
	88  right-arrow			value key-right-arrow.
	88  up-arrow			value key-up-arrow.
	88  down-arrow			value key-down-arrow.
	88  home-key			value key-home-key.
	88  end-key			value key-end-key.
	88  page-up			value key-page-up.
	88  page-down			value key-page-down.
	88  help-key			value key-help-key.
	88  about-key			value key-about-key.
	88  button-pressed		value key-button-pressed.
	88  button-double-clicked	value key-button-double-clicked.
	88  event-happened		value key-event-happened.

01  program-info.
    03	num-parameters		pic 99 comp-1.
01  file-pointer		pointer.
01  passed-filename		pic x(78).
01  passed-xfdfile		pic x(78).
01  browse-visible		pic 9	value 0.
01  browse-suffix		pic x(10).
01  key-choices.
    03  key-choices-table
	occurs max-keys times	pic zz9.

01  keymap-ops.
    03  save-keymap		pic 9 value 1.
    03  restore-keymap		pic 9 value 0.
    03  keymap-success		pic 9 comp-1.

01  cursor-position.
    03  top-byte		pic 9(10).	| Byte or Key which is on top
    03  full-page		pic 99.		| Num lines per screen
    03  window-lines		pic 99.		| Num lines in this window
    03  line-no			pic s99.	| Line the cursor is on
    03  goto-line-no		pic s99.	| Line the the user clicked
    03  window-line-no		pic 99	value 1.
    03  save-line-no		pic 99.
    03  col-no			pic 999.	| Column the cursor is on
    03  save-col-no		pic 999.
    03  disp-col1		pic 999.	| Col for displaying hex/octal
    03  disp-col2		pic 999.	| Col for displaying ascii
    03  byte-counter		pic 9(10).	| Current position
    03  save-byte-counter	pic 9(10).
    03  first-byte-in-group	pic 9(10).
    03  save-byte-in-group	pic 9(10).
    03  octal-byte-num		pic 9.
    03  bytes-per-page		pic 999.
    03  number-of-keys-on-scrn	pic 99.
    03  field-size		pic 999.

01  user-message		pic x(79).
01  convert-group.
    03  numeric-value		pic x(8) comp-x.
    03  ascii-value		pic x(8)
	redefines numeric-value.
    03  temp-num		pic x(4) comp-x.
    03  temp-num2		pic x(4) comp-x.
    03  temp-3-asc-val		pic xxx.
    03  num-idx			pic xx comp-x.
    03  valid-range.
	05  low-range		pic x(8) comp-x.
	05  high-range		pic x(8) comp-x.
    03  temp-pic9		pic 9.
    03  temp-area		pic x(20).

01  key-map.
    03  temp-segment-map	pic x(max-seg-map-string-bytes).
    03  seg-byte		pic 999.
    03  save-seg-byte		pic 999.
    03  seg-map-len-table.
	05  seg-map-len		occurs max-segs times
				pic 999.
    03  one-section		pic x(max-seg-bytes).
    03  total-sect-size		pic x	comp-x.
    03  num-sects		pic x	comp-x.
    03  sect-maps		occurs 250 times indexed by seg-idx.
	05  sect-seg-num	pic 99.
	05  sect-type		pic x.
	    88  sect-ascii	value 'A'.
	    88  sect-hex	value 'X'.
	    88  sect-octal	value 'O'.
	    88  sect-decimal	value 'D'.
	05  sect-start		pic x	comp-x.		|start byte of section
	05  sect-size		pic x	comp-x.		|number of bytes in seg
	05  sect-bytes		pic x	comp-x.		|number of screen cols
	05  sect-line		pic x	comp-x.
	05  sect-col		pic x	comp-x.
    03  xfd-screen-information.
	05  segment-map-table	pic x(max-seg-map-string-bytes)
				occurs 16 times.
	05  key-label-table	pic x(30)
				occurs 16 times
				indexed by key-label-index.
	05  field-visible-table	pic 9
				occurs 16 times.
	05  field-indexes-table	pic 999
				occurs 16 times.
	05  field-lengths-table	pic 999
				occurs 16 times.

01  pri-key-info.
    03  pri-key-data.
	05  pri-num-segs	pic 99.
	05  filler		pic x value ','.
	05  pri-dups		pic 9.
	05  pri-seg-info occurs max-segs times.
	    07  filler		pic x value ','.
	    07  pri-key-size	pic 9(3).
	    07  filler		pic x value ','.
	    07  pri-key-offset  pic 9(10).
    03  pri-k-end		pic x value low-values.

* "pri-key-info" was changed in release 6.0.0 and some reference modification
* code that manipulates a memory buffer equivilant failed because it used literal 
* values.  That code has been modified to use the following 78 levels that 
* describe the lengths of various fields in "pri-key-info".  If you change 
* "pri-key-info", please make coorsponding changes to these "length-of" 78's:

78  lo-pri-num-segs		value 2.
78  lo-pri-dups			value 1.
78  lo-pri-key-size		value 3.
78  lo-pri-key-offset		value 10.

01  save-primary-key		pic x(250).
01  test-primary-key		pic x(250).
01  record-byte-num		pic 9(10).
01  one-char			pic x.
01  save-char			pic x.
01  accept-display-values.
    03  large-field				pic x(max-text-length).
    03  large-nat-field				pic n(max-text-length).
    03  large-wide-field			pic x(max-text-length)
							usage wide.
***   The following strangeness is so that the decimal points line up.
***   It makes our life easier in some ways.
    03  value-x80				pic x(80).
    03  float-group redefines value-x80.
	05  value-float				float.
    03  double-grou redefines value-x80.
	05  value-double			double.


*** Number of undo steps to allocate at a time.
78  number-of-undo-steps	value 13000.
01  undo-group.
    03  undo-data.
	05  undo-byte		pic x.
	05  undo-pos		pic xx	comp-x.
    03  undo-ptr		pointer.
    03  undo-data-size		pic x	comp-x.
    03  undo-first-byte		pic xx	comp-x.		| first byte in circle
    03  undo-current-byte	pic xx	comp-x.		| current undo
    03  undo-last-byte		pic xx	comp-x.		| last modification
    03  undo-offset		pic xx	comp-x.		| offset for M$get/put
    03  undo-wrap-flag		pic x value space.
	88  undo-wrap		value 'y' false 'n'.	| have we wrapped?

78  number-of-colors		value 8.
01  colors.
    03  color-table		usage unsigned-long.
	05  label-color			value 2052.
	05  entry-color			value 2052.
	05  banner-label-color		value 2051.
	05  banner-text-color		value 2051.
	05  highlight-color		value 2051.
	05  disabled-color		value 2052.
	05  help-color			value 2051.
	05  key-color			value 4101.
    03  color-array		usage unsigned-long
				redefines color-table
				occurs number-of-colors times
				indexed by color-idx.
    03  current-color-1		usage unsigned-long value 0.
    03  current-color-2		usage unsigned-long value 0.
    03  color-name-table.
	05  label-color-name	pic x(30)	value "alfred-label-color".
	05  entry-color-name	pic x(30)	value "alfred-entry-color".
	05  banner-label-color-name pic x(30)	value "alfred-banner-label-color".
	05  banner-text-color-name pic x(30)	value "alfred-banner-text-color".
	05  highlight-color-name pic x(30)	value "alfred-highlight-color".
	05  disabled-color-name	pic x(30)	value "alfred-disabled-color".
	05  help-color-name	pic x(30)	value "alfred-help-color".
	05  key-color-name	pic x(30)	value "alfred-key-color".
    03  color-name-array	pic x(30) redefines color-name-table
				occurs number-of-colors times.
    03  color-string		pic x(80).
    03  color-numeric		pic 9(9).
    03  color-string-table	pic x(10) occurs 10 times
				indexed by color-string-idx.

78  protected-color		value 32768.
01  seg-info.
    03  seg-indicator		occurs max-segs times
				pic x.
    03  seg-number-table	occurs max-segs times
				pic z9.
    03  seg-visible		occurs max-segs times
				pic 9.

01  malloc-sizes-and-offsets.
    03  malloc-size		pic x(4)	comp-x.
    03  offset-amount		pic x(5)	comp-x. 
    03  get-put-fcn		pic x(5).
    03  mem-area-bytes		pic 9.
    03  temp-mem-area		pic x(8).
    03  one-mem-byte		pic x.

01  translation-table		pic x(256).
01  have-translation-table	pic 9.

screen section.
01  filename-screen.
    03  label filename-title			line 2 col 3
	left
	size filename-title-size
	color label-color.
    03  entry-field using filename
	color entry-color 3-d				col filename-entry-col
	max-text 80
	size filename-entry-size
	before procedure is before-filename-proc.
    03  label xfdname-title			line + 2 col 3
	left
	size filename-title-size
	color label-color.
    03  myxfdname entry-field using xfdfile
	color entry-color 3-d				col filename-entry-col
	max-text 80
	size filename-entry-size
	before procedure is before-xfdfile-proc.
    03  push-button ok-button			line + 2.5 col 10.
    03  push-button cancel-button			col 23.
    03  push-button					col 36
	size 6 title help-title
	exception-value menu-help.
    03  push-button					col 49
	size 8 title browse-title
	exception-value key-browse-selected
	visible browse-visible.

01  rec-size-screen.
    03  label rec-size-prompt		line 1.5	col 5
	color label-color.
    03  entry-field using rec-size			col 30
	color entry-color 3-d.
    03  push-button ok-button		line + 2	col 10.
    03  push-button cancel-button			col 25.
    03  push-button size 6 title help-title		col 40
	exception-value menu-help.

01  header-screen.
    03  frame heavy engraved
	line 1
	col header-frame-col
	lines header-frame-lines cells
	size header-frame-size.
    03  label key-prompt
	line 1.5
	col key-prompt-col
	size key-prompt-size
	color banner-label-color.
    03  label disp-key-num
	line 1.5
	col key-msg-col
	color banner-text-color.
    03  label mode-prompt
	line 2.5
	col key-prompt-col
	size key-prompt-size
	color banner-label-color.
    03  label access-mode
	line 2.5
	col key-msg-col
	color banner-text-color.
    03  label byte-offset-msg
	line 3.5
	col key-prompt-col
	size key-prompt-size
	color banner-label-color
	visible offset-visible.
    03  label byte-offset
	line 3.5
	col key-msg-col
	color banner-text-color
	visible offset-visible.

01  logical-info-screen.
    03  label max-rec-size-prompt color label-color	line 1.1 col 3.
    03  entry-field using max-rec-size				col 30
	color entry-color 3-d.
    03  label min-rec-size-prompt color label-color	line + 1.3 col 3.
    03  entry-field using min-rec-size				col 30
	color entry-color 3-d.
    03  label num-keys-prompt color label-color		line + 1.3 col 3.
    03  entry-field using num-keys				col 30
	color entry-color 3-d.
    03  push-button ok-button				line + 2.1 col 5.
    03  push-button cancel-button				col 15.
    03  push-button size 6 title help-title
	exception-value menu-help				col 25.

01  xfd-key-screen			line 0.
    03  key-field-screen		occurs 16 times
	visible field-visible-table.
	05  label key-label-table	line + 1	col 3
	    color label-color.
	05  entry-field					col disp-col1
	    using segment-map-table
	    max-text field-lengths-table
	    size 40
	    auto 3-d
	    color entry-color.
    03  push-button ok-button		line btn-line	col 5.
    03  push-button cancel-button			col 25.
    03  push-button size 6 title help-title		col 45
	exception-value menu-help.

01  key-map-screen.
    03  label key-map-header-1		line 1		col 3
	color label-color.
    03  label key-map-header-2				col 11
	color label-color.
    03  label key-map-header-3				col 19
	color label-color.
    03  key-indicators-screen.
	05  occurs max-segs times visible seg-visible.
	    07  label seg-indicator	line + 1	col 1.4
		color label-color.
    03					line 1.
    03  key-segments-screen		occurs max-segs times
	visible seg-visible.
	05  label seg-number-table	line + 1	col 5
	    color label-color.
	05  label from key-size				col 11
	    color label-color
	    pic zz9.
	05  entry-field					col 19
	    using segment-map-table
	    max-text = seg-map-len
	    size seg-map-len
	    auto upper 3-d
	    color entry-color
	    before procedure is prep-seg-size
	    after procedure is test-seg-map.
    03  push-button ok-button		line btn-line	col 5.
    03  push-button cancel-button			col 25.
    03  push-button size 6 title help-title		col 45
	exception-value menu-help.

01  toolbar1-screen.
    03  radio-button					col 2
	title toolbar-input
	value input-output-flag
	size toolbar-input-sz
	self-act
	group 1
	group-value = radio-input-value
	exception-value menu-open-input.
    03  radio-button					overlap-left
	title toolbar-io
	value input-output-flag
	size toolbar-io-sz
	self-act
	group 1
	group-value = radio-io-value
	exception-value menu-open-io.
    03  push-button					col + 2
	title toolbar-pg-up
	size toolbar-pg-up-sz
	self-act
	enabled = toolbar-page-up-enabled
	exception-value menu-previous-page.
    03  push-button					overlap-left
	title toolbar-pg-dn
	size toolbar-pg-dn-sz
	self-act
	enabled = toolbar-page-dn-enabled
	exception-value menu-next-page.
    03  push-button					col + 2
	title toolbar-prev-rec
	size toolbar-prev-rec-sz
	self-act
	exception-value menu-previous-record.
    03  push-button					overlap-left
	title toolbar-next-rec
	size toolbar-next-rec-sz
	self-act
	exception-value menu-next-record.

***   This one uses bitmaps
01  toolbar2-screen.
    03  radio-button					col 2
	title toolbar-input
	value input-output-flag
	bitmap, bitmap-number = toolbar-input-sz
	self-act
	group 1
	group-value = 1
	exception-value menu-open-input.
    03  radio-button					overlap-left
	title toolbar-io
	value input-output-flag
	bitmap, bitmap-number = toolbar-io-sz
	self-act
	group 1
	group-value = 2
	exception-value menu-open-io.
    03  push-button					col + 2
	title toolbar-pg-up
	bitmap, bitmap-number = toolbar-pg-up-sz
	self-act
	enabled = toolbar-page-up-enabled
	exception-value menu-previous-page.
    03  push-button					overlap-left
	title toolbar-pg-dn
	bitmap, bitmap-number = toolbar-pg-dn-sz
	self-act
	enabled = toolbar-page-dn-enabled
	exception-value menu-next-page.
    03  push-button					col + 2
	title toolbar-prev-rec
	bitmap, bitmap-number = toolbar-prev-rec-sz
	self-act
	exception-value menu-previous-record.
    03  push-button					overlap-left
	title toolbar-next-rec
	bitmap, bitmap-number = toolbar-next-rec-sz
	self-act
	exception-value menu-next-record.

01  main-menu-help-screen.
    03  entry-field using multiple main-menu-help-text-table
    	lines 15, size 76 cells
    	vscroll-bar, 3-d, read-only no-autosel.
    03  push-button ok-button line 17 col 35.

01  enter-file-help-screen.
    03  entry-field using multiple enter-file-help-text-table
	lines 4, size 45 cells
	vscroll-bar, 3-d, read-only no-autosel.
    03  push-button ok-button line 6 col 19.

01  sort-key-help-screen.
    03  entry-field using multiple sort-key-help-text-table
	lines 8, size 45 cells
	vscroll-bar, 3-d, read-only no-autosel.
    03  push-button ok-button line 10 col 19.

01  enter-keymap-help-screen.
    03  entry-field using multiple enter-keymap-help-text-table
	lines 13, size 76 cells
	vscroll-bar, 3-d, read-only no-autosel.
    03  push-button ok-button line 15 col 35.

01  enter-key-no-xfd-help-screen.
    03  entry-field using multiple enter-key-no-xfd-help-text-table
	lines 4, size 45 cells
	vscroll-bar, 3-d, read-only no-autosel.
    03  push-button ok-button line 6 col 19.

01  enter-key-with-xfd-help-screen.
    03  entry-field using multiple enter-key-with-xfd-help-text-table
	lines 5, size 45 cells
	vscroll-bar, 3-d, read-only no-autosel.
    03  push-button ok-button line 7 col 19.

01  enter-recordsize-help-screen.
    03  entry-field using multiple enter-recordsize-help-text-table
	lines 4, size 45 cells
	vscroll-bar, 3-d, read-only no-autosel.
    03  push-button ok-button line 6 col 19.

01  logical-info-help-screen.
    03  entry-field using multiple logical-info-help-text-table
	lines 8, size 45 cells
	vscroll-bar, 3-d, read-only no-autosel.
    03  push-button ok-button line 10 col 19.

procedure division chaining passed-filename, passed-xfdfile.
declaratives.
print-file-section section.
    use after error procedure on print-file.
print-error.
    display message box printer-name NEWLINE extended-printer-status
	type is MB-OK, icon is MB-ERROR-ICON, title is error-title.

end declaratives.

main-level section 0.
main.
    perform startup.
    perform process-filename.
    perform disable-page-up.
    if key-num = -1
	move menu-open-file to save-exc-key
    else
	move menu-start-first to save-exc-key
    end-if.
    move 0 to exc-key.
    perform until exc-key = menu-exit
	if save-exc-key not = 0
	    move save-exc-key to exc-key
	    move 0 to save-exc-key
	    perform main-menu-select
	else
	    accept omitted line 1 col 1
	      exception exc-key
		perform main-menu-select
	    end-accept
	end-if
    end-perform.
    perform shutdown.

main-menu-select.
    evaluate exc-key
      when menu-open-file
	perform get-file-name
	if exc-key = menu-exit
	    perform shutdown
	end-if
	perform process-filename
	if key-num = -1
	    move menu-open-file to save-exc-key
	else
	    move menu-start-first to save-exc-key
	end-if
	move 0 to exc-key
      when menu-reference-key
	perform get-access-key
	if key-num = -1
	    move menu-open-file to save-exc-key
	else
	    move menu-start-first to save-exc-key
	end-if
	move 0 to exc-key
      when menu-open-input
	perform open-file-input
	if file-open-input
	    set view-mode to true
	end-if
      when menu-open-io
	perform open-file-io
	if file-open-io
	    set change-mode to true
	end-if
      when menu-start-nlt
      when menu-start-ngt
	perform start-file-nlt-or-ngt
	if not have-a-record
	    perform restore-position
	end-if
	perform process-record
      when menu-start-first
	perform start-first-record
	if not file-error
	    perform process-record
	end-if
      when menu-start-last
	perform start-last-record
	if not file-error
	    perform process-record
	end-if
      when menu-next-record
      when key-next-key
	perform read-next-record
	if not file-error
	    perform process-record
	end-if
      when menu-previous-record
      when key-previous-key
	perform read-previous-record
	if not file-error
	    perform process-record
	end-if
      when menu-add-record
	if file-open-input
	    perform open-mode-error
	else
	    perform get-record-size
	    if record-size not = 0
		move low-values to init-value
		perform initialize-record
		if not xfd-available
		    perform get-one-key of no-xfd
		else
		    perform get-one-key of with-xfd
		end-if
		if not escape-key
		    set add-mode to true
		    set redraw-screen to true
		    perform process-record
		end-if
	    end-if
	end-if
      when menu-help
	perform show-main-menu-help
      when menu-about
	perform show-about-alfred
      when menu-exit
	perform shutdown
    end-evaluate.

beep-user.
    display omitted bell with no advancing.

show-main-menu.
    call "W$MENU" using wmenu-show alfred-main-menu.

show-toolbar.
    if use-text-toolbar
	display toolbar1-screen upon toolbar-handle
    else
	display toolbar2-screen upon toolbar-handle
    end-if.

show-about-alfred.
    display message box alfred-version-message
	title is "Alfred", type is MB-OK, icon is MB-DEFAULT-ICON.

print-record.
    perform open-printer.
    if not printer-open
	exit paragraph
    end-if.
    move line-no to save-line-no.
    move byte-counter to save-byte-counter.
    move first-byte-in-group to save-byte-in-group.
    move xfd-field-index to save-xfd-field-index.
    perform get-header-lines.
    if xfd-available
	perform print-record-with-xfd
    else
	perform print-record-no-xfd
    end-if.
    move save-line-no to line-no.
    move save-byte-counter to byte-counter.
    move save-byte-in-group to first-byte-in-group.
    move save-xfd-field-index to xfd-field-index.
    perform close-printer.

print-header.
    move 1 to line-no.
    perform varying line-no from 1 by 1 until
		line-no > number-of-header-lines
	move month-loc to location-decoder
	if location-line = line-no
	    move alfred-month to
		 alfred-header-lines (line-no) (location-column:2)
	end-if
	move year-loc to location-decoder
	if location-line = line-no
	    move alfred-year to
		 alfred-header-lines (line-no) (location-column:2)
	end-if
	move century-loc to location-decoder
	if location-line = line-no
	    move alfred-century to
		 alfred-header-lines (line-no) (location-column:2)
	end-if
	move day-of-month-loc to location-decoder
	if location-line = line-no
	    move alfred-day-of-month to
		 alfred-header-lines (line-no) (location-column:2)
	end-if
	move full-date-loc to location-decoder
	if location-line = line-no
	    move alfred-full-date to
		 alfred-header-lines (line-no) (location-column:10)
	end-if
	move hour-loc to location-decoder
	if location-line = line-no
	    move alfred-hour to
		 alfred-header-lines (line-no) (location-column:2)
	end-if
	move minute-loc to location-decoder
	if location-line = line-no
	    move alfred-minute to
		 alfred-header-lines (line-no) (location-column:2)
	end-if
	move second-loc to location-decoder
	if location-line = line-no
	    move alfred-second to
		 alfred-header-lines (line-no) (location-column:2)
	end-if
	move full-time-loc to location-decoder
	if location-line = line-no
	    move alfred-full-time to
		 alfred-header-lines (line-no) (location-column:8)
	end-if
	move abbrev-weekday-loc to location-decoder
	if location-line = line-no
	    move alfred-weekday to
		 alfred-header-lines (line-no) (location-column:3)
	end-if
	move abbrev-month-loc to location-decoder
	if location-line = line-no
	    move alfred-abbrev-month to
		 alfred-header-lines (line-no) (location-column:3)
	end-if
	move full-ampm-time-loc to location-decoder
	if location-line = line-no
	    move alfred-full-ampm-time to
		 alfred-header-lines (line-no) (location-column:11)
	end-if
	move page-number-loc to location-decoder
	if location-line = line-no
	    move page-number to disp-page-number
	    move disp-page-number to
		 alfred-header-lines (line-no) (location-column:3)
	end-if
	move filename-loc to location-decoder
	if location-line = line-no
	    set temp-num to size of filename
	    perform until filename (temp-num - 1:) not = spaces
		subtract 1 from temp-num
	    end-perform
	    move filename to
		 alfred-header-lines (line-no) (location-column:temp-num + 1)
	end-if
	move alfred-header-lines (line-no) to print-rec
	if line-no = 1 and page-number not = 1
	    write print-rec after page
	else
	    write print-rec
	end-if
    end-perform.
    add 1 to page-number.

open-printer.
    if printer-open
	perform close-printer
    end-if.
    move 60 to lines-per-page.
    accept user-message from environment "ALFRED-GET-PRINTER".
    if user-message not = spaces
	call user-message using alfred-get-printer-group
	  on exception
	    continue
	end-call
    end-if.
    if printer-name not = spaces
	open output print-file
	if printer-status = "00"
	    set printer-open to true
	    exit paragraph
	end-if
    end-if.
    accept printer-name from environment "ALFRED-PRINTER-NAME". 
    if printer-name not = spaces
	open output print-file
	if printer-status = "00"
	    set printer-open to true
	    exit paragraph
	end-if
    end-if.
    if operating-system (1:3) = "WIN"		| All Windows variants
	move "-P SPOOLER" to printer-name
    else
	move "PRINTER" to printer-name
    end-if.
    open output print-file.
    if printer-status = "00"
	set printer-open to true
    end-if.

close-printer.
    if printer-open
	close print-file
	set printer-open to false
    end-if.

get-header-lines.
    move 0 to number-of-header-lines.
    move 1 to line-no.
    move "ALFRED-PRINT-HEADER-n" to user-message.
    move all '0' to alfred-special-locations.
    move 1 to page-number.
    perform varying line-no from 1 by 1 until line-no > 9
	move line-no to number-of-header-lines
	move number-of-header-lines to user-message (21:1)
	accept alfred-header-lines (line-no) from environment user-message
	if alfred-header-lines (line-no) = spaces
	    exit perform cycle
	end-if
	move line-no to number-of-header-lines
	move line-no to location-line
	move 0 to temp-num
	perform until temp-num >= print-width
	    add 1 to temp-num
	    if alfred-header-lines (line-no) (temp-num:1) not = '%'
		exit perform cycle
	    end-if
	    evaluate alfred-header-lines (line-no) (temp-num + 1:1)
	      when '%'
	        move ' ' to alfred-header-lines (line-no) (temp-num + 1:1)
	      when 'm'
	        move temp-num to location-column
	        move location-decoder to month-loc
	      when 'y'
	        move temp-num to location-column
	        move location-decoder to year-loc
	      when 'c'
	        move temp-num to location-column
	        move location-decoder to century-loc
	      when 'd'
	        move temp-num to location-column
	        move location-decoder to day-of-month-loc
	      when 'D'
	        move temp-num to location-column
	        move location-decoder to full-date-loc
	      when 'H'
	        move temp-num to location-column
	        move location-decoder to hour-loc
	      when 'M'
	        move temp-num to location-column
	        move location-decoder to minute-loc
	      when 'S'
	        move temp-num to location-column
	        move location-decoder to second-loc
	      when 'T'
	        move temp-num to location-column
	        move location-decoder to full-time-loc
	      when 'a'
	        move temp-num to location-column
	        move location-decoder to abbrev-weekday-loc
	      when 'h'
	        move temp-num to location-column
	        move location-decoder to abbrev-month-loc
	      when 'r'
	        move temp-num to location-column
	        move location-decoder to full-ampm-time-loc
	      when 'p'
	        move temp-num to location-column
	        move location-decoder to page-number-loc
	      when 'f'
	        move temp-num to location-column
	        move location-decoder to filename-loc
	    end-evaluate
	end-perform
    end-perform.
    perform varying number-of-header-lines from 9 by -1 until
		number-of-header-lines = 0 or
		alfred-header-lines (number-of-header-lines) not = spaces
    	continue
    end-perform.
    accept alfred-date from century-date.
    move alfred-date (1:2) to alfred-century.
    move alfred-date (3:2) to alfred-year.
    move alfred-date (5:2) to alfred-month.
    move alfred-date (7:2) to alfred-day-of-month.
    accept alfred-time from time.
    move alfred-time (1:2) to alfred-hour.
    move alfred-time (3:2) to alfred-minute.
    move alfred-time (5:2) to alfred-second.
    move alfred-full-time to alfred-full-ampm-time.
    if alfred-hour < 12
	move "AM" to alfred-ampm
    else
	move "PM" to alfred-ampm
	if alfred-hour > 13
	    subtract 12 from alfred-hour giving alfred-ampm-hour
	end-if
    end-if.

display-header-screen.
    if window-line-no not = 1
	display window line 1
    end-if.
    display header-screen.
    if window-line-no not = 1
	display window line window-line-no
    end-if.

set-access-key-menu.
    if key-num >= 0
	move key-num to disp-key-num
	call "W$MENU" using wmenu-enable, alfred-main-menu, menu-open-input
	call "W$MENU" using wmenu-enable, alfred-main-menu, menu-open-io
	call "W$MENU" using wmenu-enable, alfred-main-menu, start-submenu
	call "W$MENU" using wmenu-enable, alfred-main-menu, record-submenu
    else
	call "W$MENU" using wmenu-disable, alfred-main-menu, menu-open-input
	call "W$MENU" using wmenu-disable, alfred-main-menu, menu-open-io
	call "W$MENU" using wmenu-disable, alfred-main-menu, start-submenu
	call "W$MENU" using wmenu-disable, alfred-main-menu, record-submenu
    end-if.
    call "W$MENU" using wmenu-disable, alfred-main-menu, options-submenu.
    call "W$MENU" using wmenu-disable, alfred-main-menu, menu-print.
    call "W$MENU" using wmenu-disable, alfred-main-menu, menu-delete-record.
    call "W$MENU" using wmenu-disable, alfred-main-menu, menu-save-record.
    call "W$MENU" using wmenu-disable, alfred-main-menu, menu-eval-conditions.
    call "W$MENU" using wmenu-disable, alfred-main-menu, menu-next-record.
    call "W$MENU" using wmenu-disable, alfred-main-menu, menu-previous-record.
    perform show-main-menu.
    perform display-header-screen.

get-file-name.
    if file-open-input or file-open-io
	perform close-file
	perform deallocate-file
    end-if.
    display floating window line 5 col 2 size 70 lines 8 color label-color
		title is new-file-title boxed handle new-file-area.
    set have-filename to false.
    perform with test after until
		have-filename or
		exc-key = menu-exit
	display filename-screen
	accept filename-screen
	  exception
	    accept exc-key from escape
	    evaluate exc-key
	      when menu-help
		perform show-enter-file-help
	      when key-browse-selected
		move 1 to opnsav-default-filter
		move file-selector-title to opnsav-title
		move spaces to opnsav-default-dir
		call "C$OPENSAVEBOX" using opensave-open-box, opensave-data
		if return-code not = opnsaverr-cancelled
		    if browse-datafile
			move opnsav-filename to filename
		    else
			move opnsav-filename to xfdfile
		    end-if
		end-if
	    end-evaluate
	  not exception
	    if filename not = spaces
		perform get-file-info
	    end-if
	end-accept
    end-perform.
    move 1 to top-byte.
    close window new-file-area.

before-filename-proc.
    set browse-datafile to true.
    accept browse-suffix from environment "FILE_SUFFIX".
    move spaces to opnsav-filters.
    if browse-suffix = spaces
	move all-files-filter to opnsav-filters
    else
	if browse-suffix(1:1) = "."
	    move browse-suffix(2:) to user-message
	    move user-message to browse-suffix
	end-if
	string data-files-filter delimited by size
		" (*." delimited by size
		browse-suffix delimited by spaces
		")|*." delimited by size
		browse-suffix delimited by spaces
		"|" delimited by size
		all-files-filter delimited by size
	    into opnsav-filters
    end-if.

before-xfdfile-proc.
    set browse-datafile to false.
    move xfd-files-filter to opnsav-filters.
    perform check-for-xfd.

***  Check for an XFD file in the obvious places.  (Same directory as file,
***  current directory, XFD_DIRECTORY, in that order).
check-for-xfd.
    if filename = spaces
	exit paragraph
    end-if.
    set temp-idx to size of filename.
    subtract 1 from temp-idx.
    perform until temp-idx = 0 or filename (temp-idx:1) = '/' or '\' or ':'
	subtract 1 from temp-idx
    end-perform.
***  This is the directory of the file
    if temp-idx > 0
	move filename (1:temp-idx) to directory-name
    else
	move spaces to directory-name
    end-if.
***  This is the base name (with any extension - we remove that next)
    add 1 to temp-idx.
    move filename (temp-idx:) to base-filename.
    set temp-idx to size of base-filename.
    subtract 1 from temp-idx.
    perform until temp-idx = 0 or base-filename (temp-idx:1) = '.'
	subtract 1 from temp-idx
    end-perform.
    if temp-idx > 0
	move base-filename (temp-idx + 1:) to file-extension
	move spaces to base-filename (temp-idx:)
    else
	move spaces to file-extension
    end-if.
***  We are searching for the XFD file.  Normally these are created by
***  the compiler in lower-case.  But some situations are special, such
***  as when looking for files with names that use double-byte characters
***  in which case we don't necessarily want to lower-case the name.  So
***  what we'll do is first look for the file by just replacing any
***  extension with ".xfd", and if that fails then we will try lower-casing
***  the name.
    perform find-xfd-file.
    if xfdfile not = spaces
	display myxfdname of filename-screen
	exit paragraph
    end-if.

***  Now let's try a lower-case name.
    inspect base-filename converting "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
				  to "abcdefghijklmnopqrstuvwxyz".
    perform find-xfd-file.
    if xfdfile not = spaces
	display myxfdname of filename-screen
	exit paragraph
    end-if.

find-xfd-file.
***  Ok, we have the directory, the basename (no extension), and the extension.
***  Let's build some xfd file names.  First, the same directory as the file.
    move spaces to xfdfile.
    string directory-name delimited by spaces,
	   base-filename delimited by spaces,
	   ".xfd" delimited by size
	into xfdfile.
    call "C$FILEINFO" using xfdfile, file-info giving temp-idx.
    if temp-idx = 0
	exit paragraph
    end-if.
***  How about the current directory?
    move spaces to xfdfile.
    string base-filename delimited by spaces,
	   ".xfd" delimited by size
	into xfdfile
    call "C$FILEINFO" using xfdfile, file-info giving temp-idx
    if temp-idx = 0
	exit paragraph
    end-if.
***  Next, get the XFD-DIRECTORY variable, and try that directory.
    accept user-message from environment "XFD-DIRECTORY".
    if user-message not = spaces
	move spaces to xfdfile
	string user-message delimited by spaces,
	       base-filename delimited by spaces,
	       ".xfd" delimited by size
	    into xfdfile
	call "C$FILEINFO" using xfdfile, file-info giving temp-idx
	if temp-idx = 0
	    exit paragraph
	end-if
***  Maybe there is no '/' at the end of xfd-directory...
	move spaces to xfdfile
	string user-message delimited by spaces,
	       "/" delimited by size
	       base-filename delimited by spaces,
	       ".xfd" delimited by size
	    into xfdfile
	call "C$FILEINFO" using xfdfile, file-info giving temp-idx
	if temp-idx = 0
	    exit paragraph
	end-if
    end-if.
    move spaces to xfdfile.
***  That's all I know to try.

report-parse-error.
    display message box parse-error-message, NEWLINE,
	parsexfd-text-error-message(parse-flag),
	title is error-title, type is MB-OK, icon is MB-ERROR-ICON.

process-filename.
    initialize key-map.
    if have-filename
	move -1 to key-num
	set xfd-available to false
	move 0 to offset-visible
	move 3 to header-frame-lines
	if xfdfile not = spaces
	    call "ParseXFD" using parse-xfd-op
	    if parse-error
		perform report-parse-error
	    else
		set xfd-available to true
		perform calculate-max-field-name-len
		move 1 to offset-visible
		move 4 to header-frame-lines
		add 3 to xfd-max-field-name-len giving disp-col1
	    end-if
	end-if
	perform get-access-key
	call "W$MENU" using wmenu-enable, alfred-main-menu, menu-reference-key
    else
	call "W$MENU" using wmenu-disable, alfred-main-menu, menu-reference-key
	call "W$MENU" using wmenu-disable, alfred-main-menu, menu-open-input
	call "W$MENU" using wmenu-disable, alfred-main-menu, menu-open-io
	call "W$MENU" using wmenu-disable, alfred-main-menu, edit-submenu
	call "W$MENU" using wmenu-disable, alfred-main-menu, start-submenu
	call "W$MENU" using wmenu-disable, alfred-main-menu, record-submenu
	call "W$MENU" using wmenu-disable, alfred-main-menu, options-submenu
    end-if.
    perform show-main-menu.

calculate-max-field-name-len.
    move 0 to xfd-max-field-name-len.
    perform varying xfd-field-index from 1 by 1
			until xfd-field-index > xfd-total-number-fields
	call "ParseXFD" using get-field-info-op
	call "W$TEXTSIZE" using xfd-field-name textsize-data
	add .99 to textsize-size-x
	if textsize-size-x > xfd-max-field-name-len
	    move textsize-size-x to xfd-max-field-name-len
	end-if
    end-perform.

create-file-from-xfd-info.
    call "ParseXFD" using parse-xfd-op.
    if parse-error
	exit paragraph
    end-if.
***  We have an XFD file, and seem to have parsed it correctly.
***  Let's ask the user if he wants to create an indexed file
***  based on the information in the XFD file....
    display message box create-new-file-message,
	type is MB-YES-NO, giving response.
    if respond-no
	call "ParseXFD" using free-memory-op
	exit paragraph
    end-if.
***  function.
    set make-function to true.
***  Set up the filename.
    move filename to msg-text.
    inspect msg-text replacing trailing spaces by low-values.
***  Set up the comment.
    move created-by-alfred to value-x80.
    accept alfred-date from century-date.
    move alfred-date to value-x80 (22:).
    inspect value-x80 replacing trailing spaces by low-values.
***  Set up the physical parameters.
    move 0 to block-multiple.
    move 0 to pre-allocation-amount.
    move 0 to extension-amount.
    move 0 to compression-factor.
    move 0 to encrypted-flag.
***  Set up the logical parameters.
    move xfd-max-record-size to max-rec-size.
    move xfd-min-record-size to min-rec-size.
    move xfd-number-of-keys  to num-keys.
***  The hardest part.  Set up the keys information.
***  Use "large-field" for the information, and die a horrible death
***  if this is not big enough.
    move 1 to temp-num.
    move low-values to large-field.
    perform varying temp-idx from 1 by 1 until temp-idx > num-keys
	subtract 1 from temp-idx giving key-num
	perform get-one-key-info of with-xfd
	move xfd-number-of-segments to large-field (temp-num:lo-pri-num-segs)
	move ',' to large-field (temp-num + lo-pri-num-segs:1)
	move xfd-allow-dup-flag to large-field (temp-num + lo-pri-num-segs + 1:lo-pri-dups)
	compute temp-num = temp-num + lo-pri-num-segs + lo-pri-dups + 1
	perform varying temp-idx2 from 1 by 1 until temp-idx2 > xfd-number-of-segments
	    move "," to large-field (temp-num:1)
	    move xfd-segment-length (temp-idx2) to
				large-field (temp-num + 1:lo-pri-key-size)
	    move "," to large-field (temp-num + lo-pri-key-size + 1:1)
	    move xfd-segment-offset (temp-idx2) to
				large-field (temp-num + lo-pri-key-size + 2:lo-pri-key-offset)
	    compute temp-num = temp-num +
			       lo-pri-key-size +
			       lo-pri-key-offset + 
			       2
	end-perform
	move ',' to large-field (temp-num:1)
	add 1 to temp-num
    end-perform.
    subtract 1 from temp-num.
    move low-values to large-field (temp-num:1).
***  Finally, call I$IO, omitting the translation table.
    call "I$IO" using io-function, msg-text, value-x80, physical-info,
		logical-info, large-field.
    if return-code = 1
	perform open-file-input
    end-if.
    call "ParseXFD" using free-memory-op.

get-file-info.
***  keynum = -1 causes open-file-input to not find the first record
    move -1 to key-num.
    perform open-file-input.
    if file-pointer = null
	set have-filename to false
	if e-missing-file and xfdfile not = spaces
	    perform create-file-from-xfd-info
	end-if
	if file-pointer = null
	    exit paragraph
	end-if
    end-if.
    set info-function to true.
    set get-logical-params to true.
    call "I$IO" using io-function file-pointer info-mode logical-info.
    if return-code = 0
	    perform report-error
    end-if.
    if max-rec-size = 0
	    perform get-logical-info
    end-if.
***  Get the collating sequence for the file.  Save the results in the
***  translation-table data item.
    set info-function to true
    set get-collating-sequence to true
    call "I$IO" using io-function, file-pointer, info-mode, translation-table
    move return-code to have-translation-table
***  Get the number of segments for each key.  Save the primary key info,
***  by going backwards through the keys.
    set info-function to true.
    perform varying temp-num from num-keys by -1 until temp-num = 0
	subtract 1 from temp-num giving info-mode
	call "I$IO" using io-function file-pointer info-mode pri-key-info
	move pri-num-segs to num-key-segs( info-mode + 1 )
    end-perform.
    perform close-file.
    if max-rec-size > 0
	move max-rec-size to malloc-size
	call "M$ALLOC" using malloc-size record-area-ptr
	if record-area-ptr = NULL
	    set e-no-memory to true
	    perform report-error
	else
	    set have-filename to true
	end-if
    end-if.

***  The file system can't determine logical information, so we need to get
***  it from the user (max-rec-size, min-rec-size, num-keys)
get-logical-info.
    display floating window line 5 col 2 size 40 lines 7
		boxed color label-color
		title is logical-title handle logical-info-area.
    perform with test after until max-rec-size > 0 or exc-key = menu-exit
	display logical-info-screen
	accept logical-info-screen
	  exception
	    accept exc-key from escape
	    evaluate exc-key
	      when menu-help
		perform show-logical-info-help
	      when other
	    end-evaluate
	  not exception
	    if max-rec-size > max-record-size or
	       min-rec-size > max-rec-size or
	       max-rec-size = 0 or min-rec-size = 0 or
	       num-keys > 120 or num-keys = 0
		move 0 to max-rec-size
		perform beep-user
	    end-if
	end-accept
    end-perform.
    close window logical-info-area.

***  Deallocate all the file memory we allocated.
deallocate-file.
    if xfd-available
	call "ParseXFD" using free-memory-op
	set xfd-available to false
	move 0 to offset-visible
	move 3 to header-frame-lines
    end-if.
    if record-area-ptr not = NULL
	call "M$FREE" using record-area-ptr
	set record-area-ptr to NULL
    end-if.

***  Shut down everything.
shutdown.
    perform close-file.
    perform deallocate-file.
    if keymap-success not = 0
	call "C$KEYMAP" using restore-keymap
    end-if.
    destroy all controls.
    if tools-bitmap > 0
	call "W$BITMAP" using wbitmap-destroy tools-bitmap
    end-if.
    if pic-handle > 0
	call "W$BITMAP" using wbitmap-destroy pic-handle
    end-if.
    display " ".
    close window main-window-handle.
    exit program return-code.
    stop run return-code.

get-mem-undo-info.
    compute undo-offset = undo-data-size * (undo-current-byte - 1) + 1.
    call "M$GET" using undo-ptr, undo-data, undo-data-size, undo-offset.

put-mem-undo-info.
    compute undo-offset = undo-data-size * (undo-last-byte - 1) + 1.
    call "M$PUT" using undo-ptr, undo-data, undo-data-size, undo-offset.

***  Initialize the memory record area to init-value.
initialize-record.
    call "M$FILL" using record-area-ptr, init-value, max-rec-size.

***  Get the access key.  I think this can be mostly xfd-independent now....
get-access-key.
    perform open-file-input.
    if file-pointer = null
	perform shutdown
    end-if.
    if num-keys = 1
	move 0 to key-num
	if xfd-available
	    perform get-one-key-info of with-xfd
	    perform setup-xfd-key-screen
	else
	    perform get-one-key-info of no-xfd
	    perform get-key-map
	end-if
	perform set-access-key-menu
	exit paragraph
    end-if.
    move xfd-field-index to save-xfd-field-index.
    move num-keys to access-key-num-keys.
    if xfd-available
	move key-num-msg to key-num-text-msg
    else
	move key-num-xfd-msg to key-num-text-msg
    end-if.
    move 20 to window-lines.
    if xfd-available
	move 60 to col-no
    else
	move 80 to col-no
    end-if.
    display floating window line 1 col 8 size col-no lines window-lines + 3
		color label-color
		title is access-key-title
		boxed handle save-area1.
    move 0 to top-byte key-num.
    move spaces to key-choices.
    perform draw-keys-screen.
    set done to false.
    move 1 to line-no.
    set environment "cursor-mode" to 2.
    perform until done
	display omitted color highlight-color line line-no col 1 size col-no
	accept omitted line line-no col 1
	  exception exc-key
	    display omitted color label-color line line-no col 1 size col-no
	    evaluate true
	      when up-arrow
		subtract 1 from key-num
	      when down-arrow
		add 1 to key-num
	      when home-key
		move 0 to key-num
	      when end-key
		move num-keys to key-num
	      when page-up
	      when right-arrow
		perform keys-page-up
	      when page-down
	      when left-arrow
		perform keys-page-down
	      when escape-key
		set done to true
		move -1 to key-num
		exit perform
	      when button-pressed
	      when button-double-clicked
		call "W$MOUSE" using get-mouse-status mouse-info
		evaluate true
		  when mouse-row = 0
		    perform keys-page-up
		  when mouse-row > window-lines
		    perform keys-page-down
		  when other
		    if mouse-row > line-no
			perform until mouse-row <= line-no or
				      key-num = num-keys - 1
			    add 1 to key-num
			    perform adjust-screen-position
			end-perform
			if mouse-row < line-no
			    add 1 to key-num
			end-if
		    else
			perform until mouse-row >= line-no
			    subtract 1 from key-num
			    perform adjust-screen-position
			end-perform
		    end-if
		end-evaluate
		if button-double-clicked
		    set done to true
		end-if
	      when help-key
		perform show-sort-key-help
	      when other
		perform beep-user
	    end-evaluate
	    perform adjust-screen-position
	    if redraw-screen
		perform draw-keys-screen
	    end-if
	end-accept
	if return-key
	    set done to true
	end-if
    end-perform.
    set environment "cursor-mode" to 3.
    close window save-area1.
    move save-xfd-field-index to xfd-field-index.
    if key-num not = -1
	if xfd-available
	    perform get-one-key-info of with-xfd
	    perform setup-xfd-key-screen
	else
	    perform get-one-key-info of no-xfd
	    perform get-key-map
	end-if
    end-if.
    perform set-access-key-menu.
    move 1 to top-byte.

keys-page-up.
    if top-byte = 0
	exit paragraph
    end-if.
    if not xfd-available
	subtract window-lines from key-num
	exit paragraph
    end-if.
    move 0 to temp-idx.
    perform until temp-idx > window-lines
	subtract 1 from key-num
	add xfd-num-key-flds (key-num + 1) to temp-idx
	if key-num = 0
	    exit perform
	end-if
    end-perform.
    if temp-idx > window-lines
	add 1 to key-num
    end-if.

keys-page-down.
    add number-of-keys-on-scrn to key-num.

adjust-screen-position.
    set redraw-screen to false.
    if key-num >= num-keys
	subtract 1 from num-keys giving key-num
    end-if.
    if key-num < 0
	move 0 to key-num
    end-if.
    perform until key-num >= top-byte
	set redraw-screen to true
	move 0 to temp-idx number-of-keys-on-scrn
	perform until temp-idx > window-lines
	    subtract 1 from top-byte
	    add 1 to number-of-keys-on-scrn
	    if xfd-available
		add xfd-num-key-flds (top-byte + 1) to temp-idx
	    else
		add 1 to temp-idx
		if num-key-segs( top-byte + 1 ) > 6
		    add 1 to temp-idx
		end-if
		if num-key-segs( top-byte + 1 ) > 13
		    add 1 to temp-idx
		end-if
	    end-if
	    if top-byte = 0
		exit perform
	    end-if
	end-perform
	if temp-idx > window-lines
	    add 1 to top-byte
	    subtract 1 from number-of-keys-on-scrn
	end-if
    end-perform.
    perform until key-num < top-byte + number-of-keys-on-scrn
	set redraw-screen to true
	add number-of-keys-on-scrn to top-byte
    end-perform.
    move 1 to line-no.
    perform varying temp-idx from top-byte by 1 until temp-idx = key-num
	if xfd-available
	    add xfd-num-key-flds (temp-idx + 1) to line-no
	else
	    add 1 to line-no
	    if num-key-segs( temp-idx + 1 ) > 6
		add 1 to line-no
	    end-if
	    if num-key-segs( temp-idx + 1 ) > 13
		add 1 to line-no
	    end-if
	end-if
    end-perform.

draw-keys-screen.
    move line-no to save-line-no.
    move key-num to save-key-num.
    display window erase.
    display key-num-text-msg line 1 col 1.
    display window line 2.
    move 1 to line-no.
    move 0 to number-of-keys-on-scrn.
    set done to false.
    perform varying key-num from top-byte by 1 until done
	move key-num to disp-seg-len
	if xfd-available
	    perform get-one-key-info of with-xfd
	    if line-no + xfd-num-key-flds (key-num + 1) > window-lines
	        set done to true
		exit perform cycle
	    end-if
	    add 1 to number-of-keys-on-scrn
	    display disp-seg-len color label-color line line-no col 3 erase line
	    display yn-flag (xfd-allow-dup-flag + 1:1) color label-color
			line line-no col 8
	    perform varying xfd-key-field-idx from 1 by 1 until
				xfd-key-field-idx > xfd-num-of-key-fields
		move xfd-key-field-num (xfd-key-field-idx) to xfd-field-index
		call "ParseXFD" using get-field-info-op
		move xfd-field-offset to disp-seg-offset
		move xfd-field-length to disp-seg-len
		display disp-seg-offset color label-color line line-no col 12
			disp-seg-len    color label-color line line-no col 19
			xfd-field-name  color label-color line line-no col 23
		add 1 to line-no
	    end-perform
	else	| No XFD available
	    add 1 to number-of-keys-on-scrn
	    display disp-seg-len color label-color line line-no col 3 erase line
	    perform get-one-key-info of no-xfd
	    display yn-flag (dups-allowed + 1:1) color label-color
			line line-no col 8
	    move 13 to col-no
	    perform varying seg-num from 1 by 1 until
			seg-num > num-segs
		if seg-num = 7 or 13
		    add 1 to line-no
		    move 13 to col-no
		end-if
		move key-offset (seg-num) to disp-seg-offset
		move key-size (seg-num) to disp-seg-len
		display disp-seg-offset color label-color
				line line-no col col-no
		add 6 to col-no
		display disp-seg-len    color label-color
				line line-no col col-no
		add 5 to col-no
	    end-perform
	    add 1 to line-no
	    if ((num-key-segs( key-num + 1 ) <  7 and line-no >= window-lines) or
		(num-key-segs( key-num + 1 ) < 13 and line-no >= window-lines - 1) or
		(num-key-segs( key-num + 1 ) > 12 and line-no >= window-lines - 2))
		set done to true
	    end-if
	end-if
***   key-num is 0-based, num-keys is 1-based.
	if key-num + 1 >= num-keys
	    set done to true
	end-if
    end-perform.
    display push-button
	    ok-button
	    line window-lines
	    col 10
	    self-act.
    display push-button
	    cancel-button
	    line window-lines
	    col 25
	    self-act.
    display push-button
	    title help-title
	    line window-lines
	    col 40
	    size 6
	    self-act
	    exception-value is menu-help.
    move save-line-no to line-no.
    move save-key-num to key-num.
    set done to false.

disable-page-up.
    move 0 to toolbar-page-up-enabled.
    perform show-toolbar.
    set environment "keystroke" to "invalid=Yes		kP".
    call "W$MENU" using wmenu-disable, alfred-main-menu, menu-previous-page.
    perform show-main-menu.

enable-page-up.
    move 1 to toolbar-page-up-enabled.
    perform show-toolbar.
    set environment "keystroke" to "exception=67	kP".
    call "W$MENU" using wmenu-enable, alfred-main-menu, menu-previous-page.
    perform show-main-menu.

disable-page-down.
    move 0 to toolbar-page-dn-enabled.
    perform show-toolbar.
    set environment "keystroke" to "invalid=Yes		kN".
    call "W$MENU" using wmenu-disable, alfred-main-menu, menu-next-page.
    perform show-main-menu.

enable-page-down.
    move 1 to toolbar-page-dn-enabled.
    perform show-toolbar.
    set environment "keystroke" to "exception=68	kN".
    call "W$MENU" using wmenu-enable, alfred-main-menu, menu-next-page.
    perform show-main-menu.

***  A file error was returned.  Explain to the user what happened.
report-error.
    set need-ext-errno to false.
    move f-int-errno to f-int-errno-disp.
    move f-errno to f-errno-disp.
    move MB-ERROR-ICON to icon-type.
    if f-in-error
	move file-error-array(f-errno) to msg-text
    else
	move MB-WARNING-ICON to icon-type
	move file-warning-array(f-errno - 100) to msg-text
    end-if.

    if f-int-errno-disp not = 0
	set msg-size to size of msg-text
	perform until msg-text (msg-size:) not = spaces or msg-size = 1
	    subtract 1 from msg-size
	end-perform
	add 2 to msg-size
	move f-int-errno-disp to msg-text (msg-size:)
    end-if.
    if e-mismatch
	display message box filename, NEWLINE, msg-text,
		type is MB-OK, icon is icon-type
    else
	display message box msg-text,
		type is MB-OK, icon is icon-type
    end-if.

open-file-io.
    move Fio to open-mode.
    perform open-file.
    if file-pointer not = NULL
	set file-open-io to true
	set radio-file-open-io to true
	perform show-toolbar
    end-if.
    compute entry-style = base-style + efs-notify-change.

open-file-input.
    move Finput to open-mode.
    perform open-file.
    if file-pointer not = NULL
	set file-open-input to true
	set radio-file-open-input to true
	perform show-toolbar
    end-if.
    compute entry-style = base-style + efs-read-only.

open-file.
    perform close-file.
    if file-closed
	set open-function to true
	perform with test after until
		not e-param-err or exc-key = menu-exit
	    call "I$IO" using io-function, filename, open-mode, logical-info
	    move return-unsigned to file-pointer
	    if e-param-err
		perform get-logical-info
	    end-if
	end-perform
	if file-pointer = null
	    perform report-error
	else
	    if open-mode = Fio
		move io-string to access-mode
	    else
		move input-string to access-mode
	    end-if
	    if open-mode = Fio
		call "W$MENU" using wmenu-uncheck, alfred-main-menu,
			menu-open-input
		call "W$MENU" using wmenu-check, alfred-main-menu,
			menu-open-io
	    else
		call "W$MENU" using wmenu-check, alfred-main-menu,
			menu-open-input
		call "W$MENU" using wmenu-uncheck, alfred-main-menu,
			menu-open-io
	    end-if
	    perform find-this-record
	end-if
    end-if.
    if key-num >= 0
	perform display-header-screen
    end-if.

start-file-nlt-or-ngt.
    move exc-key to save-exc-key.
    set have-a-record to false.
    perform until have-a-record or exc-key = menu-exit
	if xfd-available
	    perform get-one-key of with-xfd
	else
	    perform get-one-key of no-xfd
	end-if
	if escape-key
	    exit paragraph
	end-if
	move save-exc-key to exc-key
	if exc-key = menu-start-nlt
	    perform start-file-not-less
	    if not file-error
		perform read-next-record
	    end-if
	else
	    perform start-file-not-greater
	    if not file-error
		perform read-previous-record
	    end-if
	end-if
	if not file-error
	    set have-a-record to true
	end-if
    end-perform.

***  This paragraph restores the file position to the save-primary-key record,
***  regardless of which key is being used to read.
restore-position.
    perform restore-primary-key.
    move 0 to key-num.
    set read-function to true.
    call "I$IO" using io-function file-pointer record-area-ptr key-num.
    if return-code = 0
	perform start-first-record
    else
	perform start-file-not-less
	perform read-next-record
    end-if.

find-this-record.
    if save-primary-key not = spaces and key-num >= 0
	perform start-file-not-less
	perform read-next-record
	set redraw-screen to false
    end-if.

close-file.
    if not file-closed
	set close-function to true
	call "I$IO" using io-function file-pointer
	set file-closed to true
    end-if.

get-record-size.
    if max-rec-size = min-rec-size
	move max-rec-size to record-size
    else
	display floating window line 10 col 10 lines 5 size 60
		color label-color boxed handle save-area2
		title is new-record-size-title
	move new-record-size-message to rec-size-prompt
	move 0 to record-size rec-size
	perform until record-size >= min-rec-size and
		      record-size <= max-rec-size
	    display rec-size-screen
	    accept rec-size-screen
	      exception
		accept exc-key from escape
		evaluate exc-key
		  when menu-exit
		  when key-escape-key
		    move 0 to record-size
		    exit perform
		  when menu-help
		    perform show-enter-recordsize-help
		  when other
		    perform beep-user
		end-evaluate
	    end-accept
	    move rec-size to record-size
	end-perform
	close window save-area2
    end-if.

start-first-record.
    if have-translation-table = 0 then
	move low-values to init-value
    else
	move translation-table(1:1) to init-value
    end-if
    perform initialize-record.
    perform start-file-not-less.
    if not file-error
	perform read-next-record
    end-if.

start-last-record.
    if have-translation-table = 0 then
	move high-values to init-value
    else
	move translation-table(256:1) to init-value
    end-if
    perform initialize-record.
    perform start-file-not-greater.
    if not file-error
	perform read-previous-record
    end-if.

start-file-not-less.
    set f-not-less to true.
    perform start-file.

start-file-not-greater.
    set f-not-greater to true.
    perform start-file.

start-file.
    set start-function to true.
    move 0 to start-key-size.
    call "I$IO" using io-function, file-pointer, record-area-ptr, key-num,
			start-key-size, start-mode.
    if f-errno not = 0
	perform report-error
	set file-error to true
    else
	set file-error to false
    end-if.

read-next-record.
    set next-function to true.
    perform read-record-sequential.

read-previous-record.
    set previous-function to true.
    perform read-record-sequential.

read-record-sequential.
    call "I$IO" using io-function file-pointer record-area-ptr.
    if return-code = 0
	perform report-error
	set file-error to true
	set done to true
    else
	set file-error to false
	set record-modified to false
	set redraw-screen to true
	move return-code to record-size
	move 0 to undo-first-byte undo-current-byte undo-last-byte
	set undo-wrap to false
	perform save-the-primary-key
	call "W$MENU" using wmenu-enable, alfred-main-menu, menu-delete-record
	call "W$MENU" using wmenu-enable, alfred-main-menu, menu-print
	perform show-main-menu
	set change-mode to true
    end-if.

process-record.
    call "W$MENU" using wmenu-enable, alfred-main-menu, menu-next-record.
    call "W$MENU" using wmenu-enable, alfred-main-menu, menu-previous-record.
    call "W$MENU" using wmenu-enable, alfred-main-menu, options-submenu.
    if xfd-available
	call "W$MENU" using wmenu-disable, alfred-main-menu, menu-hex
	call "W$MENU" using wmenu-disable, alfred-main-menu, menu-octal
	call "W$MENU" using wmenu-disable, alfred-main-menu, menu-ascii-area
	call "W$MENU" using wmenu-disable, alfred-main-menu, menu-raw-area
	call "W$MENU" using wmenu-enable, alfred-main-menu, menu-eval-conditions
    else
	call "W$MENU" using wmenu-enable, alfred-main-menu, menu-hex
	call "W$MENU" using wmenu-enable, alfred-main-menu, menu-octal
	call "W$MENU" using wmenu-enable, alfred-main-menu, menu-ascii-area
	call "W$MENU" using wmenu-enable, alfred-main-menu, menu-raw-area
	call "W$MENU" using wmenu-disable, alfred-main-menu, menu-eval-conditions
    end-if.
    perform show-main-menu.
    if xfd-available
	if not add-mode
	    call "ParseXFD" using test-conditions-op
	end-if
	perform display-record of with-xfd
	if not field-on-page
	    move 1 to xfd-field-index
	    perform until field-on-page
		perform display-record of with-xfd
		if not field-on-page
		    perform goto-next-valid-page of with-xfd
		end-if
	    end-perform
	end-if
	perform modify-record of with-xfd
    else
	perform display-record of no-xfd
	perform modify-record of no-xfd
    end-if.

test-primary-key-change.
    move 1 to temp-num.
    move save-primary-key to test-primary-key.
    perform save-the-primary-key.
    if save-primary-key not = test-primary-key
	set primary-key-changed to true
    end-if.
    move test-primary-key to save-primary-key.

save-the-primary-key.
    move "M$GET" to get-put-fcn.
    perform save-restore-primary.

restore-primary-key.
    move "M$PUT" to get-put-fcn.
    perform save-restore-primary.

save-restore-primary.
    move 1 to temp-num.
    perform varying seg-num from 1 by 1 until seg-num > pri-num-segs
	add 1 to pri-key-offset (seg-num) giving record-byte-num
	call get-put-fcn using record-area-ptr,
		save-primary-key (temp-num:pri-key-size (seg-num))
		pri-key-size (seg-num), record-byte-num
	add pri-key-size (seg-num) to temp-num
    end-perform.

open-mode-error.
    display message box file-open-mode-message,
	type is MB-OK, icon is MB-ERROR-ICON.

test-record-modified.
    if record-modified
	perform write-record
    end-if.

***   Confirm the write/rewrite or delete?
confirm-write-or-delete.
    display message box msg-text,
	type is MB-YES-NO-CANCEL, default is MB-NO, giving response.

***  Ask first.
write-record.
    set primary-key-changed to false.
    set respond-no to true.
    if confirm-on-write
	move write-record-prompt to msg-text
	perform confirm-write-or-delete
    else
	set respond-yes to true
    end-if.
    if respond-yes
	if add-mode
	    set write-function to true
	else
	    perform test-primary-key-change
	    if primary-key-changed
		set write-function to true
	    else
		set rewrite-function to true
	    end-if
	end-if
	call "I$IO" using io-function file-pointer record-area-ptr record-size
	if return-code = 0
	    set file-error to true
	    perform report-error
	else
	    set file-error to false
	    set record-modified to false
	    move 0 to undo-first-byte undo-current-byte undo-last-byte
	    set undo-wrap to false
	    if primary-key-changed
		set delete-function to true
		perform restore-primary-key
		call "I$IO" using io-function file-pointer record-area-ptr
		if return-code = 0
		    set file-error to true
		    perform report-error
		else
		    set file-error to false
		end-if
	    end-if
	end-if
    end-if.

***  Ask first.
delete-record.
    set respond-no to true.
    if confirm-on-delete
	move delete-record-prompt to msg-text
	perform confirm-write-or-delete
    else
	set respond-yes to true
    end-if.
    if respond-yes
	set delete-function to true
	call "I$IO" using io-function file-pointer record-area-ptr
	if return-code = 0
	    set file-error to true
	    perform report-error
	else
	    set file-error to false
	    perform read-next-record
	    set redraw-screen to true
	end-if
	if file-error
	    perform no-current-record
	end-if
    end-if.
    close window save-area2.
    perform show-main-menu.

***  No current record.  Blank the screen.  (We probably still have position.)
no-current-record.
    if xfd-available
	perform destroy-all-controls
    else
	display window line window-line-no erase
    end-if.

***  Convert the binary value in temp-3-asc-val to ascii hex in temp-area (1:4)
convert-bin-to-hex.
    call "ascii2hex" using temp-3-asc-val (2:) temp-area (1:4).

***  Convert the binary value in temp-3-asc-val to ascii octal in temp-area (1:8)
convert-bin-to-octal.
    call "ascii2octal" using temp-3-asc-val temp-area (1:8).

***  Convert the hex value in temp-area (1:2) to binary in temp-3-asc-val
convert-hex-to-bin.
    call "hex2ascii" using temp-3-asc-val (2:) temp-area (1:4).

***  Convert the octal value in temp-area (1:8) to binary in temp-3-asc-val
convert-octal-to-bin.
    call "octal2ascii" using temp-3-asc-val temp-area (1:8).

***  Here is everything we only need to do once.
startup-section section 50.
***  Get everything ready for the program.
startup.
    set environment "SCREEN" to "WINDOW=999,999".
    move low-values to handles.
    set record-area-ptr to NULL.
    set xfd-available to false.
    move 0 to offset-visible.
    move 3 to header-frame-lines.
    move spaces to filename xfdfile.
    set file-closed to true.
    move 0 to max-rec-size min-rec-size num-keys.
    accept msg-text from environment "CODE_SYSTEM".
    if msg-text = "0" or spaces
	set test-printable-euro to true
    else
	set test-printable-ascii to true
    end-if.

***   Measure the screen.  We are also setting up the TEXTSIZE group
***   for other calls.
    accept terminal-abilities from terminal-info.
    accept system-information from system-info.
    accept std-font-handle from standard object "default-font".
    move std-font-handle to textsize-font.
    set textsize-strip-spaces to true.
    call "W$TEXTSIZE" using "TEST" textsize-data.
    accept line-no from environment "cell-separation".
    if line-no < 0 or > 6
	move 3 to line-no
    end-if.
    if not has-graphical-interface
	move 0 to line-no
    end-if.
    add line-no to textsize-base-y.
    compute temp-num = usable-screen-height / textsize-base-y - 5.
    accept msg-text from environment "ALFRED-ENTRY-FIELDS".
    inspect msg-text converting "abcdefghijklmnopqrstuvwxyz"
			     to "ABCDEFGHIJKLMNOPQRSTUVWXYZ".
    if msg-text = "BOXED"
	compute base-style = s-3d + efs-no-autosel
	if has-graphical-interface
	    compute temp-num = temp-num * 2 / 3
	end-if
	display standard window lines temp-num auto-resize
		cell height is entry-field font std-font-handle separate
		background-low handle main-window-handle
	if main-window-handle = NULL
	    display standard window lines temp-num auto-resize
		    cell height is entry-field font std-font-handle separate
		    title-bar system menu user-colors
		    background-low handle main-window-handle
	end-if
    else
	compute base-style = s-3d + efs-no-box + efs-no-autosel
	display standard window lines temp-num auto-resize
		cell height is label font std-font-handle separate
		background-low handle main-window-handle
	if main-window-handle = NULL
	    display floating window lines temp-num auto-resize
		    cell height is label font std-font-handle separate
		    title-bar system menu user-colors
		    background-low handle main-window-handle
	end-if
    end-if.
    move temp-num to number-of-screen-lines.
    move main-window-handle to textsize-window.

    perform build-menus.
    perform show-main-menu.

***   Get some terminal information, and set some colors
***   We need to accept terminal-abilities again so that the menu is taken
***   into account.
    call "C$OPENSAVEBOX" using opensave-supported.
    if return-code not = opnsaverr-unsupported
	move 1 to browse-visible
    end-if.

    perform parse-colors.

    if operating-system(1:4) = "Unix"
	perform check-allow
    end-if.

    perform build-toolbar.
    perform show-toolbar.

    call "W$TEXTSIZE" using key-prompt textsize-data.
    add .99 to textsize-size-x.
    move textsize-size-x to key-prompt-size.
    call "W$TEXTSIZE" using mode-prompt textsize-data.
    add .99 to textsize-size-x.
    if textsize-size-x > key-prompt-size
	move textsize-size-x to key-prompt-size
    end-if.
    call "W$TEXTSIZE" using io-string textsize-data.
    add .99 to textsize-size-x.
    if textsize-size-x > access-mode-size
	move textsize-size-x to access-mode-size
    end-if.
    call "W$TEXTSIZE" using input-string textsize-data.
    add .99 to textsize-size-x.
    if textsize-size-x > access-mode-size
	move textsize-size-x to access-mode-size
    end-if.
    call "W$TEXTSIZE" using byte-offset-msg textsize-data.
    add .99 to textsize-size-x.
    if textsize-size-x > key-prompt-size
	move textsize-size-x to key-prompt-size
    end-if.
    compute key-msg-col = key-prompt-col + key-prompt-size + 1.
    compute header-frame-size = key-prompt-size + access-mode-size + 10.

***   Measure these titles....
    call "W$TEXTSIZE" using filename-title textsize-data.
    add .99 to textsize-size-x.
    move textsize-size-x to filename-title-size.
    call "W$TEXTSIZE" using xfdname-title textsize-data.
    add .99 to textsize-size-x.
    if textsize-size-x > filename-title-size
	move textsize-size-x to filename-title-size
    end-if.
    add 4 to filename-title-size giving filename-entry-col.
    compute filename-entry-size = 60 - filename-entry-col.

    accept user-message from environment "ALFRED-CONFIRM-ON-DELETE".
    if user-message = "NO"
	set confirm-on-delete to false
    end-if.
    accept user-message from environment "ALFRED-CONFIRM-ON-WRITE".
    if user-message = "NO"
	set confirm-on-write to false
    end-if.

    set undo-data-size to size of undo-data.
    compute undo-offset = undo-data-size * number-of-undo-steps.
    call "M$ALLOC" using undo-offset, undo-ptr.
    if undo-ptr = NULL
	display message box undo-alloc-message,
	    title is error-title, type is MB-OK, icon is MB-ERROR-ICON
	perform shutdown
    end-if.
    call "C$KEYMAP" using save-keymap, keymap-success.
    if keymap-success = 0
	display message box keyboard-stack-full,
		title is warning-title, type is MB-OK
	perform shutdown
    end-if.

    set environment
	"keystroke" to "exception=1		^A"
	"keystroke" to "exception=5		^E"
	"keystroke" to "exception=8 edit=backspace ZB"
	"keystroke" to "exception=9 edit=next	^I"
	"keystroke" to "exception=11 edit=previous kB"
	"keystroke" to "exception=14		^N"
	"keystroke" to "exception=16		^P"
	"keystroke" to "exception=19		^T"
	"keystroke" to "exception=20		^X"
	"keystroke" to "edit=next terminate=13	^M"
	"keystroke" to "exception=27 edit=menu	^["
	"keystroke" to "exception=27		k1"
	"keystroke" to "exception=255		k0"
	"keystroke" to "exception=50 edit=left	kl"
	"keystroke" to "exception=51 edit=right	kr"
	"keystroke" to "exception=52 edit=up	ku"
	"keystroke" to "exception=53 edit=down	kd"
	"keystroke" to "exception=65		kh"
	"keystroke" to "exception=66		KE"
	"keystroke" to "exception=80		Ml"
	"keystroke" to "exception=80		Mm"
	"keystroke" to "exception=87		Mr"
	"keystroke" to "exception=81		M1"	| double clicks
	"keystroke" to "exception=81		M2"
	"keystroke" to "exception=81		M3"
	"screen" to "alpha-updates=unchanged, auto-prompt"
	"cursor-mode" to 3
	"mouse-flags" to 11.	| default action, left click and double-click.

***  Display our beautiful bitmap....
    accept bitmap-file-name from environment "ALFRED-BITMAP-FILE".
    if bitmap-file-name = spaces
	move "alfred.bmp" to bitmap-file-name
    end-if.
    call "W$BITMAP" using wbitmap-display bitmap-file-name 1 1 0
		giving pic-handle
    call "c$narg" using num-parameters.
    evaluate num-parameters
      when 0
	set have-filename to false
	set xfd-available to false
	move 0 to offset-visible
	move 3 to header-frame-lines
      when 1
	set have-filename to true
	move passed-filename to filename
	set xfd-available to false
	move 0 to offset-visible
	move 3 to header-frame-lines
      when 2
      when other
	set have-filename to true
	move passed-filename to filename
	set xfd-available to true
	move 1 to offset-visible
	move 4 to header-frame-lines
	move passed-xfdfile to xfdfile
    end-evaluate.

    if have-filename
	perform get-file-info
    else
	perform get-file-name
    end-if.
    if not have-filename
	perform shutdown
    end-if.
    move 1 to	byte-counter
		top-byte
		xfd-field-index
		line-no.

build-menus.
    perform build-alfred-main-menu.
    move menu-handle to alfred-main-menu.
 
copy "alfred.mnu".

build-toolbar.
    display tool-bar background-low handle toolbar-handle.
    accept bitmap-file-name from environment "ALFRED-TOOLS-FILE".
    if bitmap-file-name = spaces
	move "alftools.bmp" to bitmap-file-name
    end-if.
    call "W$BITMAP" using wbitmap-load bitmap-file-name
		giving tools-bitmap.
    if tools-bitmap > 0
	accept value-x80 from environment "ALFRED-INPUT-BITMAP"
	if value-x80 = spaces
	    move 1 to toolbar-input-sz
	else
	    move value-x80 to toolbar-input-sz convert
	end-if
	accept value-x80 from environment "ALFRED-IO-BITMAP"
	if value-x80 = spaces
	    move 2 to toolbar-io-sz
	else
	    move value-x80 to toolbar-io-sz convert
	end-if
	accept value-x80 from environment "ALFRED-PG-DN-BITMAP"
	if value-x80 = spaces
	    move 3 to toolbar-pg-up-sz
	else
	    move value-x80 to toolbar-pg-up-sz convert
	end-if
	accept value-x80 from environment "ALFRED-PG-UP-BITMAP"
	if value-x80 = spaces
	    move 4 to toolbar-pg-dn-sz
	else
	    move value-x80 to toolbar-pg-dn-sz convert
	end-if
	accept value-x80 from environment "ALFRED-PREV-REC-BITMAP"
	if value-x80 = spaces
	    move 5 to toolbar-prev-rec-sz
	else
	    move value-x80 to toolbar-prev-rec-sz convert
	end-if
	accept value-x80 from environment "ALFRED-NEXT-REC-BITMAP"
	if value-x80 = spaces
	    move 6 to toolbar-next-rec-sz
	else
	    move value-x80 to toolbar-next-rec-sz convert
	end-if
	set use-text-toolbar to false
	perform varying temp-idx from 1 by 1 until temp-idx > 6
	    if toolbar-sizes-table (temp-idx) = 0
		set use-text-toolbar to true
		exit perform
	    end-if
	end-perform
    else
	set use-text-toolbar to true
    end-if.

check-allow.
***  Ok, we have the user-name.  Let's see if this user is allowed to use this
***  program.  The method is as follows:
***  Check the file /etc/alfred.allow.  If the user is specified in this
***  file, then he is allowed to use the program.
***  If the file does not exist, then check the file /etc/alfred.deny.  If
***  the user is specified in this file, then he is _not_ allowed to use
***  the program.  If this file also does not exist, then only "root" is
***  allowed to use the program.
    set allowed to false.
    move "/etc/alfred.allow" to allow-filename.
    open input allow-file.
    move allow-file-status to allow-present
    if allow-file-status = "00"
        perform check-if-in-file
        if found-in-file
            set allowed to true
        end-if
        close allow-file
    else
        close allow-file
        move "/etc/alfred.deny" to allow-filename
        open input allow-file
        move allow-file-status to deny-present
        if allow-file-status = "00"
            perform check-if-in-file
            if not found-in-file
                set allowed to true
            end-if
        else
            if user-id = "root"
                set allowed to true
            end-if
        end-if
        close allow-file
    end-if.
    if not allowed
	if allow-not-present and deny-not-present and sw-1-on
	    call "AlfredPermission"
		on exception 
		    move 0 to return-code
	    end-call
    	    if return-code = 9
		next sentence
	    end-if
	end-if
	display message box permission-message,
		title is error-title, type is MB-OK, icon is MB-ERROR-ICON
	perform shutdown
    end-if.

check-if-in-file.
    set found-in-file to false.
    perform until found-in-file
	read allow-file next
	  end
	    exit perform
	  not end
	    if allow-name = user-id
		set found-in-file to true
	    end-if
	end-read
    end-perform.

parse-colors.
    perform varying color-idx from 1 by 1
			until color-idx > number-of-colors
	accept color-string from environment color-name-array (color-idx)
	if color-string = spaces
	    exit perform cycle
	end-if
***  If we have a value, use it to override the default (as opposed
***  to adding to the default)
	move 0 to color-array (color-idx)
	inspect color-string converting "abcdefghijklmnopqrstuvwxyz,"
				     to "ABCDEFGHIJKLMNOPQRSTUVWXYZ "
	move spaces to	color-string-table (1),
			color-string-table (2),
			color-string-table (3),
			color-string-table (4),
			color-string-table (5),
			color-string-table (6),
			color-string-table (7),
			color-string-table (8),
			color-string-table (9),
			color-string-table (10)
	unstring color-string delimited by all " " into
			color-string-table (1),
			color-string-table (2),
			color-string-table (3),
			color-string-table (4),
			color-string-table (5),
			color-string-table (6),
			color-string-table (7),
			color-string-table (8),
			color-string-table (9),
			color-string-table (10)
	set background to false
	move 1 to color-string-idx
	perform varying color-string-idx from 1 by 1
		until color-string-table (color-string-idx) = spaces
	    evaluate color-string-table (color-string-idx)
	      when "REVERSE"
		add 1024 to color-array (color-idx)
	      when "LOW"
		add 2048 to color-array (color-idx)
	      when "HIGH"
		add 4096 to color-array (color-idx)
	      when "UNDERLINE"
		add 8192 to color-array (color-idx)
	      when "BLINK"
		add 16384 to color-array (color-idx)
	      when "ON"
		set background to true
	      when "BLACK"
		if background
		    add bckgrnd-black to color-array (color-idx)
		else
		    add black to color-array (color-idx)
		end-if
	      when "BLUE"
		if background
		    add bckgrnd-blue to color-array (color-idx)
		else
		    add blue to color-array (color-idx)
		end-if
	      when "GREEN"
		if background
		    add bckgrnd-green to color-array (color-idx)
		else
		    add green to color-array (color-idx)
		end-if
	      when "CYAN"
		if background
		    add bckgrnd-cyan to color-array (color-idx)
		else
		    add cyan to color-array (color-idx)
		end-if
	      when "RED"
		if background
		    add bckgrnd-red to color-array (color-idx)
		else
		    add red to color-array (color-idx)
		end-if
	      when "MAGENTA"
		if background
		    add bckgrnd-magenta to color-array (color-idx)
		else
		    add magenta to color-array (color-idx)
		end-if
	      when "BROWN"
		if background
		    add bckgrnd-brown to color-array (color-idx)
		else
		    add brown to color-array (color-idx)
		end-if
	      when "WHITE"
		if background
		    add bckgrnd-white to color-array (color-idx)
		else
		    add white to color-array (color-idx)
		end-if
	      when other
		move 0 to temp-idx
		inspect color-string-table (color-string-idx)
			tallying temp-idx for trailing spaces
		set temp-idx2 to size of color-string-table (color-string-idx)
		compute temp-idx = temp-idx2 - temp-idx
		if temp-idx > 0 and
		   color-string-table (color-string-idx) (1:temp-idx) is numeric
		    move color-string-table (color-string-idx)
				to color-numeric convert
		    add color-numeric to color-array (color-idx)
		end-if
	    end-evaluate
	end-perform
	if color-array (color-idx) = 0
	    move 2049 to color-array (color-idx)	| low black
	end-if
	if not has-color and color-array (color-idx) = 2049
	    move 0 to color-array (color-idx)
	end-if
    end-perform.

***  Displays the key information, and accepts from the user
***  arrow keys, until the user presses <RETURN>.  The key number
***  that the cursor is on is the key we will use.  We then get all
***  the information for that key.
no-xfd section 60.
***  Get all information about 1 key.
get-one-key-info.
    set info-function to true.
    move key-num to info-mode.
    move spaces to key-info.
    call "I$IO" using io-function file-pointer info-mode key-info.

***  Enter a key map to describe the key.
***  First set up all the seg-idx-n and seg-len-n values.
get-key-map.
***  The reason we start at 2 is an apparent bug in the compiler or runtime
***  which loses the first character in the screen section if we start at 1
    perform varying seg-idx from 1 by 1 until seg-idx > num-segs
	compute seg-map-len (seg-idx) = 2 * key-size (seg-idx) - 1
    end-perform.
    perform varying seg-idx from num-segs by 1 until seg-idx = max-segs
	move 1 to seg-map-len (seg-idx + 1)
    end-perform.
    set valid-keymap to false.
    compute btn-line = 2 + num-segs.
    perform varying temp-num from 1 by 1 until temp-num > max-segs
	move temp-num to seg-number-table( temp-num )
	if temp-num <= num-segs
	    move 1 to seg-visible( temp-num )
	else
	    move 0 to seg-visible( temp-num )
	end-if
    end-perform.
    add 1 to btn-line giving temp-num.
    display floating window line 5 col 2 size 70 lines temp-num
		boxed color label-color
		cell size is entry-field font std-font-handle separate
		title is key-map-title handle save-area1.
    move 0 to exc-key.
    perform until exc-key = key-escape-key or menu-exit or key-return-key
	perform validate-keymap
	display key-map-screen
	accept key-map-screen
	  on exception
	    accept exc-key from escape
	    evaluate exc-key
	      when menu-exit
	      when key-escape-key
		move -1 to key-num
	      when menu-help
		perform show-enter-keymap-help
	      when other
		perform beep-user
	    end-evaluate
	  not on exception
	    perform validate-keymap
	    if valid-keymap
		move key-return-key to exc-key
	    end-if
	end-accept
	perform validate-keymap
    end-perform.
    close window save-area1.

prep-seg-size.

***  Allow X(nn) type syntax also.
test-seg-map.
    move spaces to temp-segment-map.
    move 1 to seg-byte.
    set parsing-paren to false.
    perform with test after varying temp-num from 1 by 1 until
		temp-num = seg-map-len (control-value)
	evaluate segment-map-table( control-value )( temp-num:1 )
	  when 'A'
	  when 'X'
	  when 'D'
	  when 'O'
	  when space
	    move segment-map-table( control-value )(temp-num:1) to init-value
	    move init-value to temp-segment-map (seg-byte:1)
	    add 1 to seg-byte
	  when '('
	    if temp-num = 1
		move 'C' to seg-indicator( control-value )
		set valid-keymap to false
		exit paragraph
	    end-if
	    move 0 to save-seg-byte
	    add 1 to temp-num
	    perform until segment-map-table( control-value )(temp-num:1) = ')' or
			temp-num = seg-map-len (control-value) - 1
		if segment-map-table( control-value )(temp-num:1) is numeric
		    move segment-map-table( control-value )(temp-num:1) to temp-pic9
		    compute save-seg-byte = save-seg-byte * 10 + temp-pic9
		      on size error
			move 0 to save-seg-byte
		    end-compute
		else
		    move 0 to save-seg-byte
		end-if
		add 1 to temp-num
	    end-perform
	    if save-seg-byte > 0
		subtract 1 from save-seg-byte
	    end-if
	    if save-seg-byte + seg-byte > max-seg-map-string-bytes
		move 0 to save-seg-byte
	    end-if
	    perform until save-seg-byte = 0
		move init-value to temp-segment-map(seg-byte:1)
		add 1 to seg-byte
		subtract 1 from save-seg-byte
	    end-perform
	    add 1 to seg-byte
	  when other
	    move 'C' to seg-indicator( control-value )
	    set valid-keymap to false
	    exit paragraph
	end-evaluate
    end-perform.
    move temp-segment-map to segment-map-table (control-value).
    set temp-num2 to size of segment-map-table( control-value ).
    move 0 to temp-num.
    inspect segment-map-table (control-value) tallying temp-num for all space.
    subtract temp-num from temp-num2 giving temp-num.
    if temp-num not = key-size (control-value)
	move 'S' to seg-indicator (control-value)
	set valid-keymap to false
    else if segment-map-table (control-value)
			is not map-chars
	move 'C' to seg-indicator (control-value)
	set valid-keymap to false
    else
	move ' ' to seg-indicator (control-value)
    end-if
    end-if.
    display key-indicators-screen.

validate-keymap.
    set valid-keymap to true.
    perform varying control-value from 1 by 1 until control-value > num-segs
	perform prep-seg-size
	perform test-seg-map
    end-perform.
    if valid-keymap
***  We need to get all the position information for the keys here.
	move 1 to seg-idx
	move 2 to line-no
	move 6 to col-no
	move 1 to sect-start (1)
	perform varying seg-num from 1 by 1 until seg-num > num-segs
	    move 1 to seg-byte
	    add 1 to line-no
	    move 6 to col-no
	    perform until segment-map-table( seg-num )(seg-byte:) = spaces
		perform until segment-map-table( seg-num )(seg-byte:1) not = space
		    add 1 to seg-byte
		end-perform
		move seg-num to sect-seg-num (seg-idx)
		move segment-map-table( seg-num )(seg-byte:1) to sect-type (seg-idx)
		move seg-byte to save-seg-byte
		perform until segment-map-table( seg-num )(seg-byte:1) not =
				segment-map-table( seg-num )(save-seg-byte:1)
		    add 1 to seg-byte
		end-perform
		compute total-sect-size = seg-byte - save-seg-byte
		perform until total-sect-size = 0
		    evaluate true
		      when sect-ascii (seg-idx)
			if total-sect-size > max-seg-bytes
			    move max-seg-bytes to sect-size (seg-idx)
			    subtract max-seg-bytes from total-sect-size
			else
			    move total-sect-size to sect-size (seg-idx)
			    move 0 to total-sect-size
			end-if
			move sect-size (seg-idx) to sect-bytes (seg-idx)
		      when sect-hex (seg-idx)
			if total-sect-size > 8
			    move 8 to sect-size (seg-idx)
			    subtract 8 from total-sect-size
			else
			    move total-sect-size to sect-size (seg-idx)
			    move 0 to total-sect-size
			end-if
			compute sect-bytes (seg-idx) = sect-size (seg-idx) * 2
		      when sect-octal (seg-idx)
			if total-sect-size > 8
			    move 8 to sect-size (seg-idx)
			    subtract 8 from total-sect-size
			else
			    move total-sect-size to sect-size (seg-idx)
			    move 0 to total-sect-size
			end-if
			compute sect-bytes (seg-idx) =
					(8 * sect-size (seg-idx) + 2) / 3
		      when sect-decimal (seg-idx)
			if total-sect-size > 8
			    move 8 to sect-size (seg-idx)
			    subtract 8 from total-sect-size
			else
			    move total-sect-size to sect-size (seg-idx)
			    move 0 to total-sect-size
			end-if
			evaluate sect-size (seg-idx)
			  when 1
			    move 3 to sect-bytes (seg-idx)
			  when 2
			    move 5 to sect-bytes (seg-idx)
			  when 3
			    move 8 to sect-bytes (seg-idx)
			  when 4
			    move 10 to sect-bytes (seg-idx)
			  when 5
			    move 13 to sect-bytes (seg-idx)
			  when 6
			    move 15 to sect-bytes (seg-idx)
			  when 7
			    move 17 to sect-bytes (seg-idx)
			  when 8
			    move 18 to sect-bytes (seg-idx)
			end-evaluate
		    end-evaluate
		    if col-no + sect-bytes (seg-idx) > 77
			add 1 to line-no
			move 6 to col-no
		    end-if
		    move line-no to sect-line (seg-idx)
		    move col-no to sect-col (seg-idx)
		    add sect-bytes (seg-idx) 2 to col-no
		    if total-sect-size not = 0
			add 1 to seg-idx
			move sect-seg-num (seg-idx - 1) to sect-seg-num (seg-idx)
			move sect-type (seg-idx - 1) to sect-type (seg-idx)
		    end-if
		    if seg-idx > 1
			compute sect-start (seg-idx) = sect-start (seg-idx - 1) +
				sect-bytes (seg-idx - 1) + 1
		    end-if
		end-perform
		add 1 to seg-idx
	    end-perform
	end-perform
	subtract 1 from seg-idx giving num-sects
    end-if.

***  This paragraph accepts a key from the user, based on the key-map
***  entered previously.  If the user cancels, then exc-key = key-escape-key,
***  and the record area is undefined.  If the user enters a key, then the
***  record area is initialized to low-values, and the key is moved into
***  the record area.
get-one-key.
***  num-sects is the number of virtual segments we have.
    add 3 to sect-line (num-sects) giving total-sect-size.
    display floating window
		line 5 col 2
		size 60 lines total-sect-size + .3
		boxed
		cell size is entry-field font std-font-handle separate
		title is enter-key-title handle save-area1.
    display seg-value-message line 1 color label-color.
    perform varying seg-idx from 1 by 1 until seg-idx > num-sects
	display label
		line sect-line (seg-idx)
		col 1.4
		title sect-seg-num (seg-idx)
		size 3
		color label-color
		handle in label-handles (seg-idx)
	display entry-field
		value spaces
		line sect-line (seg-idx)
		col sect-col (seg-idx)
		size sect-bytes (seg-idx)
		id seg-idx
		color entry-color
		style base-style
		handle in entry-handles (seg-idx)
    end-perform.
    if has-graphical-interface
	display push-button
	    ok-button
	    line total-sect-size
	    col 10
	    self-act
	display push-button
	    cancel-button
	    line total-sect-size
	    col 25
	    self-act
	display push-button
	    title help-title
	    line total-sect-size
	    col 40
	    size 6
	    self-act
	    exception-value is menu-help
    else
	display return-f1-f10-message line total-sect-size col 3
    end-if.
    move 1 to seg-idx.
    set done to false.
    perform until done
	perform determine-user-message
	display user-message(1:55) color label-color line total-sect-size - 1 col 3
	accept entry-handles (seg-idx) value in
		large-field (sect-start (seg-idx):sect-bytes (seg-idx))
	  exception exc-key
	    continue
	end-accept
	if exc-key not = menu-exit
	    perform test-key-data
	else
	    set bad-chars to false
	end-if
	if not bad-chars
	    evaluate exc-key
	      when key-event-happened
		evaluate event-type
		  when cmd-goto
		    if event-control-id > 0
			move event-control-id to seg-idx
		    end-if
		  when other
		    perform beep-user
		end-evaluate
	      when menu-help
		perform show-enter-key-no-xfd-help
	      when menu-exit
		set done to true
	      when key-return-key
		set done to true
		perform varying seg-idx from 1 by 1 until seg-idx > num-sects
		    move large-field (sect-start (seg-idx):sect-bytes (seg-idx))
			to one-section
		    perform put-value-in-key
		end-perform
	      when key-up-arrow
		if seg-idx > 1
		    subtract 1 from seg-idx
		else
		    perform beep-user
		end-if
	      when key-down-arrow
		if seg-idx < num-sects
		    add 1 to seg-idx
		else
		    perform beep-user
		end-if
	      when key-left-arrow
	      when key-backspace
	      when key-shift-tab-key
		if seg-idx > 1
		    subtract 1 from seg-idx
		else
		    perform beep-user
		end-if
	      when key-right-arrow
	      when key-tab-key
		if seg-idx < num-sects
		    add 1 to seg-idx
		else
		    perform beep-user
		end-if
	    end-evaluate
	end-if
    end-perform.
    set done to false.
    perform compute-bytes-per-page.
    close window save-area1.

get-record-byte-num.
    move sect-seg-num (seg-idx) to temp-num.
    add 1 to key-offset (temp-num) giving record-byte-num.
    perform varying save-seg-byte from 1 by 1 until save-seg-byte = seg-idx
	if sect-seg-num (save-seg-byte) = sect-seg-num (seg-idx)
	    add sect-size (save-seg-byte) to record-byte-num
	end-if
    end-perform.

test-key-data.
    set bad-chars to false.
    evaluate true
      when sect-decimal (seg-idx)
	move large-field (sect-start (seg-idx):sect-bytes (seg-idx))
		to numeric-value convert
	  exception
	    perform beep-user
	    set bad-chars to true
	    exit paragraph
	end-move
	if numeric-value < low-range or > high-range
	    perform beep-user
	    set bad-chars to true
	    exit paragraph
	end-if
      when sect-octal (seg-idx)
	move 0 to temp-idx
	inspect large-field (sect-start (seg-idx):sect-bytes (seg-idx))
		    tallying temp-idx for trailing spaces
	subtract temp-idx from sect-bytes (seg-idx) giving temp-idx
	if temp-idx = 0
	    move '0' to large-field (sect-start (seg-idx) : 1)
	    move 1 to temp-idx
	end-if
	inspect large-field (sect-start (seg-idx):temp-idx) replacing all space by '0'
	if large-field (sect-start (seg-idx) :temp-idx) is not octal-chars
	    perform beep-user
	    set bad-chars to true
	    exit paragraph
	end-if
      when sect-hex (seg-idx)
	move 0 to temp-idx
	inspect large-field (sect-start (seg-idx):sect-bytes (seg-idx))
		    tallying temp-idx for trailing spaces
	subtract temp-idx from sect-bytes (seg-idx) giving temp-idx
	if temp-idx = 0
	    move '0' to large-field (sect-start (seg-idx):1)
	    move 1 to temp-idx
	end-if
	if large-field (sect-start (seg-idx):temp-idx) is not hex-chars
	    perform beep-user
	    set bad-chars to true
	    exit paragraph
	end-if
    end-evaluate.

put-value-in-key.
    perform get-record-byte-num.
    evaluate true
      when sect-ascii (seg-idx)
	call "M$PUT" using record-area-ptr, one-section,
		    sect-size (seg-idx), record-byte-num

      when sect-decimal (seg-idx)
	move one-section (1:sect-bytes (seg-idx)) to numeric-value convert
	compute temp-idx = 9 - sect-size (seg-idx)
	call "M$PUT" using record-area-ptr, ascii-value (temp-idx:)
		    sect-size (seg-idx), record-byte-num

      when sect-octal (seg-idx)
	move 0 to temp-idx
	inspect one-section (1:sect-bytes (seg-idx))
		    tallying temp-idx for trailing spaces
	subtract temp-idx from sect-bytes (seg-idx) giving temp-idx
	if temp-idx = 0
	    move '0' to one-section
	    move 1 to temp-idx
	end-if
	inspect one-section (1:temp-idx) replacing all space by '0'
	move low-values to ascii-value
	move sect-size (seg-idx) to num-idx
	perform until temp-idx = 0
	    move spaces to temp-3-asc-val
	    if temp-idx >= 8
		move one-section (temp-idx - 7:8) to temp-area
		perform convert-octal-to-bin
		subtract 8 from temp-idx
	    else
		move '00000000' to temp-area
		move one-section (1:temp-idx) to temp-area (9 - temp-idx:)
		perform convert-octal-to-bin
		move 0 to temp-idx
	    end-if
	    subtract 1 from num-idx
	    compute offset-amount = record-byte-num + num-idx
	    call "M$PUT" using record-area-ptr, temp-3-asc-val
			    1, offset-amount
	    if num-idx > 0
		subtract 1 from num-idx
		compute offset-amount = record-byte-num + num-idx
		call "M$PUT" using record-area-ptr,
			    temp-3-asc-val (2:) 1, offset-amount
	    end-if
	    if num-idx > 0
		subtract 1 from num-idx
		compute offset-amount = record-byte-num + num-idx
		call "M$PUT" using record-area-ptr,
			    temp-3-asc-val (3:), 1, offset-amount
	    end-if
	end-perform

      when sect-hex (seg-idx)
	move 0 to temp-idx
	inspect one-section (1:sect-bytes (seg-idx))
		    tallying temp-idx for trailing spaces
	subtract temp-idx from sect-bytes (seg-idx) giving temp-idx
	if temp-idx = 0
	    move '0' to one-section
	    move 1 to temp-idx
	end-if
	move sect-size (seg-idx) to num-idx
	move low-values to ascii-value
	perform until temp-idx = 0
	    move spaces to temp-3-asc-val
	    if temp-idx >= 2
		move one-section (temp-idx - 1:2) to temp-area
		perform convert-hex-to-bin
		subtract 2 from temp-idx
	    else
		move '00' to temp-area
		move one-section (1:temp-idx) to temp-area (3 - temp-idx:)
		perform convert-hex-to-bin
		move 0 to temp-idx
	    end-if
	    subtract 1 from num-idx
	    compute offset-amount = record-byte-num + num-idx
	    call "M$PUT" using record-area-ptr, temp-3-asc-val (3:),
			    1, offset-amount
	end-perform
    end-evaluate.

determine-user-message.
    evaluate true
      when sect-ascii (seg-idx)
	move alpha-num-string-msg to user-message
      when sect-decimal (seg-idx)
	move decimal-range-msg to user-message
	move 0 to low-range
	evaluate sect-size (seg-idx)
	  when 1
	    move x"00000000000000ff" to ascii-value
	    move numeric-value to high-range
	  when 2
	    move x"000000000000ffff" to ascii-value
	    move numeric-value to high-range
	  when 3
	    move x"0000000000ffffff" to ascii-value
	    move numeric-value to high-range
	  when 4
	    move x"00000000ffffffff" to ascii-value
	    move numeric-value to high-range
	  when 5
	    move x"000000ffffffffff" to ascii-value
	    move numeric-value to high-range
	  when 6
	    move x"0000ffffffffffff" to ascii-value
	    move numeric-value to high-range
	  when 7
	    move x"00ffffffffffffff" to ascii-value
	    move numeric-value to high-range
	  when 8
	    move 999999999999999999 to high-range
	end-evaluate
	move high-range to temp-area
	move 0 to temp-idx
	inspect temp-area tallying temp-idx for leading '0'
	set temp-idx2 to size of user-message
	perform until user-message (temp-idx2:) not = spaces or temp-idx = 1
	    subtract 1 from temp-idx2
	end-perform
	add 2 to temp-idx2
	move temp-area (temp-idx + 1:) to user-message (temp-idx2:)
      when sect-octal (seg-idx)
	move octal-value-msg to user-message
      when sect-hex (seg-idx)
	move hex-value-msg to user-message
    end-evaluate.

print-record-no-xfd.
    move 1 to byte-counter first-byte-in-group.
    move 99 to line-no.
    perform until byte-counter > record-size
    	if line-no >= lines-per-page
    	    perform print-header-no-xfd
    	end-if
    	perform print-one-line
    end-perform.

print-header-no-xfd.
    perform print-header.
    move spaces to print-rec.
    write print-rec.
    add 1 to line-no.
    evaluate true
      when hex-mode
	move "0  1   2  3   4  5   6  7" to print-rec (8:)
	move "8  9   A  B   C  D   E  F" to print-rec (37:)
      when octal-mode
	move " 0      1      2      3  " to print-rec (9:)
	move " 4      5      6      7  " to print-rec (38:)
    end-evaluate.
    write print-rec.
    add 1 to line-no.
    move all "-" to print-rec.
    write print-rec.
    add 1 to line-no.
    move spaces to print-rec.
    write print-rec.
    add 1 to line-no.

print-one-line.
    move spaces to print-rec.
    subtract 1 from first-byte-in-group giving numeric-value.
    move first-ascii-col to disp-col2.
    if octal-mode
	divide numeric-value by 2 giving numeric-value
    end-if.
    move 1 to disp-col1.
    perform display-hex-or-octal.
    move 7 to disp-col1.
    perform display-8-byte-group.
    add 8 to first-byte-in-group.
    add 1 to disp-col1 disp-col2.
    if byte-counter > record-size
	exit paragraph
    end-if.
    perform display-8-byte-group.
    add 8 to first-byte-in-group.
    add 1 to disp-col1 disp-col2.
    write print-rec.
    add 1 to line-no.

***  This displays the current record window on the screen.  It assumes it
***  has 'full-page' lines to display in.  It starts displaying at byte
***  'top-byte' of the record.
display-record.
    perform compute-bytes-per-page.
    set redraw-screen to false.
    move byte-counter to save-byte-counter.
    move line-no to save-line-no.
    move col-no to save-col-no.
    compute window-line-no = record-window-line + header-frame-lines.
    display window line window-line-no erase.
    move 1 to line-no.
    move top-byte to byte-counter first-byte-in-group.
    evaluate true
      when hex-mode
	display "0  1   2  3   4  5   6  7" color label-color line line-no col 8
		"8  9   A  B   C  D   E  F" color label-color line line-no col 37
      when octal-mode
	display " 0      1      2      3  " color label-color line line-no col 9
		" 4      5      6      7  " color label-color line line-no col 38
    end-evaluate.
    compute window-line-no = record-window-line + header-frame-lines + 1.
    display window line window-line-no.
    if byte-counter = 1
	perform disable-page-up
    else
	perform enable-page-up
    end-if.
    perform varying line-no from 1 by 1 until line-no > full-page
	if byte-counter > record-size
	    exit perform cycle
	end-if
	move first-ascii-col to disp-col2
	subtract 1 from first-byte-in-group giving numeric-value
	if octal-mode
	    divide numeric-value by 2 giving numeric-value
	end-if
	move 1 to disp-col1
	move label-color to current-color-1
			    current-color-2
	perform display-hex-or-octal
	move 7 to disp-col1
	move entry-color to current-color-1
			    current-color-2
	perform display-8-byte-group
	add 8 to first-byte-in-group
	add 1 to disp-col1 disp-col2
	if byte-counter > record-size
	    exit perform cycle
	end-if
	perform display-8-byte-group
	add 8 to first-byte-in-group
	add 1 to disp-col1 disp-col2
    end-perform.
    if byte-counter < record-size
	perform enable-page-down
    else
	perform disable-page-down
    end-if.
    move save-line-no to line-no.
    move save-col-no to col-no.
    move save-byte-counter to byte-counter.
    perform calculate-line-and-col.

compute-bytes-per-page.
    compute full-page = number-of-screen-lines - record-window-line -
		header-frame-lines - 1.
    multiply 16 by full-page giving bytes-per-page.

***   Given byte-counter, determine the segment that comes next, and
***   put the number in "next-seg".  If byte-counter is in a segment,
***   store the segment number we are in.  Remember that byte-counter
***   is 1-based, and segment offsets are 0-based.
determine-next-seg.
    move 0 to next-seg.
    perform varying temp-idx from 1 by 1 until temp-idx > num-segs
***   Are we currently IN a segment?
	if byte-counter - 1 >= key-offset (temp-idx) and
	   byte-counter - 1 <  key-offset (temp-idx) + key-size (temp-idx)
	    move temp-idx to next-seg
	    exit perform
	end-if
	if byte-counter - 1 < key-offset (temp-idx)
	    if next-seg = 0
		move temp-idx to next-seg
	    else
		if key-offset (temp-idx) < key-offset (next-seg)
		    move temp-idx to next-seg
		end-if
	    end-if
	end-if
    end-perform.

***   Determine the colors of the bytes at byte-counter and byte-counter + 1
determine-current-color.
    if entry-color = key-color
	exit paragraph
    end-if.
    perform determine-next-seg.
    move entry-color to current-color-1 current-color-2.
    if next-seg > 0
	evaluate true
	  when byte-counter - 1 >= key-offset (next-seg) and
	       byte-counter - 1 <  key-offset (next-seg) + key-size (next-seg)
	    move key-color to current-color-1
	  when byte-counter - 1 >= key-offset (next-seg) + key-size (next-seg)
	    perform determine-next-seg
	end-evaluate
    end-if.
    if next-seg > 0
	add 1 to byte-counter
	evaluate true
	  when byte-counter - 1 >= key-offset (next-seg) and
	       byte-counter - 1 <  key-offset (next-seg) + key-size (next-seg)
	    move key-color to current-color-2
	end-evaluate
	subtract 1 from byte-counter
    end-if.

display-8-byte-group.
    move 8 to mem-area-bytes.
    if byte-counter + 7 > record-size
	compute mem-area-bytes = record-size - byte-counter + 1
    end-if.
    move low-values to temp-mem-area.
    call "M$GET" using record-area-ptr temp-mem-area
		mem-area-bytes byte-counter.
    perform until byte-counter > first-byte-in-group + mem-area-bytes - 1
	move 0 to numeric-value
	move temp-mem-area (byte-counter - first-byte-in-group + 1:2) to
		ascii-value (7:2)
	perform determine-current-color
	perform display-hex-or-octal
	add 7 to disp-col1
	add 2 to disp-col2 byte-counter
    end-perform.

display-hex-or-octal.
    if hex-mode
	move ascii-value (7:) to temp-3-asc-val (2:)
	perform convert-bin-to-hex
	move temp-area (1:4) to ascii-value (1:4)
	if printer-open
	    move ascii-value (1:2) to print-rec (disp-col1:2)
	    if disp-col1 = 1
		move ascii-value (3:2) to print-rec (disp-col1 + 2:2)
	    else
		move ascii-value (3:2) to print-rec (disp-col1 + 3:2)
	    end-if
	else
	    display ascii-value (1:2) color current-color-1
			line line-no col disp-col1
	    if disp-col1 = 1
		display ascii-value (3:2) color current-color-2
			line line-no col disp-col1 + 2
	    else
		display ascii-value (3:2) color current-color-2
			line line-no col disp-col1 + 3
	    end-if
	end-if
    else
	move ascii-value (6:) to temp-3-asc-val
	perform convert-bin-to-octal
	if printer-open
	    if disp-col1 = 1
		move temp-area (4:5) to print-rec (disp-col1:5)
	    else
		move temp-area (3:6) to print-rec (disp-col1:6)
	    end-if
	else
	    if disp-col1 = 1
		display temp-area (4:5) color current-color-1
			line line-no col disp-col1
	    else
		display temp-area (3:6) color current-color-1
			line line-no col disp-col1
	    end-if
	end-if
    end-if.
    if disp-col1 > 1
	if printer-open
	    move ".." to print-rec (disp-col2:2)
	    set printable to false
	    evaluate true
	      when test-printable-ascii
		if ascii-value (7:1) is printable-ascii
		    set printable to true
		end-if
	      when test-printable-euro
		if ascii-value (7:1) is printable-euro
		    set printable to true
		end-if
	    end-evaluate
	    if printable
		move ascii-value (7:1) to print-rec (disp-col2:1)
	    end-if
	    set printable to false
	    evaluate true
	      when test-printable-ascii
		if ascii-value (8:1) is printable-ascii
		    set printable to true
		end-if
	      when test-printable-euro
		if ascii-value (8:1) is printable-euro
		    set printable to true
		end-if
	    end-evaluate
	    if printable
		move ascii-value (8:1) to print-rec (disp-col2 + 1:1)
	    end-if
	else
	    display "." color current-color-1 line line-no col disp-col2
	    display "." color current-color-2 line line-no col disp-col2 + 1
	    set printable to false
	    evaluate true
	      when test-printable-ascii
		if ascii-value (7:1) is printable-ascii
		    set printable to true
		end-if
	      when test-printable-euro
		if ascii-value (7:1) is printable-euro
		    set printable to true
		end-if
	    end-evaluate
	    if printable
		display ascii-value (7:1) color current-color-1
			line line-no col disp-col2
	    end-if
	    set printable to false
	    evaluate true
	      when test-printable-ascii
		if ascii-value (8:1) is printable-ascii
		    set printable to true
		end-if
	      when test-printable-euro
		if ascii-value (8:1) is printable-euro
		    set printable to true
		end-if
	    end-evaluate
	    if printable
		display ascii-value (8:1) color current-color-2
			line line-no col disp-col2 + 1
	    end-if
	end-if
    end-if.

modify-record.
    move 1 to line-no.
    move 7 to col-no.
    set binary-data to true.
    set left-half to true.
    move 1 to octal-byte-num.
    move top-byte to byte-counter.
    set done to false.
    move 0 to exc-key.
    perform until done
	move menu-start-first to save-exc-key
	if file-open-io
	    perform determine-current-color
	    accept one-char from screen line line-no col col-no
	    move one-char to save-char
	    accept one-char color current-color-1 line line-no col col-no
					update auto
	      exception exc-key
		continue
	    end-accept
	    if one-char not = save-char
		perform modify-byte
		move undo-last-byte to undo-current-byte
		call "W$MENU" using wmenu-enable, alfred-main-menu, edit-submenu
		call "W$MENU" using wmenu-enable, alfred-main-menu, menu-save-record
		perform show-main-menu
	    end-if
	else
	    accept omitted line line-no col col-no
	      exception exc-key
	        if exc-key = 87
		    move line-no to debug-disp-line
		    move col-no to debug-disp-col
		    display message box debug-line-col-nums-message,
				title is debug-title, type is MB-OK
		end-if
	    end-accept
	end-if
	if not undo-key and exc-key not = menu-undo
	    move undo-last-byte to undo-current-byte
	end-if
	perform move-around
	perform calculate-line-and-col
	if redraw-screen
	    perform display-record
	end-if
    end-perform.
    set done to false.
    display window line window-line-no - 1 erase.
    move 1 to window-line-no.
    display window line window-line-no.

move-around.
    evaluate true
      when no-key
      when return-key
	continue
      when left-arrow
      when backspace
	perform goto-previous-valid-col
      when right-arrow
	perform goto-next-valid-col
      when up-arrow
	perform goto-previous-valid-line
      when down-arrow
	perform goto-next-valid-line
      when exc-key = menu-previous-page
      when page-up
	perform goto-previous-valid-page
      when exc-key = menu-next-page
      when page-down
	perform goto-next-valid-page
      when home-key
	perform goto-home
      when end-key
	perform goto-end
      when exc-key = menu-ascii-area
	set binary-data to true
	perform switch-data-areas
      when exc-key = menu-raw-area
	set ascii-data to true
	perform switch-data-areas
      when tab-key
	perform switch-data-areas
      when button-pressed
	perform move-cursor
      when about-key
	perform show-about-alfred
      when help-key
	perform show-main-menu-help
      when exc-key = menu-hex
	set octal-mode to true
	perform toggle-hex-octal
      when exc-key = menu-octal
	set hex-mode to true
	perform toggle-hex-octal
      when toggle-key
	perform toggle-hex-octal
      when exc-key = menu-next-record
      when next-key
	perform test-record-modified
	perform read-next-record
	if file-error
	    perform no-current-record
	end-if
      when exc-key = menu-previous-record
      when previous-key
	perform test-record-modified
	perform read-previous-record
	if file-error
	    perform no-current-record
	end-if
      when exc-key = menu-exit
      when escape-key
	perform test-record-modified
	set done to true
      when exc-key = menu-undo
      when undo-key
	perform undo-one-step
      when exc-key = menu-open-input
	perform open-file-input
	if file-open-input
	    call "W$MENU" using wmenu-check, alfred-main-menu, menu-open-input
	    call "W$MENU" using wmenu-uncheck, alfred-main-menu, menu-open-io
	    perform show-main-menu
	    set view-mode to true
	end-if
      when exc-key = menu-open-io
	perform open-file-io
	if file-open-io
	    call "W$MENU" using wmenu-uncheck, alfred-main-menu, menu-open-input
	    call "W$MENU" using wmenu-check, alfred-main-menu, menu-open-io
	    perform show-main-menu
	    set change-mode to true
	end-if
      when exc-key = menu-open-file
      when exc-key = menu-reference-key
	move exc-key to save-exc-key
	perform test-record-modified
	set done to true
      when exc-key = menu-start-nlt
      when exc-key = menu-start-ngt
	move exc-key to save-exc-key
	perform test-record-modified
	move save-exc-key to exc-key
	perform start-file-nlt-or-ngt
	if not have-a-record
	    perform restore-position
	end-if
      when exc-key = menu-start-first
	perform test-record-modified
	perform start-first-record
      when exc-key = menu-start-last
	perform test-record-modified
	perform start-last-record
      when exc-key = menu-add-record
	if file-open-input
	    perform open-mode-error
	else
	    perform test-record-modified
	    perform get-record-size
	    if record-size not = 0
		move low-values to init-value
		perform initialize-record
		perform get-one-key
		if seg-num = 0
		    set done to true
		else
		    set add-mode to true
		    set redraw-screen to true
		end-if
	    end-if
	end-if
      when exc-key = menu-print
	perform print-record
      when exc-key = menu-delete-record
	if file-open-input
	    perform open-mode-error
	else
	    perform delete-record
	end-if
      when exc-key = menu-save-record
	if file-open-input
	    perform open-mode-error
	else
	    perform test-record-modified
	end-if
      when other
	perform beep-user
    end-evaluate.

goto-previous-valid-col.
    if ascii-data
	subtract 1 from byte-counter
    else
	evaluate true
	  when hex-mode and left-half and byte-counter not = 1
	    set right-half to true
	    subtract 1 from byte-counter
	  when hex-mode and right-half
	    set left-half to true
	  when octal-mode and octal-byte-num = 1 and byte-counter not = 1
	    move 6 to octal-byte-num
	    subtract 1 from byte-counter
	    if byte-counter > 0
		subtract 1 from byte-counter
	    end-if
	  when octal-mode and octal-byte-num > 1
	    subtract 1 from octal-byte-num
	end-evaluate
    end-if.

goto-next-valid-col.
    if ascii-data
	add 1 to byte-counter
    else
	evaluate true
	  when hex-mode and left-half
	    set right-half to true
	  when hex-mode and right-half and byte-counter not = record-size + 1
	    set left-half to true
	    add 1 to byte-counter
	  when octal-mode and octal-byte-num = 6 and byte-counter not = record-size + 1
	    move 1 to octal-byte-num
	    add 2 to byte-counter
	  when octal-mode and octal-byte-num < 6
	    add 1 to octal-byte-num
	end-evaluate
    end-if.

goto-previous-valid-line.
    if byte-counter > 16
	subtract 16 from byte-counter
    else
	move 1 to byte-counter
    end-if.

goto-next-valid-line.
    add 16 to byte-counter.

goto-previous-valid-page.
    if byte-counter > bytes-per-page
	subtract bytes-per-page from byte-counter
    else
	move 1 to byte-counter
    end-if.

goto-next-valid-page.
    add bytes-per-page to byte-counter.

goto-home.
    move 1 to byte-counter.
    set left-half to true.
    move 1 to octal-byte-num.

goto-end.
    add 1 to record-size giving byte-counter.
    set left-half to true.
    move 1 to octal-byte-num.

switch-data-areas.
    evaluate true
      when binary-data
	set ascii-data to true
	call "W$MENU" using wmenu-uncheck, alfred-main-menu, menu-raw-area
	call "W$MENU" using wmenu-check, alfred-main-menu, menu-ascii-area
      when ascii-data
	set binary-data to true
	call "W$MENU" using wmenu-check, alfred-main-menu, menu-raw-area
	call "W$MENU" using wmenu-uncheck, alfred-main-menu, menu-ascii-area
    end-evaluate.
    perform show-main-menu.

***  We have the following screen layout.
***        1         2         3         4         5         6         7         
*234567890123456789012345678901234567890123456789012345678901234567890123456789
*xxx  xx xx  xx xx  xx xx  xx xx   xx xx  xx xx  xx xx  xx xx  aaaaaaaa aaaaaaa
*oooo oooooo oooooo oooooo oooooo  oooooo oooooo oooooo oooooo aaaaaaaa aaaaaaa
move-cursor.
    call "W$MOUSE" using get-mouse-status mouse-info.
    evaluate true
      when mouse-row = 0
	perform goto-previous-valid-page
      when mouse-row > full-page
	perform goto-next-valid-page
      when mouse-col < first-binary-col
	set binary-data to true
	if hex-mode
	    set left-half to true
	else
	    move 1 to octal-byte-num
	end-if
	compute byte-counter = top-byte + (mouse-row - 1) * 16
      when other
	if mouse-col < first-ascii-col
	    set binary-data to true
	else
	    set ascii-data to true
	end-if
	if ascii-data
	    compute byte-counter = mouse-col - first-ascii-col
	    if mouse-col > ascii-col-sep
		subtract 1 from byte-counter
	    end-if
	else
	    move mouse-col to temp-num
	    if temp-num > binary-col-sep
		subtract 1 from temp-num
	    end-if
	    compute temp-num = temp-num - first-binary-col + 1
	    divide temp-num by 7 giving temp-num remainder temp-pic9
	    compute byte-counter = 2 * temp-num
	    if hex-mode
		if temp-pic9 > 2
		    add 1 to byte-counter
		end-if
		if temp-pic9 = 0 or 1 or 3 or 4
		    set left-half to true
		else
		    set right-half to true
		end-if
	    else
		move temp-pic9 to octal-byte-num
		if octal-byte-num = 0
		    move 1 to octal-byte-num
		end-if
	    end-if
	end-if
	compute byte-counter = top-byte + (mouse-row - 1) * 16 + byte-counter
    end-evaluate.

toggle-hex-octal.
    evaluate true
      when hex-mode
	set octal-mode to true
	call "W$MENU" using wmenu-uncheck, alfred-main-menu, menu-hex
	call "W$MENU" using wmenu-check, alfred-main-menu, menu-octal
      when octal-mode
	set hex-mode to true
	call "W$MENU" using wmenu-check, alfred-main-menu, menu-hex
	call "W$MENU" using wmenu-uncheck, alfred-main-menu, menu-octal
    end-evaluate.
    perform show-main-menu.
    set redraw-screen to true.

***  Decrement the current-undo pointer, call 'modify-byte'.
undo-one-step.
    if undo-current-byte = undo-first-byte
	display message box no-more-undo-message,
		title is warning-title, type is MB-OK
    else
	perform get-mem-undo-info
	move undo-pos to byte-counter
	move undo-byte to save-char
	perform add-to-undo-list
	call "M$PUT" using record-area-ptr, save-char, 1, byte-counter
	subtract 1 from undo-current-byte
	if undo-current-byte = 0 and undo-first-byte not = 0
	    move number-of-undo-steps to undo-current-byte
	end-if
	if undo-current-byte = undo-first-byte and not undo-wrap
	    set record-modified to false
	else
	    set record-modified to true
	end-if
	perform calculate-line-and-col
	if not redraw-screen
	    perform display-from-record-data
	end-if
    end-if.

calculate-line-and-col.
    if byte-counter > record-size
	move record-size to byte-counter
    end-if.
    if byte-counter <= 0
	move 1 to byte-counter
    end-if.
    perform until byte-counter >= top-byte
	set redraw-screen to true
	subtract bytes-per-page from top-byte
    end-perform.
    perform until byte-counter < top-byte + bytes-per-page
	set redraw-screen to true
	add bytes-per-page to top-byte
    end-perform.
    subtract 1 from byte-counter.
    divide byte-counter by 16 giving line-no remainder col-no.
    add 1 to byte-counter.
    compute line-no = (byte-counter - top-byte) / 16 + 1.
    move col-no to disp-col1 disp-col2.
    add first-ascii-col to disp-col2.
    if disp-col2 >= ascii-col-sep
	add 1 to disp-col2
    end-if.
    if octal-mode
	divide disp-col1 by 2 giving disp-col1
	multiply disp-col1 by 2 giving disp-col1
    end-if.
    evaluate disp-col1
      when 0
	move 7 to disp-col1
      when 1
	move 10 to disp-col1
      when 2
	move 14 to disp-col1
      when 3
	move 17 to disp-col1
      when 4
	move 21 to disp-col1
      when 5
	move 24 to disp-col1
      when 6
	move 28 to disp-col1
      when 7
	move 31 to disp-col1
      when 8
	move 36 to disp-col1
      when 9
	move 39 to disp-col1
      when 10
	move 43 to disp-col1
      when 11
	move 46 to disp-col1
      when 12
	move 50 to disp-col1
      when 13
	move 53 to disp-col1
      when 14
	move 57 to disp-col1
      when 15
	move 60 to disp-col1
    end-evaluate.
    evaluate true
      when ascii-data
	move disp-col2 to col-no
      when hex-mode
	move disp-col1 to col-no
	if right-half
	    add 1 to col-no
	end-if
      when octal-mode
	compute col-no = disp-col1 + octal-byte-num - 1
    end-evaluate.

modify-byte.
    move low-values to ascii-value.
    evaluate true
      when ascii-data
	perform add-to-undo-list
	call "M$PUT" using record-area-ptr, one-char, 1, byte-counter
	set record-modified to true
	perform display-from-record-data
	perform goto-next-valid-col
      when hex-mode
	if one-char is not hex-chars
	    display save-char color entry-color line line-no col col-no bell
	else
	    set record-modified to true
	    perform add-to-undo-list
	    move spaces to temp-3-asc-val
	    call "M$GET" using record-area-ptr, temp-3-asc-val (3:)
			1, byte-counter
	    perform convert-bin-to-hex
	    if left-half
		move one-char to temp-area (3:1)
	    else
		move one-char to temp-area (4:1)
	    end-if
	    perform convert-hex-to-bin
	    call "M$PUT" using record-area-ptr, temp-3-asc-val (3:), 1,
			byte-counter
	    display space color entry-color line line-no col disp-col2 size 1
	    set printable to false
	    evaluate true
	      when test-printable-ascii
		if temp-3-asc-val (3:1) is printable-ascii
		    set printable to true
		end-if
	      when test-printable-euro
		if temp-3-asc-val (3:1) is printable-euro
		    set printable to true
		end-if
	    end-evaluate
	    if printable
		display temp-3-asc-val (3:1) color entry-color
					line line-no col disp-col2
	    else
		display '.' color entry-color line line-no col disp-col2
	    end-if
	    perform goto-next-valid-col
	end-if
      when octal-mode
	if one-char is not octal-chars
	    display save-char color entry-color line line-no col col-no bell
	else
	    set record-modified to true
	    perform add-to-undo-list
	    divide byte-counter by 2 giving temp-num remainder temp-pic9
	    if temp-pic9 = 1
		call "M$GET" using record-area-ptr, ascii-value (7:2), 2,
			byte-counter
	    else
		subtract 1 from byte-counter
		call "M$GET" using record-area-ptr, ascii-value (7:2), 2,
			byte-counter
		add 1 to byte-counter
	    end-if
	    move ascii-value (6:) to temp-3-asc-val
	    perform convert-bin-to-octal
	    move one-char to temp-area (2 + octal-byte-num:1)
	    perform convert-octal-to-bin
	    move temp-3-asc-val to ascii-value (6:)
	    divide byte-counter by 2 giving temp-num remainder temp-pic9
	    display space color entry-color line line-no col disp-col2 size 2
	    if temp-pic9 = 1
		call "M$PUT" using record-area-ptr, ascii-value (7:2), 2,
			byte-counter
		set printable to false
		evaluate true
		  when test-printable-ascii
		    if ascii-value (7:1) is printable-ascii
			set printable to true
		    end-if
		  when test-printable-euro
		    if ascii-value (7:1) is printable-euro
			set printable to true
		    end-if
		end-evaluate
		if printable
		    display ascii-value (7:1) color entry-color line line-no col disp-col2
		else
		    display '.' color entry-color line line-no col disp-col2
		end-if
		set printable to false
		evaluate true
		  when test-printable-ascii
		    if ascii-value (8:1) is printable-ascii
			set printable to true
		    end-if
		  when test-printable-euro
		    if ascii-value (8:1) is printable-euro
			set printable to true
		    end-if
		end-evaluate
		if printable
		    display ascii-value (8:1) color entry-color line line-no col disp-col2 + 1
		else
		    display '.' color entry-color line line-no col disp-col2 + 1
		end-if
	    else
		subtract 1 from byte-counter
		call "M$PUT" using record-area-ptr, ascii-value (7:2), 2,
			byte-counter
		set printable to false
		evaluate true
		  when test-printable-ascii
		    if ascii-value (7:1) is printable-ascii
			set printable to true
		    end-if
		  when test-printable-euro
		    if ascii-value (7:1) is printable-euro
			set printable to true
		    end-if
		end-evaluate
		if printable
		    display ascii-value (7:1) color entry-color line line-no col disp-col2 - 1
		else
		    display '.' color entry-color line line-no col disp-col2 - 1
		end-if
		set printable to false
		evaluate true
		  when test-printable-ascii
		    if ascii-value (8:1) is printable-ascii
			set printable to true
		    end-if
		  when test-printable-euro
		    if ascii-value (8:1) is printable-euro
			set printable to true
		    end-if
		end-evaluate
		if printable
		    display ascii-value (8:1) color entry-color line line-no col disp-col2
		else
		    display '.' color entry-color line line-no col disp-col2
		end-if
		add 1 to byte-counter
	    end-if
	    perform goto-next-valid-col
	end-if
    end-evaluate.

display-from-record-data.
    evaluate true
      when hex-mode
	move spaces to temp-3-asc-val
	call "M$GET" using record-area-ptr, one-mem-byte, 1, byte-counter
	move one-mem-byte to temp-3-asc-val (3:1)
	perform convert-bin-to-hex
	display temp-area (3:2) color entry-color line line-no col disp-col1
      when octal-mode
	divide byte-counter by 2 giving temp-num remainder temp-pic9
	if temp-pic9 = 1
	    call "M$GET" using record-area-ptr, ascii-value (7:2), 2,
			byte-counter
	    move ascii-value (7:1) to one-mem-byte
	else
	    subtract 1 from byte-counter
	    call "M$GET" using record-area-ptr, ascii-value (7:2), 2,
			byte-counter
	    move ascii-value (8:1) to one-mem-byte
	    add 1 to byte-counter
	end-if
	move ascii-value (6:) to temp-3-asc-val
	perform convert-bin-to-octal
	display temp-area (3:6) color entry-color line line-no col disp-col1
    end-evaluate.
    perform determine-current-color.
    display space color current-color-1 line-no col disp-col2 size 1
    set printable to false
    evaluate true
      when test-printable-ascii
	if one-mem-byte is printable-ascii
	    set printable to true
	end-if
      when test-printable-euro
	if one-mem-byte is printable-euro
	    set printable to true
	end-if
    end-evaluate.
    if printable
	display one-mem-byte color current-color-1 line line-no col disp-col2
    else
	display '.' color current-color-1 line line-no col disp-col2
    end-if.

add-to-undo-list.
    add 1 to undo-last-byte.
    if undo-last-byte > number-of-undo-steps
	set undo-wrap to true
	move 1 to undo-last-byte
    end-if.
    if undo-wrap
	add 1 to undo-first-byte
	if undo-first-byte > number-of-undo-steps
	    move 1 to undo-first-byte
	end-if
    end-if.
    call "M$GET" using record-area-ptr undo-byte 1 byte-counter.
    move byte-counter to undo-pos.
    perform put-mem-undo-info.

with-xfd section 70.
get-one-key-info.
    add 1 to key-num giving xfd-key-index.
    call "ParseXFD" using get-key-info-op.

setup-xfd-key-screen.
    move 2 to btn-line.
    perform varying key-label-index from 1 by 1 until key-label-index > 16
	if key-label-index > xfd-num-of-key-fields
	    move spaces to key-label-table (key-label-index)
	    move 0 to field-visible-table (key-label-index)
	    compute field-indexes-table (key-label-index) =
		    field-indexes-table (key-label-index - 1) +
		    field-lengths-table (key-label-index - 1) + 1
	    move 1 to field-lengths-table (key-label-index)
	else
	    add 1 to btn-line
	    move xfd-key-field-name (key-label-index) to
			key-label-table (key-label-index)
	    move 1 to field-visible-table (key-label-index)
	    if key-label-index = 1
	        move 1 to field-indexes-table (key-label-index)
	    else
	        compute field-indexes-table (key-label-index) =
		field-indexes-table (key-label-index - 1) +
		field-lengths-table (key-label-index - 1) + 1
	    end-if
	    move xfd-key-field-num (key-label-index) to xfd-field-index
	    call "ParseXFD" using get-field-info-op
	    move xfd-field-digits to field-lengths-table (key-label-index)
	    if xfd-field-scale < 0
		add 1 to field-lengths-table (key-label-index)
	    end-if
	    if signed-field
		add 1 to field-lengths-table (key-label-index)
	    end-if
	end-if
    end-perform.

***  This paragraph accepts a key from the user, using the XFD of the file.
***  If the user cancels, then exc-key = key-escape-key,
***  and the record area is undefined.  If the user enters a key, then the
***  record area is initialized to low-values, and the key is moved into
***  the record area.
get-one-key.
    move xfd-field-index to save-xfd-field-index.
    add 1 to btn-line giving temp-num.
    display floating window line 5 col 2 size 60 lines temp-num
		boxed color label-color
		cell size is entry-field font std-font-handle separate
		title is enter-key-title handle save-area1.
    set done to false.
    perform until done
	display xfd-key-screen
	accept xfd-key-screen
	  on exception
	    accept exc-key from escape
	    evaluate exc-key
	      when key-escape-key
	        set done to true
	      when key-help-key
		perform show-enter-key-with-xfd-help
	      when other
	        perform beep-user
	    end-evaluate
	  not on exception
	    set done to true
	end-accept
    end-perform.
    set done to false.
    close window save-area1.
    if exc-key not = key-escape-key
	move low-values to init-value
	perform initialize-record
	perform varying key-label-index from 1 by 1 until
		key-label-index > xfd-num-of-key-fields
	    move xfd-key-field-num( key-label-index ) to xfd-field-index
	    call "ParseXFD" using get-field-info-op
	    move field-lengths-table (key-label-index) to field-size
	    move segment-map-table( key-label-index ) to large-field
	    move xfd-field-offset to first-byte-in-group
	    perform modify-field
	end-perform
    end-if.

print-record-with-xfd.
    move 1 to byte-counter first-byte-in-group.
    move 99 to line-no.
    move 1 to xfd-field-index.
    perform varying xfd-field-index from 1 by 1 until
		xfd-field-index > xfd-total-number-fields
	if line-no >= lines-per-page
	    perform print-header-with-xfd
	end-if
	perform print-one-line
    end-perform.

print-header-with-xfd.
    perform print-header.
    move spaces to print-rec.
    write print-rec.
    add 1 to line-no.
    move all "-" to print-rec.
    write print-rec.
    add 1 to line-no.
    move spaces to print-rec.
    write print-rec.
    add 1 to line-no.

print-one-line.
    call "ParseXFD" using get-field-info-op.
    move xfd-field-name to print-rec.
    if xfd-field-condition > 0
	move xfd-field-condition to xfd-cond-index
	call "ParseXFD" using get-cond-info-op
	if not true-condition
	    move all '*' to print-rec (xfd-max-field-name-len + 2:)
	    write print-rec
	    add 1 to line-no
	    exit paragraph
	end-if
    end-if.
    add 1 to xfd-field-offset giving first-byte-in-group.
    evaluate true
      when float-field or numeric-field
	call "C$LCONVERT" using value-x80, record-area-ptr,
		xfd-field-offset, xfd-field-length,
		xfd-field-type, xfd-field-digits, xfd-field-scale
	move value-x80 to print-rec (xfd-max-field-name-len + 2:)
	write print-rec
	add 1 to line-no
      when ascii-field 
	if xfd-field-length < max-text-length
	    move xfd-field-length to field-size
	else
	    move max-text-length to field-size
	end-if
	move spaces to large-field
	call "M$GET" using record-area-ptr, large-field,
		field-size, first-byte-in-group
	move 1 to first-byte-in-group
	add 2 to xfd-max-field-name-len giving temp-idx
	perform until first-byte-in-group > field-size
	    move large-field (first-byte-in-group:) to print-rec (temp-idx:)
	    write print-rec
	    add 1 to line-no
	    compute first-byte-in-group =
			first-byte-in-group + print-width - temp-idx + 1
	    move spaces to print-rec
	end-perform
      when national-field 
	if xfd-field-length < max-text-length
	    move xfd-field-length to field-size
	else
	    move max-text-length to field-size
	end-if
	move spaces to large-field
	call "M$GET" using record-area-ptr, large-nat-field,
		field-size, first-byte-in-group
	move 1 to first-byte-in-group
	add 2 to xfd-max-field-name-len giving temp-idx
	perform until first-byte-in-group > field-size
	    move large-nat-field (first-byte-in-group:) to print-rec (temp-idx:)
	    write print-rec
	    add 1 to line-no
	    compute first-byte-in-group =
			first-byte-in-group + print-width - temp-idx + 1
	    move spaces to print-rec
	end-perform
      when wide-field 
	if xfd-field-length < max-text-length
	    move xfd-field-length to field-size
	else
	    move max-text-length to field-size
	end-if
	move spaces to large-field
	call "M$GET" using record-area-ptr, large-wide-field,
		field-size, first-byte-in-group
	move 1 to first-byte-in-group
	add 2 to xfd-max-field-name-len giving temp-idx
	perform until first-byte-in-group > field-size
	    move large-wide-field (first-byte-in-group:) to print-rec (temp-idx:)
	    write print-rec
	    add 1 to line-no
	    compute first-byte-in-group =
			first-byte-in-group + print-width - temp-idx + 1
	    move spaces to print-rec
	end-perform
    end-evaluate.

display-record.
    set redraw-screen to false.
    move xfd-field-index to save-byte-counter.
    move line-no to save-line-no.
    compute full-page = number-of-screen-lines - record-window-line -
		header-frame-lines.
    if full-page > number-of-controls
	move number-of-controls to full-page
    end-if.
    move top-byte to byte-counter first-byte-in-group.
    if top-byte = 1
	perform disable-page-up
    else
	perform enable-page-up
    end-if.
    set field-on-page to false.
    perform varying line-no from 1 by 1 until line-no > full-page
	compute xfd-field-index = line-no + top-byte - 1
	if xfd-field-index <= xfd-total-number-fields
	    call "ParseXFD" using get-field-info-op
	    if xfd-field-condition > 0
		move xfd-field-condition to xfd-cond-index
		call "ParseXFD" using get-cond-info-op
		if not true-condition
		    perform destroy-entry
		    move disabled-color to current-color-1
		    perform display-label-handle
		    exit perform cycle
		end-if
	    end-if
	    set field-on-page to true
	    move label-color to current-color-1
	    perform varying xfd-key-field-idx from 1 by 1 until
			xfd-key-field-idx > xfd-num-of-key-fields
		if xfd-key-field-num (xfd-key-field-idx) = xfd-field-index
		    move key-color to current-color-1
		end-if
	    end-perform
	    perform display-label-handle
	    perform display-field
	else
	    perform destroy-label-and-entry
	end-if
    end-perform.
    if xfd-field-index < xfd-total-number-fields
	perform enable-page-down
    else
	perform disable-page-down
    end-if.
    move save-byte-counter to xfd-field-index.
    move save-line-no to line-no.
    set need-field-info to true.

***  Is the field we're on still valid?
    call "ParseXFD" using get-field-info-op.
    if xfd-field-condition not = 0
	move xfd-field-condition to xfd-cond-index
	call "ParseXFD" using get-cond-info-op
    end-if.
    if xfd-field-condition not = 0 and not true-condition
	if xfd-field-index < min-xfd-field-index
	    perform goto-next-valid-line
	else
	    perform goto-previous-valid-line
	end-if
    end-if.

display-label-handle.
    if label-handles (line-no) = null
	display label
		line line-no + header-frame-lines + record-window-line - 1
		col 2
		size xfd-max-field-name-len
		title xfd-field-name
		color current-color-1
		handle in label-handles (line-no)
    else
	modify label-handles (line-no) title xfd-field-name
		color current-color-1
    end-if.

destroy-all-controls.
    move line-no to save-line-no.
    perform varying line-no from 1 by 1
		until line-no > number-of-controls
	perform destroy-label-and-entry
    end-perform.
    move save-line-no to line-no.

destroy-entry.
    destroy      entry-handles (line-no).
    move null to entry-handles (line-no).

destroy-label-and-entry.
    destroy	 label-handles (line-no)
		 entry-handles (line-no).
    move null to label-handles (line-no)
		 entry-handles (line-no).

display-field.
    if not printer-open
	if entry-handles (line-no) = null
***   We'll modify it below
	    compute disp-col2 = 80 - disp-col1 - 1
	    display entry-field
		    value spaces
		    line line-no + record-window-line + header-frame-lines - 1
		    col disp-col1
		    size disp-col2
		    max-text = 1
		    color entry-color
		    id line-no
		    style entry-style
		    handle in entry-handles (line-no)
	else
	    modify entry-handles (line-no) style entry-style
	end-if
    end-if.
    move xfd-field-offset to first-byte-in-group.
    evaluate true
      when numeric-field
	move xfd-field-digits to field-size
	if xfd-field-scale < 0
	    add 1 to field-size
	end-if
	if signed-field
	    add 1 to field-size
	end-if
	move "C$LCONVERT" to convert-function
	move "M$GET" to get-put-fcn
	perform convert-numeric-field
      when float-field
	if xfd-field-length = 4
	    move 13 to field-size
	else
	    move 22 to field-size
	end-if
	move "C$LCONVERT" to convert-function
	move "M$GET" to get-put-fcn
	perform convert-numeric-field
      when ascii-field
	add 1 to xfd-field-offset
	if xfd-field-length < max-text-length
	    move xfd-field-length to field-size
	else
	    move max-text-length to field-size
	end-if
	call "M$GET" using record-area-ptr, large-field,
		field-size, xfd-field-offset
	subtract 1 from xfd-field-offset
	if field-size > disp-col2
	    move disp-col2 to temp-idx
	else
	    move field-size to temp-idx
	end-if
	if not printer-open
	    modify entry-handles (line-no)
		value large-field (1:field-size)
		max-text field-size
		size temp-idx
	end-if
      when national-field
	add 1 to xfd-field-offset
	if xfd-field-length < max-text-length
	    move xfd-field-length to field-size	
	else
	    move max-text-length to field-size
	end-if
	call "M$GET" using record-area-ptr, large-nat-field,
		field-size, xfd-field-offset
	subtract 1 from xfd-field-offset
	if field-size > disp-col2
	    move disp-col2 to temp-idx
	else
	    move field-size to temp-idx
	end-if
	if not printer-open
	    modify entry-handles (line-no)
		value large-nat-field (1:field-size / 2)
		max-text field-size
		size temp-idx
	end-if
      when wide-field
	add 1 to xfd-field-offset
	if xfd-field-length < max-text-length
	    move xfd-field-length to field-size
	else
	    move max-text-length to field-size
	end-if
	call "M$GET" using record-area-ptr, large-wide-field,
		field-size, xfd-field-offset
	subtract 1 from xfd-field-offset
	if field-size > disp-col2
	    move disp-col2 to temp-idx
	else
	    move field-size to temp-idx
	end-if
	if not printer-open
	    modify entry-handles (line-no)
		value large-wide-field (1:field-size)
		max-text field-size
		size temp-idx
	end-if
      when other
	display message box unknown-data-message,
		title is error-title, type is MB-OK, icon is MB-ERROR-ICON
    end-evaluate.

modify-record.
    move top-byte to byte-counter.
    set done to false.
    set need-field-info to true.
***  Need to calculate the line and column once at the beginning.
    perform calculate-line-and-col.
    move 0 to exc-key.
    perform until done
	move menu-start-first to save-exc-key
	if need-field-info
	    call "ParseXFD" using get-field-info-op
	    perform display-field
	    perform calculate-line-and-col
	    set need-field-info to false
	end-if
	perform calc-and-display-offset
	set field-modified to false
***  Loop until something happens besides typing into the field....
	move line-no to goto-line-no
	perform with test after until
			exc-key not = key-event-happened or
			event-type not = ntf-changed
	    accept entry-handles (line-no) value in large-field
	      exception exc-key
		evaluate exc-key
		  when key-event-happened
		    evaluate event-type
		      when cmd-goto
			move event-control-id to goto-line-no
		      when ntf-changed
			set field-modified to true
		    end-evaluate
		end-evaluate
	    end-accept
	end-perform
	if field-modified
	    perform modify-field
	    perform display-field
	    set record-modified to true
	    call "W$MENU" using wmenu-enable, alfred-main-menu,
			menu-save-record
	end-if
	perform move-around
	perform calculate-line-and-col
	if terminate-field
	    perform goto-next-valid-line
	    perform calculate-line-and-col
	    set terminate-field to false
	end-if
	if redraw-screen
	    perform display-record
	end-if
    end-perform.
    set done to false.
    perform destroy-all-controls.

calc-and-display-offset.
    move xfd-field-offset to numeric-value.
    move ascii-value (7:2) to temp-3-asc-val (2:2).
    perform convert-bin-to-hex.
    move temp-area (1:4) to byte-offset.
    perform display-header-screen.

move-around.
    evaluate true
      when return-key
	perform goto-next-valid-line
      when up-arrow
	perform goto-previous-valid-line
      when tab-key
	if xfd-field-index >= max-xfd-field-index
	    perform goto-home
	else
	    perform goto-next-valid-line
	end-if
      when down-arrow
	perform goto-next-valid-line
      when exc-key = menu-previous-page
      when page-up
	perform goto-previous-valid-page
      when exc-key = menu-next-page
      when page-down
	perform goto-next-valid-page
      when home-key
	perform goto-home
      when end-key
	perform goto-end
      when about-key
	perform show-about-alfred
      when help-key
	perform show-main-menu-help
      when exc-key = menu-next-record
      when next-key
	perform test-record-modified
	perform read-next-record
	if file-error
	    perform no-current-record
	else
	    call "ParseXFD" using test-conditions-op
	end-if
      when exc-key = menu-previous-record
      when previous-key
	perform test-record-modified
	perform read-previous-record
	if file-error
	    perform no-current-record
	else
	    call "ParseXFD" using test-conditions-op
	end-if
      when exc-key = menu-exit
      when escape-key
	perform test-record-modified
	set done to true
      when event-happened
        compute xfd-field-index = xfd-field-index - line-no + goto-line-no + 1
        perform goto-previous-valid-line
      when exc-key = menu-open-input
	perform open-file-input
	if file-open-input
	    call "W$MENU" using wmenu-check, alfred-main-menu, menu-open-input
	    call "W$MENU" using wmenu-uncheck, alfred-main-menu, menu-open-io
	    perform show-main-menu
	    set view-mode to true
	    set need-field-info to true
	end-if
      when exc-key = menu-open-io
	perform open-file-io
	if file-open-io
	    call "W$MENU" using wmenu-uncheck, alfred-main-menu, menu-open-input
	    call "W$MENU" using wmenu-check, alfred-main-menu, menu-open-io
	    perform show-main-menu
	    set change-mode to true
	    set need-field-info to true
	end-if
      when exc-key = menu-open-file
      when exc-key = menu-reference-key
	move exc-key to save-exc-key
	perform test-record-modified
	set done to true
      when exc-key = menu-start-nlt
      when exc-key = menu-start-ngt
	move exc-key to save-exc-key
	perform test-record-modified
	move save-exc-key to exc-key
	perform start-file-nlt-or-ngt
	if not have-a-record
	    perform restore-position
	end-if
	call "ParseXFD" using test-conditions-op
      when exc-key = menu-start-first
	perform test-record-modified
	perform start-first-record
	call "ParseXFD" using test-conditions-op
      when exc-key = menu-start-last
	perform test-record-modified
	perform start-last-record
	call "ParseXFD" using test-conditions-op
      when exc-key = menu-add-record
	if file-open-input
	    perform open-mode-error
	else
	    perform test-record-modified
	    perform get-record-size
	    if record-size not = 0
		move low-values to init-value
		perform initialize-record
		perform get-one-key
		set add-mode to true
		set redraw-screen to true
	    end-if
	end-if
      when exc-key = menu-print
	perform print-record
      when exc-key = menu-delete-record
	if file-open-input
	    perform open-mode-error
	else
	    perform delete-record
	end-if
      when exc-key = menu-save-record
	if file-open-input
	    perform open-mode-error
	else
	    perform test-record-modified
	end-if
      when exc-key = menu-eval-conditions
	call "ParseXFD" using test-conditions-op
	set redraw-screen to true
      when other
	perform beep-user
    end-evaluate.

goto-previous-valid-line.
    set need-field-info to true.
    perform with test after until xfd-field-condition = 0 or
		true-condition or
		xfd-field-index <= min-xfd-field-index
	subtract 1 from xfd-field-index
	if xfd-field-index < 1
	    move xfd-total-number-fields to xfd-field-index
	end-if
	call "ParseXFD" using get-field-info-op
	if xfd-field-condition not = 0
	    move xfd-field-condition to xfd-cond-index
	    call "ParseXFD" using get-cond-info-op
	end-if
    end-perform.
    perform calculate-line-and-col.

goto-next-valid-line.
    set need-field-info to true.
    perform with test after until xfd-field-condition = 0 or
		true-condition or
		xfd-field-index >= max-xfd-field-index
	add 1 to xfd-field-index
	if xfd-field-index > max-xfd-field-index
	    move 1 to xfd-field-index
	end-if
	call "ParseXFD" using get-field-info-op
	if xfd-field-condition not = 0
	    move xfd-field-condition to xfd-cond-index
	    call "ParseXFD" using get-cond-info-op
	end-if
    end-perform.
    perform calculate-line-and-col.

goto-previous-valid-page.
    if xfd-field-index > full-page
	compute xfd-field-index = xfd-field-index - full-page + 1
    else
	move 1 to xfd-field-index
    end-if.
    perform goto-previous-valid-line.

goto-next-valid-page.
    compute xfd-field-index = xfd-field-index + full-page - 1.
    perform goto-next-valid-line.

goto-home.
    move min-xfd-field-index to xfd-field-index.
    set need-field-info to true.

goto-end.
    move max-xfd-field-index to xfd-field-index.
    set need-field-info to true.

calculate-line-and-col.
    set terminate-field to false.
    if xfd-field-index > xfd-total-number-fields
	move xfd-total-number-fields to xfd-field-index
    end-if.
    if xfd-field-index <= 0
	move 1 to xfd-field-index
    end-if.
    perform until xfd-field-index >= top-byte
	set redraw-screen to true
	subtract full-page from top-byte
    end-perform.
    perform until xfd-field-index < top-byte + full-page
	set redraw-screen to true
	add full-page to top-byte
    end-perform.
    compute line-no = xfd-field-index - top-byte + 1.

modify-field.
    move "C$RCONVERT" to convert-function.
    move "M$PUT" to get-put-fcn.
    set record-modified to true.
    if numeric-field or float-field
	if float-field
	    if xfd-field-length = 4
		move large-field to value-float convert
	    else
		move large-field to value-double convert
	    end-if
	end-if
	if numeric-field
	    move large-field to value-x80
	end-if
	perform convert-numeric-field
    else if national-field
	move large-field to large-nat-field convert
	compute temp-num = first-byte-in-group + 1
	call "M$PUT" using record-area-ptr, large-nat-field, field-size,
		temp-num
    else if wide-field
	move large-field to large-wide-field convert
	compute temp-num = first-byte-in-group + 1
	call "M$PUT" using record-area-ptr, large-wide-field, field-size,
		temp-num
    else
	compute temp-num = first-byte-in-group + 1
	call "M$PUT" using record-area-ptr, large-field, field-size, temp-num
    end-if.

***  What we're _really_ doing is getting an ASCII representation of the data
***  in the first few bytes of value-x80.
convert-numeric-field.
    if float-field
	add 1 to xfd-field-offset giving temp-num
	evaluate xfd-field-length
	  when 4
	    call get-put-fcn using record-area-ptr, value-float, 4, temp-num
	    modify entry-handles (line-no) value value-float
			max-text field-size
			size field-size
	  when 8
	    call get-put-fcn using record-area-ptr, value-double, 8, temp-num
	    modify entry-handles (line-no) value value-double
			max-text field-size
			size field-size
	  when other
	    stop unknown-size-error
	end-evaluate
    else
	call convert-function using value-x80, record-area-ptr,
		xfd-field-offset, xfd-field-length, xfd-field-type,
		xfd-field-digits, xfd-field-scale
	modify entry-handles( line-no ) value value-x80 max-text field-size
		size field-size numeric
    end-if.

help-screens section 90.
show-main-menu-help.
    display floating window color help-color
		lines 18 size 76 title main-menu-help-title
		cell size is label font std-font-handle
		system menu boxed handle help-window-handle no scroll.
    display main-menu-help-screen.
    accept main-menu-help-screen.
    close window help-window-handle.

show-enter-file-help.
    display floating window color help-color
		lines 7 size 45 title enter-file-help-title
		cell size is label font std-font-handle
		system menu boxed handle help-window-handle no scroll.
    display enter-file-help-screen.
    accept enter-file-help-screen.
    close window help-window-handle.

show-sort-key-help.
    display floating window color help-color
		lines 11 size 45 title sort-key-help-title
		cell size is label font std-font-handle
		system menu boxed handle help-window-handle no scroll.
    display sort-key-help-screen.
    accept sort-key-help-screen.
    close window help-window-handle.

show-enter-keymap-help.
    display floating window color help-color
		lines 16 size 76 title enter-keymap-help-title
		cell size is label font std-font-handle
		system menu boxed handle help-window-handle no scroll.
    display enter-keymap-help-screen.
    accept enter-keymap-help-screen.
    close window help-window-handle.

show-enter-key-no-xfd-help.
    display floating window color help-color
		lines 7 size 45 title enter-key-no-xfd-help-title
		cell size is label font std-font-handle
		system menu boxed handle help-window-handle no scroll.
    display enter-key-no-xfd-help-screen.
    accept enter-key-no-xfd-help-screen.
    close window help-window-handle.

show-enter-key-with-xfd-help.
    display floating window color help-color
		lines 8 size 45 title enter-key-with-xfd-help-title
		cell size is label font std-font-handle
		system menu boxed handle help-window-handle no scroll.
    display enter-key-with-xfd-help-screen.
    accept enter-key-with-xfd-help-screen.
    close window help-window-handle.

show-enter-recordsize-help.
    display floating window color help-color
		lines 7 size 45 title enter-recordsize-help-title
		cell size is label font std-font-handle
		system menu boxed handle help-window-handle no scroll.
    display enter-recordsize-help-screen.
    accept enter-recordsize-help-screen.
    close window help-window-handle.

show-logical-info-help.
    display floating window color help-color
		lines 11 size 45 title logical-info-help-title
		cell size is label font std-font-handle
		system menu boxed handle help-window-handle no scroll.
    display logical-info-help-screen.
    accept logical-info-help-screen.
    close window help-window-handle.

***  <EOF>
