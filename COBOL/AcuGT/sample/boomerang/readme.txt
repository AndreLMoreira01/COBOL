
BOOMERANG SAMPLE PROGRAM
------------------------
------------------------

The Boomerang utility sample program demonstrates how you can 
use ACUCOBOL-GT, AcuConnect in thin client mode, AcuServer, 
and Oracle Pro*COBOL to maintain a relational database like 
Oracle on a UNIX server; pre-compile ESQL source files on 
that server; and then execute these programs on the server.  
Oracle Pro*COBOL is a pre-compiler that enables you to embed 
SQL statements in a host COBOL program and use that program 
to access an Oracle database.  The pre-compiler accepts the 
host COBOL program as input; translates the embedded SQL 
statements into standard COBOL CALL statements that call 
the Oracle libraries; and generates a source program that 
you can compile, link, and execute in the usual way.

When properly configured, the Boomerang utility sends the 
source file for pre-compilation to the UNIX server using 
AcuServer.  Using AcuConnect, it executes a script that 
starts the pre-compilation process.  The pre-compiled 
program returns to the client via AcuServer.  Finally, 
Boomerang compiles the program locally and sends the 
resulting object file to a specified directory on the 
client or server.

------------------------------------------------------------
Please note that Boomerang is not a supported ACUCOBOL-GT 
feature.  If you have any questions about the use of this 
utility, please contact our Systems Engineering department 
or your Acucorp Sales Professional.
------------------------------------------------------------

SYSTEM REQUIREMENTS
-------------------

In addition to the contents of the "boomerang" sample 
program file, the following system requirements must 
be met before you can run the utility.

You need the following components on the Windows client 
machine:

ACUCOBOL-GT development system (compiler and runtime) 
Version 7.0
ACUCOBOL-GT Thin Client Version 7.0
gzip utility version 1.2.4

You need the following components on the UNIX server 
machine:

ACUCOBOL-GT runtime Version 7.0
AcuServer Version 7.0
AcuConnect Version 7.0
gzip utility version 1.2.4
Oracle Pro*COBOL versions 9, 9i, or 10g

The gzip utility is not included with the Boomerang sample.  
It may be downloaded from www.gzip.org.  

PROGRAM SETUP
-------------

The "boomerang" directory contains the files you need to 
install before you can run the sample program.  The "server" 
directory contains a copy of the files you need for the server, 
and the "client" directory contains the files that should be 
placed on the client.  The following paragraphs briefly 
describe these files, along with any modifications you need 
to make to them in order to run Boomerang on your system.  

Server files 
------------

The "server" directory should be copied to the UNIX server 
machine.  You also need to create a "tmp" directory for 
temporary files and an "obj" directory to receive your 
COBOL object files.  Some files in the "server" directory 
need to be modified based on your individual implementation.  

The "acutools.cfg" file contains configuration file 
entries for AcuConnect and AcuServer.  ACCESS_FILE 
should point to the location of the AcuAccess file, and 
SERVER_ALIAS_FILE should contain the location of the 
thin client server alias file.

The script in "buildserver.sh" is used to compile the 
Boomerang utility "pcompile.cbl" on the server.  

The "init.sh" script changes the value of the PATH 
environment variable to include the absolute pathname 
of the ACUCOBOL-GT "bin" directory.  Use the dot command 
to invoke this script (i.e., ". ./init.sh").  You also 
need to set any necessary Oracle environment variables 
here, like LD_LIBRARY_PATH, ORACLE_HOME, and ORACLE_SID.    

The "startAcutools.sh" script is responsible primarily 
for starting AcuServer and AcuConnect with the correct 
parameters.  Update the port numbers in the script for 
these two server processes, if necessary.  This script 
also checks permissions (by calling "permOk.sh") and for 
the presence of the Pro*COBOL pre-compiler.  Note that 
the procob command must be in your PATH for this script 
to run.

The "killAcutools" script closes the AcuServer and 
AcuConnect processes.  Again, you need to update the 
port numbers in this script, if necessary.

The "permOk.sh" script checks ownerships 
and permissions.  

The "pcompile.sh" script executes the Pro*COBOL 
pre-compilation process on the server after being 
called by "pcompile.acu", the Boomerang engine.  

Client files
------------

The "buildclient.cmd" script is used to compile 
"pcompile.cbl" on the client.  The resulting 
"pcompile.acu" file should be copied to the 
ACUCOBOL-GT "bin" directory.  Other files in the 
Boomerang "client" folder must be also be copied to 
that directory.  These files include:

