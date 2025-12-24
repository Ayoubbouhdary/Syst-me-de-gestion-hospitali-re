# Guide Technique : Tests et Qualité pour Flutter Web

## Contexte du Projet

**Projet** : Hospital Dashboard Application  
**Architecture** : Microservices (Spring Boot Backend + Flutter Frontend)  
**Problématique** : SonarQube et Selenium ne fonctionnent pas avec Flutter

---

## 🚨 Problème 1 : SonarQube ne peut pas analyser Flutter/Dart

### Explication Technique

#### Pourquoi SonarQube ne supporte pas Flutter/Dart nativement ?

**SonarQube** est conçu pour analyser le code source via des **plugins de langage**. Actuellement :

- ✅ **Java, JavaScript, TypeScript, Python, C#, PHP** → Supportés officiellement
- ❌ **Dart/Flutter** → **Aucun plugin officiel disponible**

**Raisons techniques :**
1. **Syntaxe Dart** : SonarQube ne possède pas de parseur pour la syntaxe Dart
2. **Règles de qualité** : Aucune base de règles de qualité (code smells, bugs, vulnérabilités) pour Dart
3. **Modèle AST** : SonarQube n'a pas de représentation AST (Abstract Syntax Tree) pour Dart
4. **Écosystème différent** : Dart utilise `dart analyze` et non des standards Java/JS

### Solutions Professionnelles pour Flutter

#### 1. **Dart Analyzer (flutter analyze)** - Outil Officiel

```bash
# Analyser tout le projet Flutter
flutter analyze

# Avec configuration stricte
flutter analyze --no-fatal-infos --no-fatal-warnings
```

**Avantages :**
- Intégré nativement dans Flutter SDK
- Détecte les erreurs de syntaxe, warnings, et lints
- Gratuit et supporté par Google

**Configuration : `analysis_options.yaml`**

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  errors:
    # Traiter les warnings comme des erreurs
    missing_return: error
    dead_code: error
    unused_import: error
    unused_local_variable: error
  
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - "build/**"

linter:
  rules:
    # Best practices
    - always_declare_return_types
    - always_require_non_null_named_parameters
    - avoid_print
    - avoid_redundant_argument_values
    - avoid_returning_null_for_void
    - cancel_subscriptions
    - close_sinks
    
    # Style
    - camel_case_types
    - prefer_const_constructors
    - prefer_final_fields
    - prefer_single_quotes
    
    # Sécurité
    - avoid_dynamic_calls
    - use_build_context_synchronously
```

#### 2. **Dart Code Metrics (DCM)** - Alternative Puissante

```bash
# Installation
dart pub global activate dart_code_metrics

# Analyse
dcm analyze lib

# Rapport HTML
dcm analyze lib --reporter=html
```

**Fonctionnalités :**
- Mesure de complexité cyclomatique
- Détection de code dupliqué
- Métriques de maintenabilité
- Suggestions de refactoring

**Configuration : `analysis_options.yaml`**

```yaml
dart_code_metrics:
  metrics:
    cyclomatic-complexity: 20
    lines-of-code: 100
    number-of-parameters: 5
    maximum-nesting-level: 5
  
  rules:
    - no-boolean-literal-compare
    - no-empty-block
    - prefer-trailing-comma
    - avoid-unused-parameters
    - avoid-nested-conditional-expressions:
        acceptable-level: 2
```

#### 3. **Couverture de Code avec LCOV**

```bash
# Générer la couverture de code
flutter test --coverage

# Convertir en HTML pour visualisation
genhtml coverage/lcov.info -o coverage/html
```

**Résultat :** Fichier `coverage/lcov.info` au format standard LCOV.

#### 4. **Importer les Résultats dans SonarQube** (Solution Hybride)

Bien que SonarQube ne puisse pas analyser Dart, vous pouvez **importer les rapports de couverture** :

**Étape 1 : Générer le rapport LCOV**
```bash
flutter test --coverage
```

**Étape 2 : Convertir LCOV en format SonarQube Generic Coverage**

```bash
# Utiliser un outil comme sonar-generic-coverage
npm install -g sonar-generic-coverage

