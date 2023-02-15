identification division.
program-id.	readxml.
|-----------------------------------------------------------------------------|
| Copyright (c) 1989-2006 by Acucorp, Inc.   			              | 
| User of ACUCOBOL may freely use this file. 				      |
|-----------------------------------------------------------------------------|
|
|-----------------------------------------------------------------------------|
| This sample program illustrates a method of using the C$XML Library         |
| Routines (new in release 6.1) to retrieve information from an XML file.     |
| Please note that these Library routines are not intended to be used with    |
| large, "data transport" type XML files.  AcuXML is the preferred method of  |
| investigating those large files.  Examples of smaller XML files for which   |
| the C$XML Library Routines are well suited are initialization or            |
| configuration files.  .xfd files fall nicely into this catatory.            |	
|								              |	
| In this sample program, the user is presented with a screen that accepts    |
| the name of the XML file to be reported.  The information from the file is  |
| shown in a paged-list-box control, allowing the user to scroll up and down  |
| in the file.  One 'data item' is display per line.  If the 'data item' has  |
| any 'attributes', the literal "ATTRIBUTES:" is placed on the next line with |
| the attribute names and values on succeeding lines.                         | 
|-----------------------------------------------------------------------------|
environment division.

special-names.
	switch-1 on  status is sw-1-on.

input-output section.
|-----------------------------------------------------------------------------|
| Executing this program with Sense Switch 1 causes the data from the XML     |
| file to be dumped into the following line sequential file.                  |
|-----------------------------------------------------------------------------|
file-control.
	select the-file
	       assign to disk "readxml.txt"
	       organization is line sequential.
data division.

file section.

fd  the-file.
01  the-record					pic x(65).

working-storage section.

copy "def/acucobol.def".
copy "def/acugui.def".
|-----------------------------------------------------------------------------|
| This sample program makes some assumptions, which are represented in the    |
| following two 78 level items.                                               |
|                                                                             |
|	'max-element-depth' is the maximum level of nested 'children' in the  |
|            XML file  							      |
|	'max-table-depth'   is the maximum number of occurances in the table  |
|            that holds the XML data				 	      |		 
|                                                                             |
| Alter either if a particular XML file blows this program up.	              |	
|-----------------------------------------------------------------------------|
78  max-element-depth				value 10.
78  max-table-depth				value 2500.

77  list-box-lines				pic 99.
77  xml-filename				pic x(60).
77  xml-filehandle				usage handle.
77  x						pic 99.
77  finish-flag					pic x.
    88  done					value "y" false "n".

01  element-handles
	occurs max-element-depth times
	indexed by element-idx
						usage handle.

|-----------------------------------------------------------------------------|
| This table holds the information returned from the C$XML calls, so that the |
| paged-list-box can be supplied with data, scrolling in either direction.    |
|-----------------------------------------------------------------------------|
01  xml-whole-table.
    03  xml-table
	    occurs max-table-depth times
	    indexed by xml-idx.
    	05  xml-element-name			pic x(40).
    	05  xml-element-data			pic x(25).
        05  xml-element-data-len                pic 9(5).
77  used-table-depth				pic 9(5).

77  errors-visible				pic 9 value 0.
77  errors-storage				pic x(60).
77  errors-value				pic x(70) value spaces.
77  crt-status
    is special-names crt status			pic 999.
    88  user-quits				value 200.

01  screen-control
    is special-names screen control.
    03  accept-control				pic 9.
    03  control-value				pic 999.
    03  control-handle				         usage handle.
    03  control-id				pic xx   usage comp-x.
    
01  event-status
    is special-names event status.
    03  event-type				pic x(4) usage comp-x.
    03  event-window-handle			         usage handle.
    03  event-control-handle			         usage handle.
    03  event-control-id			pic x(2) usage comp-x.
    03  event-data-1				         usage signed-short.
    03  event-data-2				         usage signed-long.
    03  event-action				pic x    usage comp-x.

77  attribute-count				pic 99.
77  column-offset				pic 99 value 1.

77  state-flag					pic x.
    88  doing-forwards				value "f".
    88  doing-backwards				value "b".
    88  at-start				value "s".
    88  at-end					value "e".

