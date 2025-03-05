@echo off
echo Start archiving files at: %date% %time%

REM Set source folder
set "source_folder=C:\Users\%USERNAME%\Documents\labels"

REM Get start timestamp (YYYY-MM-DD_HH-MM-SS)
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set "datetime=%%I"
set "start_time=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%-%datetime:~12,2%"

REM Set destination folder with timestamp
set "dest_folder=C:\Users\%USERNAME%\Downloads\labels_%start_time%"

REM Create destination folder if it doesn’t exist
if not exist "%dest_folder%" mkdir "%dest_folder%"

REM Move all files and subfolders
move "%source_folder%\*.*" "%dest_folder%" >nul 2>&1
move "%source_folder%\*\" "%dest_folder%" >nul 2>&1

REM Get end timestamp
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set "datetime=%%I"
set "end_time=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%-%datetime:~12,2%"

REM Display end time and completion message
echo Archiving completed on machine %COMPUTERNAME%!
echo Start time: %start_time%
echo End time: %end_time%
echo Press any key to exit, or it will close automatically in 10 seconds...

REM Wait 10 seconds or exit on key press
timeout /t 10 /nobreak >nul 2>&1
exit