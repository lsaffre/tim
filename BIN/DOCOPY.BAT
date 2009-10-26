@echo off
rem ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
rem ³  Copyright(c) PAC Systems / Rumma & Ko                                ³
rem ³  Authors : Luc Saffre, Tom Htten                                     ³
rem ³  IMPORTANT : read fparse.txt before modifying this file !             ³
rem ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
rem *****
rem *** If the file error.txt has been found, don't continue processing
rem *****
if exist T:\HGWORK\TIM\BIN\backup\error.txt goto ende

:anfang

rem *********
rem *** confirm each disk
rem *********
echo Kopie %2 nach Diskette
choice /cjn "Diskette bereit "
if errorlevel 2 goto ende

echo %2 wird nach Diskette geschrieben...


rem ***
rem *** user may re-use any old backup disk
rem ***
rem format a: /u/q/v:"%1 1"
if exist a:\%1.* del a:\%1.*
if exist a:\bin.arj del a:\bin.arj
rem if exist a:\*.* goto err_copy

xcopy %2 a: /v
if errorlevel 1 goto err_copy
goto ende


:error3
echo (Sicherheitskopie wurde nicht vollständig ausgeführt)
echo USER ABORT > T:\HGWORK\TIM\BIN\backup\error.txt
pause
goto ende




:err_copy
choice /cjn "Möchten Sie noch mal probieren "
if errorlevel 2 goto err_copy_2
goto anfang

:err_copy_2

echo docopy.btp: XCOPY error %errorlevel% > T:\HGWORK\TIM\BIN\backup\error.txt
type T:\HGWORK\TIM\BIN\backup\error.txt >> console.msg
type T:\HGWORK\TIM\BIN\backup\error.txt
pause


:ende