screen section.
01  the-screen.
    03  graphical.
	05  label
		title "File Name:"
		line 1.5 col 1.
	05  screen-filename
	    	entry-field
		3-d
		auto
		use-return
		using xml-filename
		after procedure parse-and-display
		line 1.5 col 9
		size 60
		lines 1.
	05  screen-quitbutton
		push-button
		title "Quit"
		self-act
		termination-value = 200
		line 1.5 col 66.
	05  screen-listbox
		list-box
		paged
		3-d
		unsorted
		data-columns    = (1,41,66)
		display-columns = (1,42,83)
		dividers	= 1
		exception procedure is listbox-handler
		line 4 col 1
		size 90
		lines 23.
	05  screen-errors
		label
		line 24.5 col 1
		title = errors-value
		size 70
		lines 1
		visible = errors-visible.
	05  screen-continuebutton
		push-button
		title "Continue"
		self-act
		line 24.5 col 66
		visible = errors-visible.

    03  character.
        05  label
                title "File Name:"
                line 1 col 1.
        05  screen-filename
                entry-field
                auto
		use-return
                using xml-filename
                after procedure parse-and-display
                line 1 col 10
                size 50
                lines 1.
        05  screen-quitbutton
                push-button
                title "Quit"
                self-act
                termination-value = 200
                line 1 col 66.
        05  screen-listbox
                list-box
                paged
                unsorted
                data-columns    = (1,41,66)
                display-columns = (1,42,67)
                exception procedure is listbox-handler
                line 3 col 1
                size 72
                lines 19.
        05  screen-errors
                label
                line 24 col 1
                title = errors-value
                size 70
                lines 1
                visible = errors-visible.
        05  screen-continuebutton
                push-button
                title "Continue"
                self-act
                line 24 col 66
                visible = errors-visible.

procedure division.
main-paragraph.
	display standard window
		title-bar
		system menu
		auto-minimize
		auto-resize
		background-low.

	perform until user-quits
		display the-screen 
		accept  the-screen 
	end-perform.

	stop run.

parse-and-display.

	|---------------------------------------------------------------------|
	| The heavy lifting starts here.  This routine is the "after          |
        | procedure" for the entry-field where a user indicates the XML file  |
	| name.		  		 				      | 
	|							              |	
	| Call CXML-PARSE-FILE for the file indicated by the user, them make  |
	| one pass each for:					              |	
	|	geting and displaying data				      |
	|	geting and displaying attributes			      |
	|	geting and displaying children (which will ripple through the |
	|           entire xml file) 					      | 
	|								      |
	| loading all the xml data into the internal table.  Call             |
	| XCML-RELEASE-PARSER to "close" the xml file.		              |	
	|---------------------------------------------------------------------|
	call "C$XML" using
		CXML-PARSE-FILE
		xml-filename.

	if return-code not positive
		perform show-error
		exit paragraph. 

	set element-idx
	    xml-idx to 1.

	move return-code to element-handles (element-idx).
	
	move spaces to xml-whole-table.

	perform get-and-display-data.
	perform get-and-display-attributes.
	perform get-and-display-children.

	call "C$XML" using
		CXML-RELEASE-PARSER
		element-handles (element-idx).

	set used-table-depth to xml-idx.
	subtract 1 from used-table-depth.
	|---------------------------------------------------------------------|
	| If the user executed the program with -1, dump the tabled data to a |
	| line sequential file and bail.			              |	
	|---------------------------------------------------------------------|
	if sw-1-on
		open output the-file
		perform varying xml-idx from 1 by 1 
			until xml-idx greater used-table-depth
				write the-record from xml-table (xml-idx)
		end-perform
		close the-file
		stop run.
	|---------------------------------------------------------------------|
	| The user wants to see the data on the screen, so load up            |
	| 'list-box-lines' worth of the tabled data into the paged-list-box,  |
	| then let the list-box exception procedure handle them scrolling     |
	| around in the data. 				                      |
	|---------------------------------------------------------------------|
 	destroy screen-listbox.
	display screen-listbox.
	
	inquire screen-listbox lines in list-box-lines.

	set doing-forwards to true.

	modify screen-listbox mass-update = 1.
	perform varying xml-idx from 1 by 1 
		until xml-idx greater list-box-lines
			modify screen-listbox item-to-add = xml-table (xml-idx)
	end-perform.
	modify screen-listbox mass-update = 0.

	display screen-listbox.

get-and-display-data.							

	|---------------------------------------------------------------------|
	| This routine gets an XML 'data item'				      |
	|---------------------------------------------------------------------|
	call "C$XML" using
		CXML-GET-DATA
		element-handles (element-idx)
 	 	xml-element-name (xml-idx)
  		xml-element-data (xml-idx)
  		xml-element-data-len (xml-idx).

	perform up-idx.
	
get-and-display-attributes.

	|---------------------------------------------------------------------|
	| This routines examines the XML 'data item' for 'attributes'.  If    |
	| any are found, they are reported (offset 4 spaces) under the        |
	| heading "ATTRIBUTES:".	  	                              |
	|---------------------------------------------------------------------|
	call "C$XML" using
		CXML-GET-ATTRIBUTE-COUNT
		element-handles (element-idx).

	if return-code not positive
		exit paragraph.

	move return-code to attribute-count.

	move "ATTRIBUTES:" to xml-element-name (xml-idx) (column-offset:)
	perform up-idx.

	add 4 to column-offset.

	perform varying x from 1 by 1 until x greater attribute-count
		call "C$XML" using
			CXML-GET-ATTRIBUTE
			element-handles (element-idx)
			x
			xml-element-name (xml-idx) (column-offset:)
			xml-element-data (xml-idx)
			xml-element-data-len (xml-idx)
		end-call
		perform up-idx
	end-perform.
	subtract 4 from column-offset.

