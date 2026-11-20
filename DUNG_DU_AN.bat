@echo off
chcp 65001 >nul
title [QLST] - DỪNG DỰ ÁN
color 0C

echo ==============================================================================
echo                ĐANG DỪNG HỆ THỐNG TOMCAT 9 (QLST)...
echo ==============================================================================

set "TOMCAT_DIR=%~dp0tomcat"
if exist "%TOMCAT_DIR%\bin\shutdown.bat" (
    call "%TOMCAT_DIR%\bin\shutdown.bat" >nul 2>&1
)

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080" ^| findstr "LISTENING"') do (
    taskkill /F /PID %%a >nul 2>&1
)

echo.
echo Đã dừng Tomcat và giải phóng cổng 8080 thành công!
timeout /t 2 >nul
