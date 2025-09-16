@echo off
echo Running EdgeFi offline setup...
call "%~dp0installer-run.bat"
echo Now running EdgeFi setup (server configuration)...
if exist "%~dp0setup_edgefi.bat" (
  call "%~dp0setup_edgefi.bat"
) else (
  echo setup_edgefi.bat not found. Please copy your EdgeFi server files into this folder and run setup_edgefi.bat manually.
)
pause
