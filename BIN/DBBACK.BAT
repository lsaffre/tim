@echo off
rem ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
rem ³  Copyright(c) PAC Systems / Rumma & Ko                             ³
rem ³  Author : Luc Saffre                                               ³
rem ³  Credits : Tom Htten                                              ³
rem ³  IMPORTANT : read fparse.txt before modifying this file !          ³
rem ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cls

:restart

rem **********
rem *** confirmation for each database
rem **********
if x%1 == x goto lastdisk
rem 20030205 if x%1 == x goto fertig
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
echo ³ SICHERHEITSKOPIE %1 nach A:
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
choice /cjn "Vorgang starten "
if errorlevel 2 goto ende

rem **********
rem *** preparation
rem **********
rem T:
rem cd T:\HGWORK\TIM\BIN
echo dbback.btp %1 %2 %3 %4 %5 %6 >> T:\HGWORK\TIM\BIN\console.msg
if not exist T:\HGWORK\TIM\BIN\backup\. md T:\HGWORK\TIM\BIN\backup
rem delete error.txt from previous backup
if exist T:\HGWORK\TIM\BIN\backup\error.txt del T:\HGWORK\TIM\BIN\backup\error.txt
rem delete archives of previous backup
if exist T:\HGWORK\TIM\BIN\backup\%1.a* del T:\HGWORK\TIM\BIN\backup\%1.a*

if exist T:\HGWORK\TIM\BIN\..\data\dbd.dbc set DATAROOT=T:\HGWORK\TIM\BIN\..\DATA
if exist T:\HGWORK\TIM\BIN\data\dbd.dbc set DATAROOT=T:\HGWORK\TIM\BIN\DATA
if exist T:\HGWORK\TIM\BIN\dbd.dbc set DATAROOT=T:\HGWORK\TIM\BIN
if not exist %DATAROOT%\%1\tim.mrk goto error1
if not exist %DATAROOT%\%1\*.log goto startarj

dir %DATAROOT%\%1\*.log
echo Es scheint, dass noch jemand in TIM arbeitet.
echo Oder Ihre Datenbank müsste mal reorganisiert werden.
choice /cjn "Wollen Sie trotzdem ein Backup machen "
if errorlevel 2 goto ende



:startarj
rem cd %DATAROOT%
rem cd %1
arj a -r -y -e1 -v1440 -jm -x*.ntx -x*.ol* -x*.arj -xarjtemp.* T:\HGWORK\TIM\BIN\backup\%1 %DATAROOT%\%1\
if errorlevel 1 goto err_arj
rem cd T:\HGWORK\TIM\BIN
if not exist T:\HGWORK\TIM\BIN\backup\%1.arj goto error2

rem *****
rem *** Rename the first file to %1.000 to make it appear on the top
rem *** of the filelist %1.*
rem *****
rem move .\backup\%1.arj .\backup\%1.000

rem *****
rem *** Start the copy process
rem *** For every file in the group .\backup\%1.* call docopy.bat
rem *****
for %%f in (T:\HGWORK\TIM\BIN\backup\%1.*) do call docopy.bat %1 %%f
if exist T:\HGWORK\TIM\BIN\backup\error.txt goto ende

rem *****
rem *** Rename the first file back to %1.arj (just to tidy up)
rem *****
rem move .\backup\%1.000 .\backup\%1.arj

rem *****
rem *** If more than 1 database directory was specified,
rem *** start over with the next DB
rem *****
:weiter
shift
goto restart

:fertig

goto lastdisk

choice /cjn "Auch eine Sicherheitskopie des Programms machen "
if errorlevel 2 goto lastdisk

del T:\HGWORK\TIM\BIN\backup\bin.arj
arj a T:\HGWORK\TIM\BIN\backup\bin tim4.exe tim.ini setup.bat fparse.exe choice.com loading.txt
if errorlevel 1 goto err_arj

if not exist T:\HGWORK\TIM\BIN\dlm\std\*.* goto nodlm1
del T:\HGWORK\TIM\BIN\backup\_dlm.arj
arj a -r -e1 T:\HGWORK\TIM\BIN\backup\_dlm dlm\*.* T:\HGWORK\TIM\BIN\
if errorlevel 1 goto err_arj
:nodlm1

echo Legen Sie die Backup-Diskette PROGAMM ein !
choice /cjn "Diskette bereit "
if errorlevel 2 goto lastdisk

xcopy T:\HGWORK\TIM\BIN\backup\bin.arj a: /v
if errorlevel 1 goto err_copy
if not exist T:\HGWORK\TIM\BIN\dlm\std\*.* goto nodlm2
xcopy T:\HGWORK\TIM\BIN\backup\_dlm.arj a: /v
if errorlevel 1 goto err_copy
:nodlm2
xcopy T:\HGWORK\TIM\BIN\arj.exe a: /v
if errorlevel 1 goto err_copy
xcopy T:\HGWORK\TIM\BIN\install.bat a: /v
if errorlevel 1 goto err_copy
xcopy T:\HGWORK\TIM\BIN\readme.txt a: /v
if errorlevel 1 goto err_copy
xcopy T:\HGWORK\TIM\BIN\loading.txt a: /v
if errorlevel 1 goto err_copy
xcopy T:\HGWORK\TIM\BIN\tim.ini a: /v
if errorlevel 1 goto err_copy

:lastdisk
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
echo ³ Sicherheitskopie erfolgreich beendet
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
pause
goto ende

:error1
echo FEHLER : %1 : Datenbank nicht gefunden !
pause
shift
goto restart

:error2
echo FEHLER : T:\HGWORK\TIM\BIN\backup\%1.arj : Datei wurde nicht erstellt !
pause
goto ende

:err_docopy
echo (Sicherheitskopie wurde nicht vollständig ausgeführt)
pause
goto ende

:err_copy
echo DBBACK.BAT : XCOPY error %errorlevel% >> console.msg
echo FEHLER : Datei konnte nicht auf die Diskette geschrieben werden
pause
goto ende

:err_arj
echo DBBACK.BAT : ARJ error %errorlevel% >> console.msg
echo FEHLER : Datei konnte nicht komprimiert werden
pause
goto ende

:syntax
echo Usage : DBBACK database-name
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
pause

:ende
