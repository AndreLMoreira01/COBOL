To see ACUCOBOL-GT(R) and CGI in action, you first need to get your Web
server up and running and have "oscars.html" available to client browser
as your home page or create a link to "oscars.html" from your home page.

"Oscars.html" contains an HTML form and allows users to fill out and submit
the form to the Web server.  Clicking on the submit button initiates the
"oscars.acu" ACUCOBOL-GT program on the server.  For this to happen you must
have "oscars.acu" in your CGI or Script directory, depending on which Web
server you are using. You also must edit "oscars.html" and make the
appropriate changes to the action keyword of the FORM tag.

For example, if your server name is "www.mycompany.com" and your Web server
is configured to map "cgi-bin" to the directory containing "oscars.acu", then
you would change the following line,

<FORM method="post" action="http://your_server_name/Scripts/oscars.acu">

to

<FORM method="post" action="http://www.mycompany.com/cgi-bin/oscars.acu">


You also need to have the Web server automatically start up the ACUCOBOL-GT
runtime to execute CGI programs that end with the "acu" extension. The way
this association is made varies from Web server to Web server.

On Windows NT, for example, you have to set the following registry entry:

        \HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\w3SVC\
        Parameters\Script Map

and associate the ".acu" extension with "C:\InetPub\cobol\wrun32.exe -f %s"

On UNIX, you might want to point to "oscars.sh" instead of "oscars.acu",
where "oscars.sh" is a shell script that invokes "oscars.acu".  For example

#!/bin/sh
A_TERM=vt100
export A_TERM
runcbl oscars.acu

"Oscars.acu" accepts the HTML form from standard input and uses the
"header.html", "body.html", and "footer.html" templates to display,
through standard output, the HTML code back to the user's browser.

