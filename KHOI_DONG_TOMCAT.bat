@echo off
title [QLST] Apache Tomcat 9 Running - Port 8080
cd /d "d:\Downloads\QLST"

echo ================================================================================
echo       HE THONG QUAN LY SIEU THI (QLST) - KHOI DONG TOMCAT 9 TICH HOP
echo                         MSSV: 10B23DCCN646
echo ================================================================================

echo [1/3] Kiem tra va khoi dong MySQL (Docker)...
docker start mysql-8.0.43 >nul 2>&1

echo [2/3] Dong bo ma nguon tu src/ sang tomcat/webapps/QLSieuThi...
robocopy "d:\Downloads\QLST\src\main\webapp" "d:\Downloads\QLST\tomcat\webapps\QLSieuThi" /E /XO /NP /NFL /NDL >nul
robocopy "d:\Downloads\QLST\target\classes" "d:\Downloads\QLST\tomcat\webapps\QLSieuThi\WEB-INF\classes" /E /XO /NP /NFL /NDL >nul
echo       -^> Da dong bo xong ma nguon webapp va file class!

echo [3/3] Bat che do tu dong dong bo thoi gian thuc (Hot-Sync)...
start /b powershell -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File "d:\Downloads\QLST\auto-sync.ps1"
echo       -^> Khi sua bat ky file JSP, CSS nao trong src/, he thong se TU DONG cap nhat!

echo.
echo Dang khoi dong Apache Tomcat 9...
cd /d "d:\Downloads\QLST\tomcat\bin"
set "JAVA_HOME=C:\Program Files\Java\jdk-24"
set "CATALINA_HOME=d:\Downloads\QLST\tomcat"
set "CATALINA_BASE=d:\Downloads\QLST\tomcat"
catalina.bat run
