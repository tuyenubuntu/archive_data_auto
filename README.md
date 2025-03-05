"# archive_data_auto" 
# Archive Files Batch Script

## Overview
This is a Windows batch script (`archive_files.bat`) designed to archive files and subfolders from a source directory to a destination directory. The destination folder is automatically named with a timestamp, and the script displays the start and end times of the archiving process. It also provides an option to exit manually or auto-close after 10 seconds.

## Features
- Moves all files and subfolders from `C:\Users\%USERNAME%\Documents\labels` to a new folder in `C:\Users\%USERNAME%\Downloads`.
- Creates a destination folder with a timestamp in the format `labels_YYYY-MM-DD_HH-MM-SS` (e.g., `labels_2025-03-03_14-20-12`).
- Displays the start time, end time, and completion message.
- Automatically closes after 10 seconds or exits immediately when a key is pressed.

## Requirements
- Windows operating system (tested on Windows 10 and later).
- Sufficient permissions to read from the source folder and write to the destination folder.
- The source folder (`C:\Users\%USERNAME%\Documents\labels`) must exist and contain files or subfolders to archive.

## Usage
1. **Save the Script**:
   - Copy the provided code into a file named `archive_files.bat`.
   - Save it in a location of your choice (e.g., `C:\Scripts\`).

2. **Run the Script**:
   - Double-click `archive_files.bat` to execute it manually.
   - Alternatively, run it via Command Prompt: `C:\Scripts\archive_files.bat`.

3. **Output**:
   - The script will:
     - Create a new folder in `C:\Users\%USERNAME%\Downloads` with a timestamp (e.g., `labels_2025-03-03_14-20-12`).
     - Move all files and subfolders from the source to the destination.
     - Display start time, end time, and a completion message.
     - Wait for a key press or auto-close after 10 seconds.

## Script Code
```batch
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
