# Configuration pour l'analyse SonarQube du Frontend Flutter

## Vue d'ensemble
Ce fichier configure l'analyse SonarQube spécifiquement pour le code Flutter du frontend.

## Configuration

### Sources analysées
- **Sources principales** : `lib/` - Tout le code Dart du frontend
- **Tests** : `test/` - Tests unitaires et widget

### Fichiers exclus automatiquement
- `**/*.g.dart` - Fichiers générés par build_runner
- `**/*.freezed.dart` - Classes générées par Freezed
- `**/*.mocks.dart` - Mocks générés
- `**/*.gen.dart` - Code généré
- `**/*.config.dart` - Configurations générées
- `build/` - Répertoire de build
- `.dart_tool/` - Cache Dart

### Couverture de code
Le rapport de couverture est généré en utilisant:
```bash
flutter test --coverage
```
Le fichier `coverage/lcov.info` contient les résultats.

## Scripts d'analyse

### 1. Analyse Complète (avec tests et couverture)
```bash
analyze-frontend.bat
```
Cette commande:
- Récupère les dépendances Flutter
- Effectue une analyse statique
- Exécute les tests et génère la couverture
- Envoie les résultats à SonarQube

### 2. Analyse Rapide (sans tests)
```bash
analyze-frontend-quick.bat
```
Idéal pour les vérifications rapides pendant le développement.

## Prérequis

1. **Flutter SDK** - Installé et dans le PATH
2. **SonarQube Server** - Actif sur `http://localhost:9000`
3. **SonarScanner** - Installé et dans le PATH
4. **Token SonarQube** - `sqa_f4442ca31926400251a3b7ec3fd1807b4fb7c5d4`

## Métriques suivies

- 📊 **Lignes de code** (LOC)
- 🐛 **Bugs** détectés
- 💨 **Code Smells** (problèmes de qualité)
- 🔐 **Vulnerabilités** et Hotspots de sécurité
- 🧪 **Couverture de code** (%)
- 📝 **Tests unitaires** (réussite)

## Intégration CI/CD

Pour intégrer dans un pipeline CI/CD, ajoutez cette commande:

```yaml
- name: Analyse SonarQube Frontend
  run: |
    flutter pub get
    flutter analyze
    flutter test --coverage
    sonar-scanner -Dproject.settings=sonar-project.properties
```

## Ressources
- [SonarQube Dart Plugin](https://plugins.sonarsource.com/display/plugins/Dart)
- [Flutter Testing](https://flutter.dev/docs/testing)
- [Coverage en Dart/Flutter](https://flutter.dev/docs/testing/code-coverage)
