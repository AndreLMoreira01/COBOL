This is the source code to the ALFRED file editor.

The main source is in alfred.cbl.

The calls to C$PARSEXFD are all in ParseXFD.cbl.

In order to localize this program, you should be able to modify
(translate) the file alfmsgs.cpy.

To compile alfred and ParseXFD, either execute the shell script
build.sh, or execute the Makefile (execute make, which will parse
and execute the Makefile).  The make utility will only build the
programs that are out of date, so this is more efficient.  However
with alfred, there are only two .cbl files, and they compile fairly
quickly.  So the savings is minor.

To compile on Windows, either execute the build.cmd script, or use
AcuBench to load the alfred.pjt project and build.
