@echo off
REM EdgeFi Installer Runner - runs installers from 'installers' folder
SETLOCAL ENABLEDELAYEDEXPANSION
SET INSTALLERS_DIR=%~dp0installers
IF NOT EXIST "%INSTALLERS_DIR%" (
  echo Installers folder not found. Creating %INSTALLERS_DIR%
  mkdir "%INSTALLERS_DIR%"
  echo Please place vendor installers in that folder and re-run this script.
  pause
  exit /b 1
)

echo Looking for Node.js installer...
SET NODE_MSI=%INSTALLERS_DIR%\node-v18*.msi
for %%f in (%NODE_MSI%) do set NODE_FILE=%%~ff
if defined NODE_FILE (
  echo Found Node installer: %NODE_FILE%
  msiexec /i "%NODE_FILE%" /qn /norestart
) else (
  echo Node installer not found in installers\.
)

echo Looking for MySQL installer...
SET MYSQL_MSI=%INSTALLERS_DIR%\mysql-installer-community-*.msi
for %%f in (%MYSQL_MSI%) do set MYSQL_FILE=%%~ff
if defined MYSQL_FILE (
  echo Found MySQL installer: %MYSQL_FILE%
  msiexec /i "%MYSQL_FILE%" /qn /norestart
) else (
  echo MySQL installer not found in installers\.
)

echo Looking for Redis zip...
SET REDIS_ZIP=%INSTALLERS_DIR%\redis-*.zip
for %%f in (%REDIS_ZIP%) do set REDIS_FILE=%%~ff
if defined REDIS_FILE (
  echo Found Redis zip: %REDIS_FILE%
  powershell -Command "Expand-Archive -Path '%REDIS_FILE%' -DestinationPath '%~dp0redis' -Force"
  REM Optionally install Redis as a service manually or use bundled instructions
) else (
  echo Redis zip not found in installers\.
)

echo Looking for Nginx zip...
SET NGINX_ZIP=%INSTALLERS_DIR%\nginx-*.zip
for %%f in (%NGINX_ZIP%) do set NGINX_FILE=%%~ff
if defined NGINX_FILE (
  echo Found Nginx zip: %NGINX_FILE%
  powershell -Command "Expand-Archive -Path '%NGINX_FILE%' -DestinationPath '%~dp0nginx' -Force"
) else (
  echo Nginx zip not found in installers\.
)

echo All available installers processed. Please review output for any missing installers.
pause
