@ECHO OFF
SET OLDCPY=%COPYPATH%
SET OLDPATH=%PATH%
SET OLDDIR=%DIRACU%
SET OLDFLAGS=%CBLFLAGS%
SET COPYPATH=E:\FONTES12\PUBLIC;.;E:\CAID2\SKL;E:\FONTES12\CPY
SET CBLFLAGS=-ZA -Z50 -FX -DI -VC -ZZ -D1 -DW32 -DA4
SET CAID-PUBLIC-DIRECTORY=E:\FONTES12\PUBLIC\
PATH E:\CAID12;E:\CAID2\OBJ;E:\ACUCOBOL\ACUGT\BIN;E:\ACUCOBOL\ACUGT;%PATH%
@IF .%DIRACU%==. SET DIRACU=E:\ACUCOBOL\ACUGT\BIN
IF .%TMP% == . SET TMP=%TEMP%
IF .%TMP% == . SET TMP=C:\CAIDTEMP
@IF NOT EXIST %TMP%\CAIDTEMP12 MD %TMP%\CAIDTEMP12
SET CAIDTEMP=%TMP%\CAIDTEMP12
ECHO CAIDTEMP = %CAIDTEMP%
ECHO CAID-PUBLIC-DIRECTORY = %CAID-PUBLIC-DIRECTORY%
%DIRACU%\WRUN32 -C D:\CAID12\CAIDCFG D:\CAID2\OBJ\AIDMAIN
PATH %OLDPATH%
SET COPYPATH=%OLDCPY%
SET CBLFLAGS=%OLDFLAGS%
SET DIRACU=%OLDDIR%
SET OLDCPY=
SET OLDPATH=
SET OLDFLAGS=
SET OLDDIR=
:FIM