# Convertir
sonar-generic-coverage -i coverage/lcov.info -o coverage/sonar-coverage.xml
```

**Étape 3 : Configurer `sonar-project.properties`**

```properties
# Projet Flutter
sonar.projectKey=hospital-flutter-frontend
sonar.projectName=Hospital Dashboard Flutter
sonar.sources=lib
sonar.exclusions=**/*.g.dart,**/*.freezed.dart,**/test/**

# Import de la couverture
sonar.coverageReportPaths=coverage/sonar-coverage.xml

# Import des issues Dart (via Generic Issue Import)
sonar.externalIssuesReportPaths=dart-issues.json
```

**Étape 4 : Générer les issues depuis dart analyze**

Script Python `convert_dart_analyze_to_sonar.py` :

```python
import json
import subprocess

# Exécuter dart analyze avec sortie JSON
result = subprocess.run(['flutter', 'analyze', '--format=json'], capture_output=True, text=True)
dart_issues = json.loads(result.stdout)

# Convertir au format SonarQube Generic Issue
sonar_issues = {
    "issues": []
}

for issue in dart_issues.get('diagnostics', []):
    sonar_issues['issues'].append({
        "engineId": "dart-analyzer",
        "ruleId": issue['code'],
        "severity": "MAJOR" if issue['severity'] == 'ERROR' else "MINOR",
        "type": "CODE_SMELL",
        "primaryLocation": {
            "message": issue['message'],
            "filePath": issue['location']['file'],
            "textRange": {
                "startLine": issue['location']['line'],
                "startColumn": issue['location']['column']
            }
        }
    })

with open('dart-issues.json', 'w') as f:
    json.dump(sonar_issues, f, indent=2)
```

#### 5. **Pipeline CI/CD Complet (GitHub Actions / GitLab CI)**

**`.github/workflows/quality.yml`**

```yaml
name: Code Quality

on: [push, pull_request]

jobs:
  backend-sonarqube:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up JDK 17
        uses: actions/setup-java@v3
        with:
          java-version: '17'
      
      - name: Maven Build & SonarQube
        working-directory: backend
        run: |
          mvn clean verify sonar:sonar \
            -Dsonar.projectKey=hospital-backend \
            -Dsonar.host.url=${{ secrets.SONAR_HOST_URL }} \
            -Dsonar.login=${{ secrets.SONAR_TOKEN }}

  frontend-flutter-quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      
      - name: Install Dependencies
        run: flutter pub get
      
      - name: Dart Analyze
        run: flutter analyze > dart-analyze.txt || true
      
      - name: Run Tests with Coverage
        run: flutter test --coverage
      
      - name: Generate Coverage HTML
        run: |
          sudo apt-get install -y lcov
          genhtml coverage/lcov.info -o coverage/html
      
      - name: Dart Code Metrics
        run: |
          dart pub global activate dart_code_metrics
          dcm analyze lib --reporter=html > dcm-report.html
      
      - name: Upload Coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info
          flags: flutter
      
      - name: Archive Quality Reports
        uses: actions/upload-artifact@v3
        with:
          name: flutter-quality-reports
          path: |
            dart-analyze.txt
            dcm-report.html
            coverage/html/
```

---

## 🚨 Problème 2 : Selenium ne peut pas interagir avec Flutter Web

### Explication Technique Détaillée

#### Pourquoi Selenium échoue avec Flutter Web ?

##### 1. **Architecture de Rendu Flutter**

Flutter Web utilise **deux modes de rendu** complètement différents du HTML classique :

**a) Mode HTML (par défaut en dev)**
```
┌─────────────────────────────────────┐
│  DOM Browser                        │
│  ┌────────────────────────────┐    │
│  │ <flt-glass-pane>           │    │
│  │   <flt-scene-host>         │    │
│  │     <flt-semantics>        │    │ ← Éléments Flutter custom
│  │       <flt-semantics>      │    │
│  │         <!-- Input réel   -->    │
│  │         caché ou virtuel   │    │
│  │       </flt-semantics>     │    │
│  │     </flt-semantics>       │    │
│  │   </flt-scene-host>        │    │
│  │ </flt-glass-pane>          │    │
│  └────────────────────────────┘    │
└─────────────────────────────────────┘
```

**b) Mode CanvasKit (production)**
```
┌─────────────────────────────────────┐
│  DOM Browser                        │
│  ┌────────────────────────────┐    │
│  │ <canvas id="canvas">       │    │
│  │   ┌────────────────────┐   │    │
│  │   │  UI dessinée        │   │    │ ← TOUT est dessiné
│  │   │  pixel par pixel    │   │    │   sur le canvas !
│  │   │  (comme un jeu)     │   │    │
│  │   └────────────────────┘   │    │
│  │ </canvas>                  │    │
│  │ <!-- Pas d'<input> HTML -->│    │
│  └────────────────────────────┘    │
└─────────────────────────────────────┘
```

##### 2. **Pourquoi Selenium ne voit rien**

**Selenium WebDriver** fonctionne en interrogeant le **DOM HTML standard** :

```java
// Ce que Selenium cherche :
driver.findElement(By.id("email-input"))  // ❌ N'existe pas !
driver.findElement(By.name("password"))   // ❌ N'existe pas !
```

**Ce qui existe réellement dans Flutter Web :**

```html
<!-- Mode HTML -->
<flt-glass-pane>
  <flt-scene-host>
    <flt-semantics role="textbox" aria-label="email">
      <!-- Input réel caché dans Shadow DOM ou offset -->
    </flt-semantics>
  </flt-scene-host>
</flt-glass-pane>

<!-- Mode CanvasKit -->
<canvas id="canvas" width="1920" height="1080"></canvas>
<!-- Aucun élément HTML ! Tout est dessiné sur le canvas -->
```

**Conséquences :**
- `findElement(By.id("email"))` → **Élément introuvable**
- `sendKeys("admin@hospital.com")` → **Ne tape rien** (pas d'input HTML réel)
- Les sélecteurs CSS/XPath ne fonctionnent pas

##### 3. **Exemple Concret : Pourquoi votre test échoue**

Votre code Selenium :

```java
WebElement emailInput = driver.findElement(By.cssSelector("input[type='email']"));
emailInput.sendKeys("admin@hospital.com"); // ❌ Ne tape rien
```

**Ce que Flutter génère réellement :**

```html
<!-- Pas d'<input type="email"> ! -->
<flt-semantics role="textbox" flt-semantic-id="12">
  <input type="text" style="position: absolute; top: -9999px;"> 
  <!-- Input caché hors écran pour l'accessibilité -->
</flt-semantics>
```

Le vrai champ est **dessiné graphiquement** par Flutter et l'input HTML est **caché** ou **virtuel**.

##### 4. **Shadow DOM et Encapsulation**

Flutter utilise le **Shadow DOM** pour encapsuler ses composants :

```html
<flt-glass-pane>
  #shadow-root (closed)  ← Selenium ne peut pas accéder ici
    <flt-scene>
      <input> <!-- Le vrai input est ici mais inaccessible -->
    </flt-scene>
</flt-glass-pane>
```

Selenium ne peut pas traverser un **Shadow DOM fermé**.

---

### Solutions Professionnelles pour Tester Flutter

#### ❌ **Ce qu'il NE FAUT PAS faire**

1. ❌ Utiliser Selenium pour Flutter Web
2. ❌ Essayer de "hacker" les sélecteurs Flutter avec JavaScript
3. ❌ Utiliser Thread.sleep() pour attendre que ça fonctionne
4. ❌ Désactiver le mode CanvasKit (perte de performance)

#### ✅ **Solutions Recommandées**

### 1. **`integration_test` (Officiel Flutter)** - **MEILLEURE SOLUTION**

**Pourquoi c'est la meilleure solution ?**
- Intégré nativement dans Flutter SDK
- Fonctionne avec le framework de widgets Flutter
- Supporte Web, Mobile, Desktop
- Peut interagir directement avec les widgets Flutter

**Installation :**

```yaml
# pubspec.yaml
dev_dependencies:
  integration_test:
    sdk: flutter
  flutter_test:
    sdk: flutter
```

**Test de Login Complet :**

```dart
// integration_test/login_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hospital_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Flow', () {
    testWidgets('Login avec identifiants valides et redirection dashboard', 
        (WidgetTester tester) async {
      // 1. Lancer l'application
      app.main();
      await tester.pumpAndSettle();

      // 2. Trouver les champs email et password
      final emailField = find.byKey(const Key('email_field'));
      final passwordField = find.byKey(const Key('password_field'));
      final loginButton = find.byKey(const Key('login_button'));

      // 3. Attendre que les widgets soient présents
      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);

      // 4. Saisir les identifiants (fonctionne réellement !)
      await tester.enterText(emailField, 'admin@hospital.com');
      await tester.enterText(passwordField, 'password');
      await tester.pumpAndSettle();

      // 5. Vérifier que les valeurs sont saisies
      expect(find.text('admin@hospital.com'), findsOneWidget);

      // 6. Cliquer sur le bouton Login
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // 7. Vérifier la redirection vers le dashboard
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.byKey(const Key('dashboard_screen')), findsOneWidget);
    });

    testWidgets('Login avec identifiants invalides reste sur la page', 
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('email_field')), 
        'wrong@email.com'
      );
      await tester.enterText(
        find.byKey(const Key('password_field')), 
        'wrongpassword'
      );
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Vérifier le message d'erreur
      expect(find.text('Identifiants incorrects'), findsOneWidget);
      // Toujours sur la page de login
      expect(find.byKey(const Key('login_screen')), findsOneWidget);
    });
  });
}
```

**Exécution :**

```bash
# Web (Chrome)
flutter test integration_test/login_test.dart -d chrome

# Mobile (Android)
flutter test integration_test/login_test.dart -d android

# Desktop (Windows)
flutter test integration_test/login_test.dart -d windows
```

**Ajouter des Keys dans votre code Flutter :**

```dart
// lib/screens/login_screen.dart
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('login_screen'), // Pour les tests
      body: Column(
        children: [
          TextField(
            key: const Key('email_field'), // ← IMPORTANT
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            key: const Key('password_field'), // ← IMPORTANT
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(
            key: const Key('login_button'), // ← IMPORTANT
            onPressed: _handleLogin,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
```

---

### 2. **Patrol (Alternative Moderne)** - Tests E2E Simplifiés

**Installation :**

```yaml
dev_dependencies:
  patrol: ^2.0.0
```

**Test Login avec Patrol :**

```dart
// integration_test/login_patrol_test.dart
import 'package:patrol/patrol.dart';
import 'package:hospital_app/main.dart' as app;

void main() {
  patrolTest('Login et navigation vers dashboard', (PatrolTester $) async {
    app.main();
    await $.pumpAndSettle();

    // Saisir email (syntaxe simplifiée)
    await $(TextField).containing('Email').enterText('admin@hospital.com');
    
    // Saisir password
    await $(TextField).containing('Password').enterText('password');
    
    // Cliquer sur Login
    await $(ElevatedButton).containing('Login').tap();
    
    // Attendre la navigation
    await $.pumpAndSettle();
    
    // Vérifier le dashboard
    expect($('Dashboard'), findsOneWidget);
  });
}
```

**Avantages de Patrol :**
- Syntaxe plus concise que `integration_test`
- Détection automatique des éléments
- Gestion automatique des animations
- Support natif des permissions (utile pour mobile)

---

### 3. **Appium (Pour Tests Multi-Plateformes)**

Si vous devez tester **Mobile + Web**, utilisez Appium avec le driver Flutter :

**Installation :**

```bash
npm install -g appium
appium driver install flutter
```

**Test Java avec Appium :**

```java
// AppiumFlutterTest.java
import io.appium.java_client.AppiumDriver;
import io.appium.java_client.flutter.FlutterFinder;
import org.openqa.selenium.remote.DesiredCapabilities;

public class AppiumFlutterTest {
    
    @Test
    public void testLogin() throws Exception {
        DesiredCapabilities caps = new DesiredCapabilities();
        caps.setCapability("platformName", "Android");
        caps.setCapability("app", "/path/to/hospital_app.apk");
        caps.setCapability("automationName", "Flutter");
        
        AppiumDriver driver = new AppiumDriver(
            new URL("http://localhost:4723"), caps
        );
        
        FlutterFinder finder = new FlutterFinder(driver);
        
        // Trouver et interagir avec les widgets Flutter
        finder.byValueKey("email_field").sendKeys("admin@hospital.com");
        finder.byValueKey("password_field").sendKeys("password");
        finder.byValueKey("login_button").click();
        
        // Vérifier la navigation
        assertTrue(finder.text("Dashboard").isDisplayed());
    }
}
```

---

### 4. **Tests de Navigation et CRUD Complets**

```dart
// integration_test/navigation_crud_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hospital_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Navigation et CRUD Patient', () {
    testWidgets('Navigation Dashboard -> Patients -> Services', 
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Login
      await _performLogin(tester);

      // Vérifier Dashboard
      expect(find.byKey(const Key('dashboard_screen')), findsOneWidget);

      // Naviguer vers Patients
      await tester.tap(find.text('Patients'));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('patients_screen')), findsOneWidget);

      // Naviguer vers Services
      await tester.tap(find.text('Services'));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('services_screen')), findsOneWidget);
    });

    testWidgets('CRUD complet sur Patient', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await _performLogin(tester);

      // CREATE
      await tester.tap(find.text('Patients'));
      await tester.pumpAndSettle();
      
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      
      await tester.enterText(
        find.byKey(const Key('first_name_field')), 
        'Selenium'
      );
      await tester.enterText(
        find.byKey(const Key('last_name_field')), 
        'Tester'
      );
      await tester.enterText(
        find.byKey(const Key('email_field')), 
        'selenium@test.com'
      );
      await tester.tap(find.byKey(const Key('save_button')));
      await tester.pumpAndSettle();

      // READ - Vérifier présence dans la liste
      expect(find.text('Selenium Tester'), findsOneWidget);

      // UPDATE
      await tester.tap(find.text('Selenium Tester'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      
      await tester.enterText(
        find.byKey(const Key('email_field')), 
        'updated@test.com'
      );
      await tester.tap(find.byKey(const Key('save_button')));
      await tester.pumpAndSettle();
      
      expect(find.text('updated@test.com'), findsOneWidget);

      // DELETE
      await tester.tap(find.text('Selenium Tester'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Confirmer'));
      await tester.pumpAndSettle();
      
      expect(find.text('Selenium Tester'), findsNothing);
    });
  });
}

Future<void> _performLogin(WidgetTester tester) async {
  await tester.enterText(
    find.byKey(const Key('email_field')), 
    'admin@hospital.com'
  );
  await tester.enterText(
    find.byKey(const Key('password_field')), 
    'password'
  );
  await tester.tap(find.byKey(const Key('login_button')));
  await tester.pumpAndSettle();
}
```

---

## 🏗️ Architecture Recommandée pour votre Projet

### Structure de Tests Complète

```
hospital_project/
├── backend/                           # Spring Boot
│   ├── src/
│   │   ├── main/java/
│   │   └── test/java/                # Tests unitaires JUnit
│   ├── pom.xml
│   └── sonar-project.properties      # ✅ SonarQube fonctionne
│
├── frontend/                          # Flutter
│   ├── lib/
│   ├── test/                          # Tests unitaires Flutter
│   │   └── unit/
│   │       ├── models_test.dart
│   │       ├── services_test.dart
│   │       └── widgets_test.dart
│   │
│   ├── integration_test/              # ✅ Tests E2E Flutter
│   │   ├── login_test.dart
│   │   ├── navigation_test.dart
│   │   └── crud_test.dart
│   │
│   ├── analysis_options.yaml          # ✅ Linting Dart
│   └── pubspec.yaml
│
├── selenium-tests/                    # ❌ NE FONCTIONNE PAS pour Flutter
│   └── (à supprimer ou garder uniquement pour backend admin)
│
└── .github/workflows/
    └── quality.yml                    # CI/CD complet
```

### Pipeline CI/CD Final

```yaml
name: Hospital App Quality & Tests

on: [push, pull_request]

jobs:
  backend-quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-java@v3
        with:
          java-version: '17'
      
      - name: Backend Tests & SonarQube
        working-directory: backend
        run: |
          mvn clean verify sonar:sonar \
            -Dsonar.projectKey=hospital-backend \
            -Dsonar.host.url=${{ secrets.SONAR_HOST }} \
            -Dsonar.login=${{ secrets.SONAR_TOKEN }}

  flutter-quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      
      - name: Install Dependencies
        run: flutter pub get
      
      - name: Dart Analyze
        run: flutter analyze --no-fatal-infos
      
      - name: Unit Tests
        run: flutter test test/ --coverage
      
      - name: Integration Tests (Chrome)
        run: flutter test integration_test/ -d chrome
      
      - name: Upload Coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info
```

---

## 📋 Résumé des Recommandations

### Pour la Qualité du Code

| Technologie | Outil Recommandé | Alternative |
|-------------|------------------|-------------|
| **Backend (Spring Boot)** | SonarQube ✅ | Checkstyle, PMD |
| **Frontend (Flutter)** | `flutter analyze` + `dart_code_metrics` ✅ | SonarQube (import LCOV uniquement) |
| **Couverture Backend** | JaCoCo + SonarQube ✅ | Cobertura |
| **Couverture Frontend** | LCOV + Codecov ✅ | - |

### Pour les Tests

| Type de Test | Outil Recommandé | À Éviter |
|--------------|------------------|----------|
| **Backend Unit** | JUnit 5 + Mockito ✅ | - |
| **Backend Integration** | Spring Boot Test + TestContainers ✅ | - |
| **Frontend Unit** | `flutter test` ✅ | - |
| **Frontend E2E** | `integration_test` ✅ | ❌ Selenium |
| **Frontend E2E (alternatif)** | Patrol ✅ | - |
| **Multi-plateforme** | Appium Flutter Driver ✅ | ❌ Selenium |

---

## 🎯 Actions Immédiates pour votre Projet

### 1. **Abandonner Selenium pour Flutter** (Priorité HAUTE)

```bash
# Supprimer ou archiver
mv selenium-tests/ selenium-tests-OLD-DO-NOT-USE/
```

### 2. **Créer les Tests Integration Flutter** (Priorité HAUTE)

```bash
# Créer le dossier
mkdir integration_test

# Créer le premier test
cat > integration_test/login_test.dart << 'EOF'
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hospital_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login réussi', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    
    await tester.enterText(
      find.byKey(const Key('email_field')), 
      'admin@hospital.com'
    );
    await tester.enterText(
      find.byKey(const Key('password_field')), 
      'password'
    );
    await tester.tap(find.byKey(const Key('login_button')));
    await tester.pumpAndSettle();
    
    expect(find.text('Dashboard'), findsOneWidget);
  });
}
EOF

# Lancer le test
flutter test integration_test/login_test.dart -d chrome
```

### 3. **Configurer l'Analyse Dart** (Priorité MOYENNE)

```bash
# Créer analysis_options.yaml
cat > analysis_options.yaml << 'EOF'
include: package:flutter_lints/flutter.yaml

analyzer:
  errors:
    missing_return: error
    dead_code: error
  exclude:
    - "**/*.g.dart"
    - "build/**"

