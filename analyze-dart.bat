@echo off
REM Script d'analyse Dart complète avec rapports personnalisés

echo ========================================
echo Analyseur Dart - Hospital Frontend
echo ========================================
echo.

REM Variables
set OUTPUT_DIR=reports
set PROJECT_NAME=Hospital Frontend
set TIMESTAMP=%date:~6,4%-%date:~3,2%-%date:~0,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%

REM Créer le répertoire de rapports
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

echo [1/4] Téléchargement des dépendances...
flutter pub get
if %errorlevel% neq 0 (
    echo ❌ Erreur lors du téléchargement des dépendances
    exit /b 1
)
echo ✓ Dépendances téléchargées
echo.

echo [2/4] Analyse statique du code...
flutter analyze --no-pub > "%OUTPUT_DIR%\analyze_output.txt" 2>&1
echo ✓ Analyse statique complétée
echo.

echo [3/4] Génération des rapports...
python dart_analyzer.py "%OUTPUT_DIR%\analyze_output.txt" "%OUTPUT_DIR%" "%cd%"
if %errorlevel% neq 0 (
    echo ❌ Erreur lors de la génération des rapports
    exit /b 1
)
echo ✓ Rapports générés
echo.

echo [4/4] Affichage du rapport HTML...
if exist "%OUTPUT_DIR%\dart_analysis.html" (
    start "" "%OUTPUT_DIR%\dart_analysis.html"
    echo ✓ Rapport HTML ouvert dans votre navigateur
) else (
    echo ❌ Rapport HTML non trouvé
)
echo.

echo ========================================
echo ✓ Analyse complétée!
echo ========================================
echo.
echo Rapports disponibles dans: %OUTPUT_DIR%
echo   - dart_analysis.json  : Rapport JSON structuré
echo   - dart_analysis.csv   : Rapport CSV (Excel)
echo   - dart_analysis.html  : Rapport HTML interactif
echo   - dart_analysis.sarif : Rapport SARIF (format standard)
echo.
pause
