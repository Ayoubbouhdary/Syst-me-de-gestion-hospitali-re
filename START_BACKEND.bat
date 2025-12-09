@echo off
echo ========================================
echo  Hospital Backend - Quick Start
echo ========================================
echo.

echo [1/3] Nettoyage...
cd backend
call mvn clean

echo.
echo [2/3] Compilation...
call mvn compile -DskipTests

echo.
echo [3/3] Demarrage backend...
echo.
echo Backend demarre sur: http://localhost:8080
echo H2 Console: http://localhost:8080/h2-console
echo.
echo Informations H2:
echo   JDBC URL: jdbc:h2:mem:hospital_db
echo   Username: sa
echo   Password: (vide)
echo.
call mvn spring-boot:run

pause
