@echo off
REM Script rapide pour analyser le frontend Flutter avec SonarQube (sans tests)

echo ========================================
echo Analyse SonarQube Frontend Flutter
echo (Version rapide - sans tests)
echo ========================================
echo.

REM Étape 1 : Obtenir les dépendances
echo [1/3] Téléchargement des dépendances...
flutter pub get
echo ✓ Dépendances téléchargées
echo.

REM Étape 2 : Analyser le code
echo [2/3] Analyse statique du code...
flutter analyze --no-pub
echo ✓ Analyse statique complétée
echo.

REM Étape 3 : Envoyer à SonarQube
echo [3/3] Envoi de l'analyse à SonarQube...
sonar-scanner -Dproject.settings=sonar-project.properties
echo ✓ Envoi complété
echo.

echo ========================================
echo ✓ Analyse rapide terminée!
echo Consultez: http://localhost:9000
echo ========================================
pause
