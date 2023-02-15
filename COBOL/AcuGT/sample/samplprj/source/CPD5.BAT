@SET OLDCPY=%COPYPATH%
@SET OLDFLAGS=%CBLFLAGS%
@SET OLDPATH=%PATH%
@SET COPYPATH=.;..\FD;..\COPYLIB;..\SCREEN;\ACUCOBOL\ACUGT\SAMPLE\DEF;E:\Acucobol\AcuGT\sample\samplprj\resource;def/acucobol.def;E:\FONTESBD\PUBLIC;E:\FONTESBD\CPY;E:\CAID2\SKL;E:\FONTACU\SINC\CPY;.;E:\FONTACU\PUBLIC
@SET CBLFLAGS=-ZA -Z50 -FX -DI -VC -ZZ -D1 -DW32 -DA4
@PATH E:\ACUCOBOL\ACUGT\BIN;%PATH%
@if !%1==! goto falta
:TESTA
@if exist %1.CBL goto COMPCBL
@echo .
@echo .  programa %1.CBL  nao encontrado
@echo .  programa %1.CBL  nao encontrado >> C:\TMP\CPERRO.LOG
@echo .
@goto PROXIMO
:COMPCBL
@echo .
@echo . [CPD5 FontesBD] compilando %1.cbl
@echo .
CCBL32 -ZD -ZL -W -FO \EXEACWBD\ -O \EXEACWBD\%1 %1.CBL
@if errorlevel 1 goto ERRO
:PROXIMO
@SHIFT
@IF !%1==! GOTO FIM
@GOTO TESTA
:ERRO
@echo .
@echo . Erro durante a compilacao do programa %1
@echo . Erro durante a compilacao do programa %1 >> C:\TMP\CPERRO.LOG
@goto PROXIMO
:FALTADCL
@echo .
@echo . %1: Falta COPY do MAINRTN.DCL e/ou FINALIZA.CPY - Impossivel compilar
@echo . %1: Falta COPY do MAINRTN.DCL e/ou FINALIZA.CPY - Impossivel compilar >> C:\TMP\CPERRO.LOG
@goto PROXIMO
:FALTA
@echo .
@echo ... falta nome do programa
@echo .
:FIM
@SET COPYPATH=%OLDCPY%
@SET PATH=%OLDPATH%
@SET CBLFLAGS=%OLDFLAGS%
@SET OLDCPY=
@SET OLDPATH=
@SET OLDFLAGS=