linter:
  rules:
    - always_declare_return_types
    - avoid_print
    - prefer_const_constructors
    - prefer_final_fields
EOF

# Analyser
flutter analyze
```

### 4. **Générer la Couverture** (Priorité MOYENNE)

```bash
# Tests avec couverture
flutter test --coverage

# Visualiser
genhtml coverage/lcov.info -o coverage/html
# Ouvrir coverage/html/index.html dans le navigateur
```

---

## 📚 Ressources Complémentaires

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Integration Testing (Official)](https://docs.flutter.dev/testing/integration-tests)
- [Dart Analyzer](https://dart.dev/guides/language/analysis-options)
- [Patrol Testing Framework](https://patrol.leancode.co/)
- [Appium Flutter Driver](https://github.com/appium/appium-flutter-driver)

---

## ✅ Conclusion

**Pourquoi Selenium ne fonctionne pas :**
- Flutter Web dessine l'interface sur Canvas ou utilise des widgets custom
- Pas d'éléments HTML standard (`<input>`, `<button>`)
- Shadow DOM fermé inaccessible

**Solution Professionnelle :**
- **Backend** → SonarQube ✅
- **Flutter** → `integration_test` + `flutter analyze` + `dart_code_metrics` ✅
- **Abandonner Selenium pour Flutter** ❌

**Avantages de cette approche :**
- Tests qui fonctionnent réellement
- Qualité de code mesurable
- CI/CD automatisée
- Maintenance simplifiée
- Conforme aux bonnes pratiques Flutter/Dart

