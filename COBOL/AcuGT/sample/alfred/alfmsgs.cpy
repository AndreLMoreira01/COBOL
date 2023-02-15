*  All displayed messages and strings are in this copy file.
*  In order to localize alfred, just modify this file and
*  recompile.  It is left as an exercise for the reader how
*  to get multiple languages to display without recompiling...

*  RCS INFO: $Id: alfmsgs.cpy 38925 2004-09-13 21:22:47Z merge $

01  common-messages.
    03  error-title		pic x(6) value "Error!".
    03  warning-title		pic x(8) value "Warning!".
    03  file-selector-title	pic x(20) value "File Selector".
    03  all-files-filter	pic x(15) value "All files (*)|*".
    03  data-files-filter	pic x(10) value "Data files".
    03  xfd-files-filter	pic x(23) value "XFD files (*.xfd)|*.xfd".
    03  key-map-title		pic x(40) value "Enter a key map".
    03  key-map-header-1	pic x(10) value "Seg".
    03  key-map-header-2	pic x(10) value "Bytes".
    03  key-map-header-3	pic x(20) value "Keymap".
    03  btn-line		pic 99.
    03  file-error-messages.
	05  pic x(80) value
		"System error".
	05  pic x(80) value
		"Parameter error".
	05  pic x(80) value
		"Too many files open".
	05  pic x(80) value
		"Invalid operation for open mode".
	05  pic x(80) value
		"Record locked".
	05  pic x(80) value
		"File is broken, extended error is".
	05  pic x(80) value
		"Duplicate key".
	05  pic x(80) value
		"Record not found".
	05  pic x(80) value
		"No current record".
	05  pic x(80) value
		"Disk full".
	05  pic x(80) value
		"File locked by another user".
	05  pic x(80) value
		"Record size changed".
	05  pic x(80) value
		" is probably not an indexed file".
	05  pic x(80) value
		"Inadequate memory for operation".
	05  pic x(80) value
		"File not found".
	05  pic x(80) value
		"User does not have permissions for the file".
	05  pic x(80) value
		"File system does not support requested operation".
	05  pic x(80) value
		"No more locks available".
	05  pic x(80) value
		"Interface error".
	05  pic x(80) value
		"Licensing error".
	05  pic x(80) value
		"Unknown error".
    03  file-error-array redefines file-error-messages
		pic x(80) occurs 21 times.
    03  file-warning-messages.
	05  pic x(80) value
		"Unsupported operation attempted".
	05  pic x(80) value
		"Duplicates found and allowed".
    03  file-warning-array redefines file-warning-messages
		pic x(80) occurs 2 times.
    03  filename-title-group.
	05  filename-title	pic x(40) value "Filename:".
	05  filename-title-size	pic 99.
	05  filename-entry-col	pic 99.
	05  filename-entry-size	pic 99.
    03  xfdname-title		pic x(40) value "XFD file:".
    03  help-title		pic x(10) value "Help".
    03  browse-title		pic x(10) value "&Browse".
    03  logical-title		pic x(70) value
		"Enter the logical parameters of the file".
    03  max-rec-size-prompt	pic x(45) value
		"Maximum record size:".
    03  min-rec-size-prompt	pic x(45) value
		"Minimum record size:".
    03  num-keys-prompt		pic x(45) value
		"Number of keys:".
    03  new-record-size-title	pic x(45) value
		"Enter the size of this new record".
    03  new-record-size-message	pic x(12) value "Record size:".
    03  write-record-prompt	pic x(40) value "Write this record?".
    03  delete-record-prompt	pic x(40) value "Delete this record?".
    03  new-file-title		pic x(70) value
		"Enter the name of a file (and XFD file, if available) to edit".
    03  enter-key-title		pic x(70) value "Enter a key".
    03  access-key-group.
	05  key-num-msg		pic x(32) value
		"  Key Dup? Offset Len Field-Name".
	05  key-num-xfd-msg	pic x(76) value
		"  Key Dup? Offset Len Offset Len Offset Len Offset Len Offset
-		" Len Offset Len".
	05  access-key-title.
	    07  filler pic x(17) value "Key information: ".
	    07  access-key-num-keys pic zz9.
	    07  filler pic x(5) value " keys".
    03  seg-value-message	pic x(10) value "Seg  Value".
    03  header-frame-group.
	05  header-frame-col	pic 99	value 48.
	05  header-frame-lines	pic 99.
	05  header-frame-size	pic 99	value 25.
    03  key-prompt-group.
	05  key-prompt		pic x(10) value "Key:".
	05  key-prompt-size	pic 99.
	05  key-prompt-col	pic 99	value 50.
	05  key-msg-col		pic 99.
    03  mode-prompt-group.
	05  mode-prompt		pic x(10) value "Mode:".
	05  input-string	pic x(10) value "INPUT".
	05  io-string		pic x(10) value "I/O".
	05  access-mode		pic x(10).
	05  access-mode-size	pic 99	value 7.
    03  byte-offset-group.
	05  byte-offset-msg	pic x(13) value "Byte offset:".
	05  byte-offset		pic x(4).
	05  offset-visible	pic 9	value 0.
    03  return-f1-f10-message	pic x(80) value
		"<RETURN> to continue, <F1> to cancel, <F10> for help".
    03  alpha-num-string-msg	pic x(80) value
		"Enter an alpha-numeric string".
    03  decimal-range-msg	pic x(80) value
		"Enter a number between 0 and".
    03  octal-value-msg		pic x(80) value
		"Enter an Octal value".
    03  hex-value-msg		pic x(80) value
		"Enter a Hexadecimal value".
    03  parse-error-message	pic x(40) value
		"Error reading or parsing the XFD file".
    03  create-new-file-message	pic x(100) value
		"Would you like to create a new indexed file based
