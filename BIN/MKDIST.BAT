@echo off
rem **********
rem *** preparation
rem **********
T:
cd T:\SVNWORK\TIM\TRUNK
rem check for first time run
rem clean up from previous runs
rem 20030205 on win95 you cannot test easily if directory exists...
if exist .\dist\*.* del /q dist\*.*
if errorlevel 1 goto ende
rd dist
if errorlevel 1 goto ende
md dist
if errorlevel 1 goto ende

T:
cd T:\SVNWORK\TIM\TRUNK
if exist dlm\*.* zip -r dist\dlm.zip dlm
if errorlevel 1 goto err_zip
if exist localdlm\*.* zip -r dist\localdlm.zip localdlm
if errorlevel 1 goto err_zip
if exist readme.txt xcopy readme.txt dist /v
if errorlevel 1 goto err_copy

T:
cd T:\SVNWORK\TIM\TRUNK\BIN
zip T:\SVNWORK\TIM\TRUNK\dist\bin.zip tim4.exe tim4.ico tim.ini choice.com prn2file.com zip.exe zipsplit.exe setup.bat
if errorlevel 1 goto err_zip
if exist unzip.exe xcopy unzip.exe T:\SVNWORK\TIM\TRUNK\dist /v
if errorlevel 1 goto err_copy


:restart

if x%1 == x goto ende

T:
cd T:\SVNWORK\TIM\TRUNK\DATA
if not exist %1\tim.dbi goto error1
zip -r -e T:\SVNWORK\TIM\TRUNK\dist\%1 %1 -x *.NTX -x *.OL* -x *.CDX
if errorlevel 1 goto err_zip


shift
goto restart

:error1
echo FEHLER : %1 : Datenbank nicht gefunden in T:\SVNWORK\TIM\TRUNK\DATA
pause
shift
if not x%1 == x goto restart
goto ende

:err_zip
echo FEHLER : Datei konnte nicht komprimiert werden
pause
goto ende

:err_copy
echo FEHLER : Datei konnte nicht kopiert werden
pause
goto ende

:syntax
echo Usage : MKDIST.BAT echo 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
echo where dbname_1 through n are database names
pause

:ende
T:
cd T:\SVNWORK\TIM\TRUNK\BIN
