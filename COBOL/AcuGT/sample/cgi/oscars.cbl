identification division.
program-id. oscars.
author.    mje.
remarks.
     This program uses a new ACUCOBOL-GT feature that allows you
     to accept and display "external forms". You can accept information
     from the client via the webserver in the form of an HTML FORM and
     display HTML external forms to standard output that can be read by
     web servers and sent back to the client.

data division.
working-storage section.
***
*** format to accept HTML FORM data *******
***
01  cgi-form	is external-form.
     05 y1996      pic x(5) is identified by "y1996".
     05 y1995      pic x(5) is identified by "y1995".
     05 y1994      pic x(5) is identified by "y1994".
     05 y1993      pic x(5) is identified by "y1993".
     05 y1992      pic x(5) is identified by "y1992".
     05 y1991      pic x(5) is identified by "y1991".
     05 y1990      pic x(5) is identified by "y1990".
     05 y1989      pic x(5) is identified by "y1989".
     05 y1988      pic x(5) is identified by "y1988".
     05 y1987      pic x(5) is identified by "y1987".
     05 y1986      pic x(5) is identified by "y1986".
     05 y1985      pic x(5) is identified by "y1985".

01  cgi-form-table redefines cgi-form.
	05  cgi-year pic x(5) occurs 12 times.
***
*** data to be sent to header.html when html-head-form is displayed ***
***
01  html-header-form is external-form identified by "header".
	05  opening-message	pic x(40).
***
*** data to be sent to body.html when html-body-form is displayed ***
***
01  html-body-form is external-form identified by "body".
	05  ryear		pic x(5).
	05  html-oscar-info.
	    10  rmovie		pic x(25).
	    10  ractor		pic x(42).
	    10  ractress	pic x(42).
***
*** data to be sent to footer.html when html-footer-form is displayed **
***
01  html-footer-form is external-form identified by "footer".
	05  closing-message	pic x(40).
***
*** movie data being queryed by client **
***
01  movie-values.
    05  1996-oscar.
	    10 movie	pic x(25) value "THE ENGLISH PATIENT".
	    10 actor	pic x(42) value "Geofrey Rush SHINE".
	    10 actress	pic x(42) value "Frances McDormand FARGO".
    05  1995-oscar.
	    10 movie	pic x(25) value "BRAVEHEART".
	    10 actor	pic x(42) value "Nicolas Gage  LEAVING LAS VEGAS".
	    10 actress	pic x(42) value "Susan Sarandon DEAD MAN WALKING".
    05  1994-oscar.
	    10 movie	pic x(25) value "FORREST GUMP".
	    10 actor	pic x(42) value "Tom Hanks FORREST GUMP".
	    10 actress	pic x(42) value "Jessica Lange BLUE SKY".
    05  1993-oscar.
	    10 movie	pic x(25) value "SCHINDLERS'S LIST".
	    10 actor	pic x(42) value "Tom Hanks PHILIDELPHIA".
	    10 actress	pic x(42) value "Holly Hunter THE PIANO".
    05  1992-oscar.
	    10 movie	pic x(25) value "UNFORGIVEN".
	    10 actor	pic x(42) value "Al Pacino SCENT OF A WOMAN".
	    10 actress	pic x(42) value "Emma Thompson HOWARDS END".
    05  1991-oscar.
	    10 movie	pic x(25) value "THE SILENCE OF THE LAMBS".
	    10 actor	pic x(42) value
                                  "Anthony Hopkins THE SILENCE OF THE LAMBS".
	    10 actress	pic x(42) value "Jodie Foster THE SILENCE OF THE LAMBS".
    05  1990-oscar.
	    10 movie	pic x(25) value "DANCES WITH WOLVES".
	    10 actor	pic x(42) value "Jeremy Irons REVERSAL OF FORTUNE".
	    10 actress	pic x(42) value "Kathy Bates MISERY".
    05  1989-oscar.
	    10 movie	pic x(25) value "DRIVING MISS DAISY".
	    10 actor	pic x(42) value "Daniel Day-Lewis MY LEFT FOOT".
	    10 actress	pic x(42) value "Jessica Tandy DRIVING MISS DAISY".
    05  1988-oscar.
	    10 movie	pic x(25) value "RAIN MAN".
	    10 actor	pic x(42) value "Dustin Hoffman RAIN MAIN".
	    10 actress	pic x(42) value "Jodie Foster THE ACCUSED".
    05  1987-oscar.
	    10 movie	pic x(25) value "THE LAST EMPEROR".
	    10 actor	pic x(42) value "Michael Douglas WALL STREET".
	    10 actress	pic x(42) value "Cher MOONSTRUCK".
    05  1986-oscar.
	    10 movie	pic x(25) value "PLATOON".
	    10 actor	pic x(42) value "Paul Newman THE COLOR OF MONEY".
	    10 actress	pic x(42) value
                                  "Marlin Matlin CHILDREN OF A LESSER GOD".
    05  1985-oscar.
	    10 movie	pic x(25) value "OUT OF AFRICA".
	    10 actor	pic x(42) value "Willian Hurt KISS OF THE SPIDER WOMAN".
	    10 actress	pic x(42) value "Geraldine Page THE TRIP TO BOUNTIFUL".

01  movie-table redefines movie-values occurs 12 times.
	05  oscar-winners.
		10  best-movie		    pic x(25).
		10  best-actor 		    pic x(42).
		10  best-actress		pic x(42).

01  various-counters.
	05 idx-1 			pic 99 value 1.

procedure division.
main-logic.
*** get HTML FORM data from web server ***
	accept cgi-form.
*** if blank, user did not make any selections ***
	if cgi-form = space
		move "You did not select any years!" to opening-message
		display html-header-form
		move "Back up and try again." to closing-message
	else
		move "ACUCOBOL CGI in action." to opening-message
		display html-header-form
		perform display-body-para
		move "THE END." to closing-message
	end-if.
	display html-footer-form.
	stop run.

display-body-para.
*** send information back on every item selected ****
	perform varying idx-1 from 1 by 1 until idx-1 > 12
		if cgi-year(idx-1) = space
			continue
		else
			move cgi-year(idx-1) to ryear
			move movie-table(idx-1) to html-oscar-info
			display html-body-form
		end-if
	end-perform.
