@echo off
REM Script pour analyser le frontend Flutter avec SonarQube

echo ========================================
echo Analyse SonarQube Frontend Flutter
echo ========================================
echo.

REM Étape 1 : Obtenir les dépendances
echo [1/4] Téléchargement des dépendances...
flutter pub get
if %errorlevel% neq 0 (
    echo Erreur lors du téléchargement des dépendances
    exit /b 1
)
echo ✓ Dépendances téléchargées
echo.

REM Étape 2 : Analyser le code
echo [2/4] Analyse statique du code...
flutter analyze --no-pub
if %errorlevel% neq 0 (
    echo Erreur lors de l'analyse statique
    exit /b 1
)
echo ✓ Analyse statique complétée
echo.

REM Étape 3 : Générer la couverture de code
echo [3/4] Génération de la couverture de code...
flutter test --coverage --no-pub
if %errorlevel% neq 0 (
    echo Erreur lors de l'exécution des tests
    exit /b 1
)
echo ✓ Couverture de code générée
echo.

REM Étape 4 : Envoyer à SonarQube
echo [4/4] Envoi de l'analyse à SonarQube...
sonar-scanner -Dproject.settings=sonar-project.properties
if %errorlevel% neq 0 (
    echo Erreur lors de l'envoi à SonarQube
    exit /b 1
)
echo ✓ Envoi complété
echo.

echo ========================================
echo ✓ Analyse SonarQube Frontend terminée!
echo Consultez: http://localhost:9000
echo ========================================
pause
