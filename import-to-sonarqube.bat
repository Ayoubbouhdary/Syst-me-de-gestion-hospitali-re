@echo off
REM Script pour importer les résultats Dart dans SonarQube via SARIF

echo ========================================
echo Importer l'analyse Dart dans SonarQube
echo ========================================
echo.

set REPORTS_DIR=reports
set SARIF_FILE=%REPORTS_DIR%\dart_analysis.sarif

if not exist "%SARIF_FILE%" (
    echo ❌ Fichier SARIF non trouvé: %SARIF_FILE%
    echo Lancez d'abord: analyze-dart.bat
    exit /b 1
)

echo [1/2] Génération du fichier d'analyse...
python dart_analyzer.py "%REPORTS_DIR%\analyze_output.txt" "%REPORTS_DIR%" "%cd%"
if %errorlevel% neq 0 (
    echo ❌ Erreur lors de la génération
    exit /b 1
)
echo ✓ Fichier SARIF généré
echo.

echo [2/2] Envoi à SonarQube...
echo Note: SonarQube doit être en version 8.6+
echo.

sonar-scanner ^
  -Dproject.settings=sonar-project.properties ^
  -Dsonar.externalIssuesReportPaths=%SARIF_FILE%

if %errorlevel% neq 0 (
    echo ❌ Erreur lors de l'envoi à SonarQube
    echo Vérifiez que SonarQube est accessible
    exit /b 1
)

echo ========================================
echo ✓ Import terminé!
echo Consultez: http://localhost:9000
echo ========================================
pause
