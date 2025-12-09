rem Lance l'application avec le profile 'dev' (H2 en mémoire)
cd /d %~dp0
mvn -DskipTests clean spring-boot:run -Dspring-boot.run.profiles=dev > run_dev.log 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Lancement dev échoué. Voir run_dev.log pour les details.
) else (
    echo Application demarree en profile dev. Voir run_dev.log pour les logs.
)
pause