get-and-display-children.

	|---------------------------------------------------------------------|
	| This routine is used recursively, since XML files tend to be so.    |
	| We get the first child, report it's data and attributes, then do    |
	| the same with all it's siblings.			              |	
	|---------------------------------------------------------------------|
	call "C$XML" using
		CXML-GET-FIRST-CHILD
		element-handles (element-idx).

	if return-code not positive 
		exit paragraph.

        if  element-idx = max-element-depth
                move "element table exceeded - we be toast" to errors-value
		move 1 to errors-visible
                display screen-errors
                display screen-continuebutton
                accept  screen-continuebutton
                stop run.

	set element-idx up by 1.
	move return-code to element-handles (element-idx).

	perform get-and-display-data.
	perform get-and-display-attributes.
	perform get-and-display-children.

	set done to false.
	perform until done
		call "C$XML" using
			CXML-GET-NEXT-SIBLING
			element-handles (element-idx)
		end-call
		if return-code positive
			move return-code to element-handles (element-idx)
			perform get-and-display-data
			perform get-and-display-attributes
			perform get-and-display-children
		else
			set done to true
		end-if
	end-perform.

 	set done to false.
	set element-idx down by 1.
	
show-error.

	|---------------------------------------------------------------------|
	| Report errors by putting text in the title of a label, which is     |
	| then made visible, along with a push-button to continue.            |	
	|---------------------------------------------------------------------|
	call "C$XML" using
		CXML-GET-LAST-ERROR
		errors-storage.

	move "Err No:"   to errors-value(1:).
	move return-code to errors-value(9:).
	move errors-storage to errors-value(20:).
	move 1 to errors-visible.

	display screen-errors.
	display screen-continuebutton.
	accept  screen-continuebutton.

	move 0 to errors-visible.
	display the-screen.

up-idx.

	|---------------------------------------------------------------------|
	| up the index that controls the internal table which holds the XML   |
	| data.  Insure that we don't exceed the table size.	              |	
	|---------------------------------------------------------------------|
	set xml-idx up by 1.
	if  xml-idx greater max-table-depth
		move "xml-table size exceeded - we be toast" to errors-value
		move 1 to errors-visible
		display screen-errors
		display screen-continuebutton
		accept  screen-continuebutton
		stop run.

listbox-handler.

	|---------------------------------------------------------------------|
	| The rest of the program is a variation of the paged-list-box model. |
	| It differs from the model in that the data for the control comes    |
	| from an internal table rather than a Vision file.	              |	
	|---------------------------------------------------------------------|
	if crt-status = w-event
		evaluate event-type
		    when ntf-pl-next
			perform get-next-item
		    when ntf-pl-prev
			perform get-prev-item
		    when ntf-pl-nextpage
			modify screen-listbox mass-update = 1
			perform get-next-item list-box-lines times
			modify screen-listbox mass-update = 0
		    when ntf-pl-prevpage
			modify screen-listbox mass-update = 1
			perform get-prev-item list-box-lines times
			modify screen-listbox mass-update = 0
		    when ntf-pl-first
			set xml-idx to 1
			set doing-forwards to true
			modify screen-listbox mass-update = 1
			perform get-next-item list-box-lines times
			modify screen-listbox mass-update = 0
		    when ntf-pl-last
			set xml-idx to used-table-depth
			set doing-backwards to true
			modify screen-listbox mass-update = 1
			perform get-prev-item list-box-lines times
			modify screen-listbox mass-update = 0
		end-evaluate
	end-if.
	|---------------------------------------------------------------------|
	| keep the user in the list-box control.  They can select the         |
	| entry-field if they want to see another file.		              |	
	|---------------------------------------------------------------------|
	move 1     to accept-control.
	move zeros to control-value.

get-next-item.
	evaluate true
		when at-start
		    set xml-idx to list-box-lines 
		    set xml-idx up by 1
		when at-end
		    exit paragraph
		when doing-backwards
		    set xml-idx up by list-box-lines
		    set xml-idx up by 1
		when doing-forwards
		    set xml-idx up by 1
	end-evaluate.

	set doing-forwards to true.

	if xml-idx greater used-table-depth
		set xml-idx to used-table-depth
		set at-end  to true
		exit paragraph.
		
	modify screen-listbox 
		insertion-index = list-box-lines + 1
		item-to-add = xml-table (xml-idx).

get-prev-item.
	evaluate true
		when at-end
		    set xml-idx to used-table-depth 
		    set xml-idx down by list-box-lines
		    set xml-idx down by 1
		when at-start
		    exit paragraph
		when doing-forwards
		    set xml-idx down by list-box-lines
		    set xml-idx down by 1
		when doing-backwards
		    set xml-idx down by 1
	end-evaluate.


	set doing-backwards to true.

 	if xml-idx less 1
 		set xml-idx to 1
		set at-start to true
 		exit paragraph.

	modify screen-listbox 
		insertion-index = 1
		item-to-add = xml-table (xml-idx).