-		" on the information in the XFD file?".
    03  file-open-mode-message	pic x(40) value
		"File is not open for writing!".
    03  undo-alloc-message	pic x(40) value
		"Unable to allocate memory for undo".
    03  keyboard-stack-full	pic x(100) value
		"The keyboard stack is full. Your keyboard will
-		" be modified if you continue.  Please exit now.".
    03  permission-message	pic x(100) value
		"You do not have access permissions required for
-		" this program. Check with your system administrator.".
    03  debug-title		pic x(5) value "Debug".
    03  debug-line-col-nums-message.
	05  pic x(10) value "line-no = ".
	05  debug-disp-line	pic --9.
	05  pic x(9) value "col-no = ".
	05  debug-disp-col	pic --9.
    03  no-more-undo-message	pic x(40) value
		"No further undo information".
    03  unknown-data-message	pic x(40) value
		"Unknown data type for this data item!".
    03  unknown-size-error	pic x(40) value
		"Unknown size for float data".
    03  main-menu-help-title	pic x(14) value
		"Main menu help".
    03  main-menu-help-text-values.
	05  pic x(80) value "This is the main menu of Alfred.".
	05  pic x(80) value "Selections that do not make sense are not available to be chosen.".
	05  pic x(80).
	05  pic x(80) value "Under the ""File"" menu:".
	05  pic x(80) value """Name File"" determines which file Alfred will edit.".
	05  pic x(80) value """Which Key"" determines which key to display and sort by.".
	05  pic x(80) value """Open I/O"" allows modifications to records.".
	05  pic x(80) value """Open Input"" accesses the file read-only (this is the default).".
	05  pic x(80) value """Exit"" exits Alfred.".
	05  pic x(80).
	05  pic x(80) value "Under the ""Edit"" menu:".
	05  pic x(80) value """Undo"" will undo the latest change made to the record since it was".
	05  pic x(80) value "read (or saved).  Repeatedly choosing this will undo multiple".
	05  pic x(80) value "modifications.".
	05  pic x(80).
	05  pic x(80) value "Under the ""Start"" menu:".
	05  pic x(80) value """Not Less Than"" allows you to enter a key.  Alfred will do a".
	05  pic x(80) value "start not less than on the file, based on the entered key.".
	05  pic x(80) value """Not Greater Than"" starts not greater than the entered key.".
	05  pic x(80) value """First Record"" will get the first record of the file.".
	05  pic x(80) value """Last Record"" will get the last record of the file.".
	05  pic x(80).
	05  pic x(80) value "Under the ""Record"" menu:".
	05  pic x(80) value """Add a New Record"" will allow you to add a new record to the file.".
	05  pic x(80) value "If the file being edited is a variable-length record file, you will".
	05  pic x(80) value "be asked for record size for this record.".
	05  pic x(80) value """Delete This Record"" will delete the currently displayed record.".
	05  pic x(80) value """Save This Record"" will write or rewrite the currently displayed record.".
	05  pic x(80) value """Next Record"" will read the next record from the file, and display it.".
	05  pic x(80) value "If the currently displayed record has been changed since it was read,".
	05  pic x(80) value "you will be asked whether you want to save the record first.".
	05  pic x(80) value """Previous Record"" is like Next Record, but gets the previous record".
	05  pic x(80) value "instead of the next record.".
	05  pic x(80).
	05  pic x(80) value "Under the ""Display"" menu:".
	05  pic x(80) value """Hexadecimal"" shows the binary part of the record in hex.  This is".
	05  pic x(80) value "valid only for editing without an XFD file.".
	05  pic x(80) value """Octal"" shows the binary part of the record in octal.  This is".
	05  pic x(80) value "valid only for editing without an XFD file.".
	05  pic x(80) value """ASCII Area"" and ""Raw Data Area"" toggle which mode editing is done in.".
	05  pic x(80) value "This is valid only for editing without an XFD file.".
	05  pic x(80) value """Evaluate Conditions"" will cause Alfred to evaluate any conditions".
	05  pic x(80) value "on this record.  This may cause data to be redisplayed differently.".
	05  pic x(80) value "This is valid only for editing with an XFD file.".
	05  pic x(80) value """Next Page"" and ""Previous Page"" will display the next and previous".
	05  pic x(80) value "block of data, depending on how much will display on one screen.".
    03  main-menu-help-text
		redefines main-menu-help-text-values.
	05  main-menu-help-text-table
		occurs 46 times	pic x(80).

    03  enter-file-help-title	pic x(20) value
		"Enter a file to edit".
    03  enter-file-help-text-values.
	05  pic x(80) value "Alfred is asking you for a file to edit.".
	05  pic x(80) value "Enter a filename, and optionally an XFD".
	05  pic x(80) value "file.  Select Continue when you are done,".
	05  pic x(80) value "or Exit to exit Alfred.".
    03  enter-file-help-text
		redefines enter-file-help-text-values.
	05  enter-file-help-text-table
		occurs 4 times	pic x(80).

    03  sort-key-help-title	pic x(21) value
		"Pick a key to sort by".
    03  sort-key-help-text-values.
	05  pic x(80) value "Alfred wants to know which key you want to".
	05  pic x(80) value "use when getting the first, last, next or".
	05  pic x(80) value "previous record.  The arrow keys will change".
	05  pic x(80) value "which key is highlighted, as will the mouse".
	05  pic x(80) value "(if it is available).  Press <Return>, or".
	05  pic x(80) value "the OK button, when the desired key is".
	05  pic x(80) value "highlighted.  Press the Cancel button to".
	05  pic x(80) value "pick a different file.".
    03  sort-key-help-text
		redefines sort-key-help-text-values.
	05  sort-key-help-text-table
		occurs 8 times	pic x(80).

    03  enter-keymap-help-title	pic x(16) value "Entering keymaps".
    03  enter-keymap-help-text-values.
	05  pic x(80) value "Alfred wants to know how to display and accept the key you chose.  If the".
	05  pic x(80) value "key is entirely display-type data (numeric or alpha), then enter an A for".
	05  pic x(80) value "each byte of the segment. If there is binary data (some comp type), then".
	05  pic x(80) value "enter an 'X' to enter and see it as hexadecimal, an 'O' to enter and see".
	05  pic x(80) value "it as octal, or a 'D' to enter and see it as decimal.  You can mix and".
	05  pic x(80) value "match the types, but you must enter as many non-space characters as the".
	05  pic x(80) value "number in the Bytes column for that segment.".
	05  pic x(80).
	05  pic x(80) value "You can also enter and see logical segments, if your key is made up of".
	05  pic x(80) value "more than one field.  Put a space between the maps of logical segments.".
	05  pic x(80) value "For example, if you have a 7 byte key, entirely display data, the first 3".
	05  pic x(80) value "bytes are one field, and the last 4 bytes are another field, you might".
	05  pic x(80) value "enter 'AAA AAAA' as the keymap for that segment.".
    03  enter-keymap-help-text
		redefines enter-keymap-help-text-values.
	05  enter-keymap-help-text-table
		occurs 13 times	pic x(80).

    03  enter-key-no-xfd-help-title	pic x(28) value
		"Entering keys without an XFD".
    03  enter-key-no-xfd-help-text-values.
	05  pic x(80) value "Alfred is asking you for a key.  Depending".
	05  pic x(80) value "on the keymap you entered, you should".
	05  pic x(80) value "enter a string, or a hexadecimal, octal or".
	05  pic x(80) value "decimal number.  Ranges are given.".
    03  enter-key-no-xfd-help-text
		redefines enter-key-no-xfd-help-text-values.
	05  enter-key-no-xfd-help-text-table
		occurs 4 times	pic x(80).

    03  enter-key-with-xfd-help-title	pic x(25) value
		"Entering keys with an XFD".
    03  enter-key-with-xfd-help-text-values.
	05  pic x(80) value "Alfred is asking you for a key.  Since you".
	05  pic x(80) value "are editing with an XFD file, Alfred knows".
	05  pic x(80) value "what type of data is expected for this".
	05  pic x(80) value "part of the key.  Enter the data for this".
	05  pic x(80) value "field.".
    03  enter-key-with-xfd-help-text
		redefines enter-key-with-xfd-help-text-values.
	05  enter-key-with-xfd-help-text-table
		occurs 5 times	pic x(80).

    03  enter-recordsize-help-title	pic x(19) value
		"Enter a record size".
    03  enter-recordsize-help-text-values.
	05  pic x(80) value "The file that is being edited has records".
	05  pic x(80) value "of different sizes.  Before you can add a".
	05  pic x(80) value "new record, we need to know how many bytes".
	05  pic x(80) value "the record contains.".
    03  enter-recordsize-help-text
		redefines enter-recordsize-help-text-values.
	05  enter-recordsize-help-text-table
		occurs 4 times	pic x(80).

    03  logical-info-help-title	pic x(24) value
		"Need logical information".
    03  logical-info-help-text-values.
	05  pic x(80) value "The file system interface can not determine".
	05  pic x(80) value "the logical information for this file.".
	05  pic x(80) value "Please enter the maximum record size, the".
	05  pic x(80) value "minimum record size, and the number of".
	05  pic x(80) value "keys.  If you enter this information".
	05  pic x(80) value "incorrectly, you could crash this program,".
	05  pic x(80) value "so please only do this if you are sure".
	05  pic x(80) value "that you have the correct information.".
    03  logical-info-help-text
		redefines logical-info-help-text-values.
	05  logical-info-help-text-table
		occurs 8 times	pic x(80).