"boomerang.cmd", which launches the Boomerang process.  
Update this file to reference the "pcompile.acu" path, 
if necessary.
  
"boomerangDebug.cmd", which launches Boomerang in debug 
mode.  Update this file to reference the "pcompile.acu" 
path, if necessary.

The "sample" subdirectory contains the files needed to 
build and run the sample program using Boomerang:

"buildprg.cmd", which builds/compiles the sample program 
using the Boomerang utility

"runprg.cmd", which executes the sample program via 
AcuConnect

"sample.pco", a sample program that contains embedded SQL

"userpassw", which contains the sample program's 
COPY files  

Client environment 
------------------

Boomerang operation requires some modifications to client 
environment settings, as indicated:  

ACUSERVER_PORT and ACURCL_PORT to their respective ports 
on the server

COMPILERNAME to the "boomerang.cmd" path (or the 
"boomerangDebug.cmd" path)

COPYPATH to the directory containing the COPY files needed 
by the sample program (in this case, the "sample" directory)

PCOMPILE to the "pcompile.acu" path on the client

SERVERPROCOBSH to the path of the "pcompile.sh" script on 
the server; may be relative to the AcuConnect starting 
directory

SERVERPROCOBSTART to "pcompile.acu" on the server

SERVERTMPPATH to the "tmp" directory path on the UNIX server; 
may be relative to the AcuServer starting directory

TEMP to the temporary directory ("tmp") on the client machine

UNIQUENUMBERNAME to the name of a file shared by all client 
stations using Boomerang; this setting ensures that multiple 
users can pre-compile simultaneously

ACULOCALDEST to the path for resulting COBOL object files, 
if they are being stored on the client rather than the 
server; this setting is optional

PROGRAM EXECUTION
-----------------

After you have completed the setup, you are ready to run 
the Boomerang utility.  You should ensure that the ACUCOBOL-GT 
runtime is relinked to your Oracle Pro*COBOL libraries 
for the sample project to run.

1. Execute the "init.sh" script to change the PATH environment 
variable to include the ACUCOBOL-GT "bin" directory, as shown:

PATH=[ACUCOBOL-GT pathname]:$PATH

2. Execute the "buildserver.sh" script to compile the 
"pcompile.cbl" Boomerang source program on the server:

[ACUCOBOL-GT pathname]/ccbl -o @.acu -x -Ga -Zd pcompile.cbl

3. Ensure that the "AcuAccess" file reflects the appropriate 
ownerships and permissions.  "AcuAccess" and "acutools.cfg" 
files must be owned and writable only by root.  The local 
user, as defined in "AcuAccess", should have the read and 
execute permissions for the "pcompile.sh" script, which 
triggers the pre-compilation process.  

Modify the "permOk.sh" script to agree with your "AcuAccess" 
file.  If you map all the clients with a single local user, 
you should modify the "chown user:group pcompile.sh" line 
in the script, replacing "user" with the name of the local 
user, and "group" with the group of the local user.  If 
you map distinct client users with distinct local users, 
you should replace that line with individual commands that 
give the file's read and execute mode for each local 
user referenced in "AcuAccess".

Ensure that the server "obj" directory is owned by the 
local user and that the server "tmp" directory is 
accessible by all users.  

4. Execute the "startAcutools.sh" script to start the 
AcuServer and AcuConnect processes.

5. Execute the "buildclient.cmd" script to compile the 
"pcompile.cbl" Boomerang source program on the client: 
 
[ACUCOBOL-GT pathname]\ccbl32 -o @.acu -x -Ga -Zd pcompile.cbl 

Copy the "pcompile.acu" object file to the ACUCOBOL-GT "bin" 
directory, along with the "boomerang.cmd" (or 
"boomerangDebug.cmd") script.

6. Execute the "buildpgm.cmd" script to build and compile 
"sample.pco" with the Boomerang utility.

boomerang.cmd -o acurfap://[server-name]:[port-number]:
[server-object-directory-pathname]/@.acu -x -Ga -Zd 
-Lo listing.lst [client-sample-file-directory-pathname]\%1

where "%1" is the program name.  

7. Create your AcuConnect server alias file using the 
acurcl –alias command.  

8. Run your program with the "runprg.cmd" script:

[ACUCOBOL-GT pathname]\acuthin [server-name]:[port-number] %1

where "%1" is the server alias name.  

