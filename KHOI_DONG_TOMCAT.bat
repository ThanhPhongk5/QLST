@echo off
title [QLST] Apache Tomcat 9 Running - Port 8080
cd /d "d:\Downloads\QLST"

echo ================================================================================
echo       HE THONG QUAN LY SIEU THI (QLST) - KHOI DONG TOMCAT 9 TICH HOP
echo                         MSSV: 10B23DCCN646
echo ================================================================================

echo [1/2] Kiem tra va khoi dong MySQL (Docker)...
docker start mysql-8.0.43 >nul 2>&1

echo [2/2] Dang khoi dong Apache Tomcat 9 (Port 8080)...
cd /d "d:\Downloads\QLST\tomcat\bin"
set "JAVA_HOME=C:\Program Files\Java\jdk-24"
set "CATALINA_HOME=d:\Downloads\QLST\tomcat"
set "CATALINA_BASE=d:\Downloads\QLST\tomcat"
catalina.bat run
