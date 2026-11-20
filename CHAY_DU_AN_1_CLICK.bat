@echo off
chcp 65001 >nul
title [QLST] - KHOI DONG DU AN 1-CLICK
color 0A

echo ==============================================================================
echo        HE THONG QUAN LY SIEU THI - PTTKHT
echo        MSSV: 10B23DCCN646 - TICH HOP MOI TRUONG TOMCAT 9
echo ==============================================================================
echo.

set "PROJECT_DIR=%~dp0"
set "TOMCAT_DIR=%PROJECT_DIR%tomcat"
set "JAVA_HOME=C:\Program Files\Java\jdk-24"
set "PATH=%JAVA_HOME%\bin;C:\Users\ADMIN\apache-maven-3.9.11-bin\apache-maven-3.9.11\bin;%PATH%"

:: 1. Kiem tra MySQL
echo [1/4] Kiem tra dich vu CSDL MySQL Port 3306...
netstat -ano | findstr ":3306" | findstr "LISTENING" >nul
if %ERRORLEVEL% equ 0 (
    echo       [OK] MySQL Port 3306 dang hoat dong san sang!
) else (
    echo       [..] Dang kich hoat MySQL...
    docker start mysql-8.0.43 >nul 2>&1
    ping 127.0.0.1 -n 3 >nul
    netstat -ano | findstr ":3306" | findstr "LISTENING" >nul
    if %ERRORLEVEL% neq 0 (
        if exist "C:\xampp\mysql_start.bat" (
            start "" /b "C:\xampp\mysql_start.bat"
            ping 127.0.0.1 -n 4 >nul
        )
    )
    echo       [OK] Da kiem tra xong dich vu MySQL.
)
echo.

:: 2. Dong tien trinh Tomcat cu tren port 8080 (neu co)
echo [2/4] Kiem tra cong 8080...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080" ^| findstr "LISTENING"') do (
    echo       [..] Dang giai phong cong 8080 PID %%a...
    taskkill /F /PID %%a >nul 2>&1
)
ping 127.0.0.1 -n 2 >nul
echo       [OK] Cong 8080 da san sang.
echo.

:: 3. Cap nhat ban build vao Tomcat noi bo
echo [3/4] Kiem tra file dong goi ung dung...
if not exist "%PROJECT_DIR%target\QLSieuThi.war" (
    echo       [..] Dang bien dich ma nguon voi Maven...
    call mvn clean package -DskipTests
)

copy /y "%PROJECT_DIR%target\QLSieuThi.war" "%TOMCAT_DIR%\webapps\" >nul
if not exist "%TOMCAT_DIR%\webapps\QLSieuThi" mkdir "%TOMCAT_DIR%\webapps\QLSieuThi"
xcopy /s /e /y /q "%PROJECT_DIR%target\QLSieuThi" "%TOMCAT_DIR%\webapps\QLSieuThi\" >nul
echo       [OK] Da cap nhat webapps/QLSieuThi thanh cong.
echo.

:: 4. Khoi dong Tomcat noi bo
echo [4/4] Dang khoi dong Apache Tomcat 9 noi bo cua du an...
set "CATALINA_HOME=%TOMCAT_DIR%"
set "CATALINA_BASE=%TOMCAT_DIR%"

pushd "%TOMCAT_DIR%\bin"
start "Tomcat9_QLST" cmd /c "startup.bat"
popd

echo.
echo ==============================================================================
echo                DU AN DA KHOI DONG THANH CONG!
echo ==============================================================================
echo.
echo   * Trang chu ung dung:
echo     http://localhost:8080/QLSieuThi/
echo.
echo   * Module 1 (Dang ky thanh vien):
echo     http://localhost:8080/QLSieuThi/register
echo.
echo   * Module 2 (Thong ke doanh thu mat hang):
echo     http://localhost:8080/QLSieuThi/statistics
echo.
echo   * So do thiet ke 4 tang tuong tac:
echo     http://localhost:8080/QLSieuThi/so_do_thiet_ke.html
echo.
echo ==============================================================================
echo   Dang tu dong mo trinh duyet...

ping 127.0.0.1 -n 4 >nul
start http://localhost:8080/QLSieuThi/
