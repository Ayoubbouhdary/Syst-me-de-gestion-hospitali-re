@echo off
echo ========================================
echo  Hospital Dashboard - Backend Startup
echo ========================================
echo.

echo [1/4] Nettoyage des anciens containers...
docker rm -f hospital-postgres hospital-backend 2>nul

echo [2/4] Demarrage PostgreSQL...
docker run -d ^
  --name hospital-postgres ^
  -e POSTGRES_DB=hospital_db ^
  -e POSTGRES_USER=postgres ^
  -e POSTGRES_PASSWORD=postgres ^
  -p 5432:5432 ^
  postgres:15

echo [3/4] Attente PostgreSQL (10 secondes)...
timeout /t 10 /nobreak >nul

echo [4/4] Demarrage Backend Spring Boot...
cd backend
start cmd /k "mvn spring-boot:run"

echo.
echo ========================================
echo  Backend demarre !
echo  API: http://localhost:8080
echo  Swagger: http://localhost:8080/swagger-ui.html
echo ========================================
pause
