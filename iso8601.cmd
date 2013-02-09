@echo off
:::: iso8601.cmd
:: Maintainer:   Szymon 'polemon' Bereziak <polemon@polemon.org>
:: Last Change:  2012-12-13
:: URL:          http://polemon.org
:: Version:      0.1

SETLOCAL

for /f "skip=1" %%x in ('wmic os get localdatetime') do set ostr=%%x

set iso_y=%ostr:~0,4%
set iso_m=%ostr:~4,2%
set iso_d=%ostr:~6,2%

set iso_hh=%ostr:~8,2%
set iso_mm=%ostr:~10,2%
set iso_ss=%ostr:~12,2%

set o_sign=%ostr:~-4,1%
set o_mins=%ostr:~-3%

:: remove leading zeros
if "%o_mins:~0,1%"=="0" set o_mins=%o_mins:~1%
if "%o_mins:~0,1%"=="0" set o_mins=%o_mins:~1%

:: calculate timezone offset
set /a o_hh = %o_mins% / 60
set /a o_mm = %o_mins% - (%o_hh% * 60)

:: prepend zeroes if necessary
if "%o_hh%"=="%o_hh:~0,1%" set o_hh=0%o_hh%
if "%o_mm%"=="%o_mm:~0,1%" set o_mm=0%o_mm%

if "%1"=="-d" (
    echo|set /p=%iso_y%-%iso_m%-%iso_d%
    goto END
) else if "%1"=="-t" (
    echo|set /p=%iso_hh%:%iso_mm%:%iso_ss%
    goto END
) else if "%1"=="-o" (
    echo|set /p=%o_sign%%o_hh%:%o_mm%
    goto END
) else if "%1"=="" (
    echo|set /p=%iso_y%-%iso_m%-%iso_d%T%iso_hh%:%iso_mm%:%iso_ss%%o_sign%%o_hh%:%o_mm%
    goto END
)

echo Usage: iso8601 [-d^|-t^|-o]
echo.
echo    (no arguments)  print date, time and UTC offset in ISO 8601 format
echo    -d              print only the date
echo    -t              print only the time
echo    -o              print only the UTC offset
echo.
echo Additional information can be found at: http://enwp.org/ISO_8601

:END