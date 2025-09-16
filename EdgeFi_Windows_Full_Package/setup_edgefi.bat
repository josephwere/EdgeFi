@echo off
echo EdgeFi offline server setup...
:: Add MySQL to PATH (common default install path)
SET MYSQL_BIN="C:\Program Files\MySQL\MySQL Server 8.0\bin"
SET PATH=%PATH%;%MYSQL_BIN%
:: Create DB and user - using mysql CLI
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS wifirental; CREATE USER IF NOT EXISTS 'edgefi'@'localhost' IDENTIFIED BY 'edgefi_pass'; GRANT ALL ON wifirental.* TO 'edgefi'@'localhost'; FLUSH PRIVILEGES;"
:: Import quickstart schema if present
if exist "%~dp0sql\edgefi_quickstart_schema.sql" (
  mysql -u edgefi -pedgefi_pass wifirental < "%~dp0sql\edgefi_quickstart_schema.sql"
)
:: Install Node deps and start server (assumes node in PATH)
if exist "%~dp0server\package.json" (
  cd "%~dp0server"
  npm install
  npm install pm2 -g
  pm2 start server.js --name edgefi
)
echo Offline setup complete.
pause
