# Architecture de Tests et Qualité - Hospital Dashboard Application

## 🎯 Contexte du Projet

**Domaine** : Système d'Information Hospitalier  
**Architecture** : Microservices (Spring Boot Backend + Flutter Frontend)  
**Problématique** : Selenium WebDriver ne peut pas interagir avec les champs de connexion Flutter

---

## 🔍 Analyse de la Cause Racine

### Problème Identifié

**Symptôme** : Selenium ouvre l'application Flutter mais n'écrit rien dans les champs email et mot de passe.

**Cause Racine** :

```
┌─────────────────────────────────────────────────────────────┐
│  INCOMPATIBILITÉ ARCHITECTURALE FONDAMENTALE                │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Selenium WebDriver   ←→   Flutter Web Rendering           │
│                                                             │
│  Requiert:                  Fournit:                        │
│  • HTML DOM standard        • Canvas rendering              │
│  • <input> éléments         • Custom elements (flt-*)      │
│  • CSS/XPath locators       • Shadow DOM fermé              │
│                            • Widgets virtuels               │
└─────────────────────────────────────────────────────────────┘
```

### Explication Technique

#### 1. Architecture de Rendu Flutter Web

Flutter utilise **deux modes de rendu** qui ne produisent pas de HTML standard :

**Mode HTML (développement)** :
```html
<body>
  <flt-glass-pane>
    <flt-scene-host>
      <flt-semantics role="textbox" aria-label="email">
        <!-- Pas de <input type="email"> ici ! -->
        <!-- Input caché à position: absolute; top: -9999px -->
      </flt-semantics>
    </flt-scene-host>
  </flt-glass-pane>
</body>
```

**Mode CanvasKit (production)** :
```html
<body>
  <canvas id="canvas" width="1920" height="1080">
    <!-- TOUTE l'interface est dessinée pixel par pixel -->
    <!-- Aucun élément HTML accessible -->
  </canvas>
</body>
```

#### 2. Pourquoi Selenium Échoue

| Action Selenium | Ce qui se passe réellement |
|----------------|---------------------------|
| `driver.findElement(By.id("email"))` | ❌ **Élément inexistant** - Flutter génère `<flt-semantics>` |
| `element.sendKeys("admin@hospital.com")` | ❌ **Aucune saisie** - Le vrai input est caché ou virtuel |
| `driver.findElement(By.cssSelector("input[type='password']"))` | ❌ **NoSuchElementException** - Canvas ne contient pas d'input HTML |

**Schéma du problème** :

```
Selenium cherche :              Flutter génère :
┌─────────────────┐            ┌─────────────────────┐
│ <input id="email">│            │ <canvas>            │
│                 │            │   [UI dessinée]     │
│ <input type=    │     ←──X   │   • Email field     │
│   "password">   │            │   • Password field  │
│                 │            │   • Button          │
│ <button>Login   │            │ </canvas>           │
└─────────────────┘            └─────────────────────┘
    (N'existe pas dans le DOM réel)
```

#### 3. Impact des Modes de Rendu

| Mode | Description | Impact sur Selenium |
|------|-------------|---------------------|
| **HTML** | Widgets Flutter convertis en éléments HTML custom | ⚠️ Partiellement détectable mais Shadow DOM fermé |
| **CanvasKit** | Tout dessiné sur Canvas (comme un jeu vidéo) | ❌ Totalement invisible pour Selenium |
| **Auto** | Choix automatique (CanvasKit sur desktop) | ❌ Comportement imprévisible |

---

## ✅ Solution Recommandée : Architecture de Tests Hybride

### Principe de Séparation des Responsabilités

```
┌──────────────────────────────────────────────────────────────┐
│                  ARCHITECTURE DE TESTS                       │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Frontend (Flutter)          Backend (Spring Boot)          │
│  ├─ Unit Tests               ├─ Unit Tests                  │
│  │  └─ flutter test          │  └─ JUnit 5 + Mockito        │
│  │                           │                               │
│  ├─ Widget Tests             ├─ Integration Tests           │
│  │  └─ flutter test          │  └─ @SpringBootTest          │
│  │                           │                               │
│  └─ Integration Tests        └─ Code Quality                │
│     └─ integration_test          └─ SonarQube               │
│        (PAS Selenium !)                                      │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

### Outils par Couche

| Couche | Technologie | Outil de Test | Statut |
|--------|-------------|---------------|--------|
| **Backend API** | Spring Boot | JUnit + MockMvc + SonarQube | ✅ Fonctionne |
| **Frontend UI** | Flutter Web/Mobile | `integration_test` | ✅ Recommandé |
| **E2E API** | REST Endpoints | Postman / RestAssured | ✅ Optionnel |
| **E2E UI** | Flutter UI | ❌ **Pas Selenium** | ❌ Ne fonctionne pas |

---

## 🛠️ Implémentation : Tests Flutter avec `integration_test`

### Étape 1 : Configuration du Projet

**Ajouter la dépendance** :

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
```

**Structure des répertoires** :

```
hospital_app/
├── lib/
│   ├── main.dart
│   └── screens/
│       └── login_screen.dart
├── test/                      # Tests unitaires
│   └── unit/
│       ├── models_test.dart
│       └── services_test.dart
└── integration_test/          # Tests d'intégration
    ├── login_flow_test.dart
    ├── navigation_test.dart
    └── patient_crud_test.dart
```

### Étape 2 : Ajouter des Keys aux Widgets

**AVANT (non testable)** :

```dart
// ❌ Impossible de localiser avec integration_test
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: _handleLogin,
          child: Text('Login'),
        ),
      ],
    );
  }
}
```

**APRÈS (testable)** :

```dart
// ✅ Localisable avec find.byKey()
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          key: const Key('email_input'),  // ← KEY
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextField(
          key: const Key('password_input'),  // ← KEY
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        ElevatedButton(
          key: const Key('login_button'),  // ← KEY
          onPressed: _handleLogin,
          child: Text('Login'),
        ),
      ],
    );
  }
}
```

### Étape 3 : Test de Connexion Complet

```dart
// integration_test/login_flow_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hospital_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Flow - Hospital Dashboard', () {
    testWidgets('TC001 - Connexion valide avec redirection dashboard', 
        (WidgetTester tester) async {
      // ÉTAPE 1 : Lancer l'application
      app.main();
      await tester.pumpAndSettle();

      // ÉTAPE 2 : Localiser les champs (fonctionne avec Flutter !)
      final emailField = find.byKey(const Key('email_input'));
      final passwordField = find.byKey(const Key('password_input'));
      final loginButton = find.byKey(const Key('login_button'));

      // Vérifier que les éléments sont présents
      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(loginButton, findsOneWidget);

      // ÉTAPE 3 : Saisir les identifiants (ÇA FONCTIONNE !)
      await tester.enterText(emailField, 'admin@hospital.com');
      await tester.enterText(passwordField, 'password');
      await tester.pumpAndSettle();

      // ÉTAPE 4 : Vérifier que la saisie est visible
      expect(find.text('admin@hospital.com'), findsOneWidget);

      // ÉTAPE 5 : Cliquer sur Login
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // ÉTAPE 6 : Vérifier la redirection vers le dashboard
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.byKey(const Key('dashboard_screen')), findsOneWidget);
      
      // Vérifier l'URL (si navigation)
      // expect(tester.getUrl(), contains('/dashboard'));
    });

    testWidgets('TC002 - Connexion invalide affiche erreur', 
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Identifiants incorrects
      await tester.enterText(find.byKey(const Key('email_input')), 
          'wrong@email.com');
      await tester.enterText(find.byKey(const Key('password_input')), 
          'wrongpassword');
      
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

### Étape 4 : Tests de Navigation

```dart
// integration_test/navigation_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hospital_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Navigation Dashboard → Patients → Services', 
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Login
    await _performLogin(tester, 'admin@hospital.com', 'password');

    // Vérifier Dashboard
    expect(find.byKey(const Key('dashboard_screen')), findsOneWidget);

    // Naviguer vers Patients
    await tester.tap(find.text('Patients'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('patients_screen')), findsOneWidget);
    expect(find.text('Liste des Patients'), findsOneWidget);

    // Naviguer vers Services
    await tester.tap(find.text('Services'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('services_screen')), findsOneWidget);
    expect(find.text('Liste des Services'), findsOneWidget);
  });
}

// Helper function
Future<void> _performLogin(WidgetTester tester, String email, String password) async {
  await tester.enterText(find.byKey(const Key('email_input')), email);
  await tester.enterText(find.byKey(const Key('password_input')), password);
  await tester.tap(find.byKey(const Key('login_button')));
  await tester.pumpAndSettle(const Duration(seconds: 2));
}
```

### Étape 5 : Tests CRUD Patient

```dart
// integration_test/patient_crud_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hospital_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CRUD complet : Créer, Lire, Modifier, Supprimer Patient', 
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    await _performLogin(tester);

    // Naviguer vers Patients
    await tester.tap(find.text('Patients'));
    await tester.pumpAndSettle();

    // ===== CREATE =====
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('first_name_field')), 'Selenium');
    await tester.enterText(find.byKey(const Key('last_name_field')), 'Tester');
    await tester.enterText(find.byKey(const Key('email_field')), 'selenium@test.com');
    await tester.enterText(find.byKey(const Key('phone_field')), '0601020304');

    await tester.tap(find.byKey(const Key('save_button')));
    await tester.pumpAndSettle();

    // ===== READ =====
    expect(find.text('Selenium Tester'), findsOneWidget);

    // ===== UPDATE =====
    await tester.tap(find.text('Selenium Tester'));
    await tester.pumpAndSettle();
    
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('phone_field')), '0698765432');
    await tester.tap(find.byKey(const Key('save_button')));
    await tester.pumpAndSettle();

    expect(find.text('0698765432'), findsOneWidget);

    // ===== DELETE =====
    await tester.tap(find.text('Selenium Tester'));
    await tester.pumpAndSettle();
    
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    
    await tester.tap(find.text('Confirmer'));
    await tester.pumpAndSettle();

    expect(find.text('Selenium Tester'), findsNothing);
  });
}

Future<void> _performLogin(WidgetTester tester) async {
  await tester.enterText(find.byKey(const Key('email_input')), 'admin@hospital.com');
  await tester.enterText(find.byKey(const Key('password_input')), 'password');
  await tester.tap(find.byKey(const Key('login_button')));
  await tester.pumpAndSettle(const Duration(seconds: 2));
}
```

### Étape 6 : Exécution des Tests

```bash
# Test sur Chrome (Web)
flutter test integration_test/login_flow_test.dart -d chrome

# Test sur tous les scénarios
flutter test integration_test/ -d chrome

# Test sur Android
flutter test integration_test/ -d android

# Test avec rapport de couverture
flutter test integration_test/ --coverage
genhtml coverage/lcov.info -o coverage/html
```

---

## 🏗️ Architecture Globale de Tests

### Description Textuelle de l'Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     HOSPITAL DASHBOARD APP                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌────────────────────┐         ┌───────────────────────┐      │
│  │  FRONTEND          │         │  BACKEND              │      │
│  │  (Flutter)         │◄────────┤  (Spring Boot)        │      │
│  │                    │  REST   │                       │      │
│  │  Port: 3000        │  API    │  Port: 8080          │      │
│  └────────────────────┘         └───────────────────────┘      │
│           │                               │                     │
│           │ Tests                         │ Tests               │
│           ▼                               ▼                     │
│  ┌────────────────────┐         ┌───────────────────────┐      │
│  │ integration_test/  │         │ src/test/java/        │      │
│  │ ├─ login_test.dart │         │ ├─ Unit Tests         │      │
│  │ ├─ navigation.dart │         │ ├─ Integration Tests  │      │
│  │ └─ crud_test.dart  │         │ └─ MockMvc            │      │
│  └────────────────────┘         └───────────────────────┘      │
│           │                               │                     │
│           │                               ▼                     │
│           │                      ┌───────────────────────┐      │
│           │                      │  SonarQube            │      │
│           │                      │  ✅ Backend analysé   │      │
│           │                      └───────────────────────┘      │
│           │                                                     │
│           ▼                                                     │
│  ┌────────────────────────────────────────────────┐            │
│  │  Flutter Analyze + Dart Code Metrics          │            │
│  │  ⚠️ Import manuel dans SonarQube (LCOV)       │            │
│  └────────────────────────────────────────────────┘            │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Responsabilités par Couche

| Couche | Responsabilité | Outil | Statut |
|--------|----------------|-------|--------|
| **Backend Unit** | Logique métier Java | JUnit 5 + Mockito | ✅ |
| **Backend Integration** | API REST + DB | @SpringBootTest + TestContainers | ✅ |
| **Backend Quality** | Code smells, bugs, sécurité | SonarQube | ✅ |
| **Frontend Unit** | Widgets, Models, Services | flutter test | ✅ |
| **Frontend Integration** | Flux utilisateur complets | integration_test | ✅ |
| **Frontend Quality** | Linting, métriques | flutter analyze + DCM | ✅ |

---

## 🚀 Pipeline CI/CD Recommandé

### Structure GitHub Actions

```yaml
# .github/workflows/ci.yml
name: Hospital Dashboard CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  # ===== BACKEND =====
  backend-quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up JDK 17
        uses: actions/setup-java@v3
        with:
          java-version: '17'
          distribution: 'temurin'
      
      - name: Cache Maven packages
        uses: actions/cache@v3
        with:
          path: ~/.m2
          key: ${{ runner.os }}-m2-${{ hashFiles('**/pom.xml') }}
      
      - name: Build & Test Backend
        working-directory: backend
        run: mvn clean verify
      
      - name: SonarQube Analysis
        working-directory: backend
        run: |
          mvn sonar:sonar \
            -Dsonar.projectKey=hospital-backend \
            -Dsonar.host.url=${{ secrets.SONAR_HOST_URL }} \
            -Dsonar.login=${{ secrets.SONAR_TOKEN }}
      
      - name: Upload Test Results
        uses: actions/upload-artifact@v3
        with:
          name: backend-test-results
          path: backend/target/surefire-reports/

  # ===== FRONTEND =====
  frontend-quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          channel: 'stable'
      
      - name: Install Dependencies
        run: flutter pub get
      
      - name: Analyze Code
        run: flutter analyze --no-fatal-infos
      
      - name: Unit Tests
        run: flutter test test/ --coverage
      
      - name: Integration Tests (Chrome)
        run: |
          chromedriver --port=4444 &
          flutter test integration_test/ -d web-server --web-port=8080
      
      - name: Generate Coverage Report
        run: |
          sudo apt-get install -y lcov
          genhtml coverage/lcov.info -o coverage/html
      
      - name: Upload Coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info
          flags: flutter
          name: hospital-flutter
      
      - name: Upload Test Artifacts
        uses: actions/upload-artifact@v3
        with:
          name: flutter-test-results
          path: |
            coverage/
            test-results/

  # ===== DEPLOY (si tests passent) =====
  deploy-staging:
    needs: [backend-quality, frontend-quality]
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/develop'
    steps:
      - name: Deploy to Staging
        run: echo "Déploiement vers staging..."
```

---

## 📋 Bonnes Pratiques pour Tests Fiables

### 1. Éviter les Attentes Arbitraires

❌ **À éviter** :
```dart
await Future.delayed(Duration(seconds: 3)); // Fragile !
```

✅ **Recommandé** :
```dart
await tester.pumpAndSettle(); // Attend la fin des animations
await tester.pumpAndSettle(Duration(seconds: 5)); // Timeout max
```

### 2. Utiliser des Keys Uniques

❌ **À éviter** :
```dart
find.text('Email'); // Peut matcher plusieurs widgets
```

✅ **Recommandé** :
```dart
find.byKey(const Key('email_input')); // Unique et explicite
```

### 3. Tester les Cas d'Erreur

```dart
testWidgets('Affiche erreur si champ vide', (tester) async {
  app.main();
  await tester.pumpAndSettle();
  
  // Laisser les champs vides
  await tester.tap(find.byKey(const Key('login_button')));
  await tester.pumpAndSettle();
  
  // Vérifier le message d'erreur
  expect(find.text('Email requis'), findsOneWidget);
  expect(find.text('Mot de passe requis'), findsOneWidget);
});
```

### 4. Nettoyer les Données de Test

```dart
tearDown(() async {
  // Nettoyer les données créées pendant les tests
  await database.deleteTestData();
  await sharedPreferences.clear();
});
```

---

## ❌ Ce qu'il NE FAUT PAS faire

### 1. Utiliser Selenium pour Flutter

```java
// ❌ NE FONCTIONNE PAS
WebDriver driver = new ChromeDriver();
driver.get("http://localhost:3000");
driver.findElement(By.id("email")).sendKeys("admin@hospital.com");
// → NoSuchElementException car Flutter n'utilise pas de <input id="email">
```

### 2. Essayer de "Hacker" les Sélecteurs

```java
// ❌ FRAGILE ET INUTILE
WebElement input = driver.findElement(By.cssSelector("flt-semantics input"));
((JavascriptExecutor) driver).executeScript(
    "arguments[0].value = 'admin@hospital.com'", input
);
// → Ne fonctionne pas car Flutter gère l'état en interne
```

### 3. Mélanger les Responsabilités

```java
// ❌ MAUVAISE PRATIQUE
// Tester l'API backend avec Selenium
driver.get("http://localhost:8080/api/patients");
// → Utiliser RestAssured ou @SpringBootTest à la place
```

---

## ✅ Actions Immédiates

### 1. Abandonner Selenium pour Flutter (Priorité HAUTE)

```bash
# Archiver les tests Selenium Flutter
git mv selenium-tests/src/test/java/com/hospital/selenium/tests/HospitalApplicationTest.java \
       selenium-tests/ARCHIVE/

# Créer une note explicative
echo "Ces tests Selenium sont incompatibles avec Flutter Web.
Utiliser integration_test/ à la place." > selenium-tests/ARCHIVE/README.md
```

### 2. Créer la Structure integration_test

```bash
# Créer les répertoires
mkdir -p integration_test

# Créer les fichiers de test
touch integration_test/login_flow_test.dart
touch integration_test/navigation_test.dart
touch integration_test/patient_crud_test.dart
```

### 3. Ajouter les Keys dans le Code Flutter

```dart
// Identifier tous les widgets interactifs
// Ajouter const Key('nom_unique') à chacun
// Exemple : TextField(key: const Key('email_input'), ...)
```

### 4. Configurer le Pipeline CI/CD

```bash
# Créer le fichier GitHub Actions
mkdir -p .github/workflows
touch .github/workflows/ci.yml
# Copier le contenu du pipeline ci-dessus
```

---

## 📊 Comparaison des Approches

| Critère | Selenium + Flutter | integration_test |
|---------|-------------------|------------------|
| **Compatibilité** | ❌ Incompatible | ✅ Natif Flutter |
| **Fiabilité** | ❌ Échoue systématiquement | ✅ Tests stables |
| **Maintenance** | ❌ Impossible | ✅ Simple |
| **Performance** | ❌ Lent (navigateur réel) | ✅ Rapide |
| **Couverture** | ❌ 0% (ne fonctionne pas) | ✅ 100% du code Flutter |
| **Debugging** | ❌ Difficile | ✅ Intégré à VS Code |
| **Multi-plateforme** | ❌ Web uniquement | ✅ Web + Mobile + Desktop |

---

## 🎯 Conclusion

### Cause Racine

**Selenium ne peut pas tester Flutter** car :
- Flutter dessine l'interface sur Canvas ou utilise des éléments custom
- Pas d'éléments HTML standard (`<input>`, `<button>`)
- Shadow DOM fermé inaccessible

### Solution Professionnelle

1. **Backend (Spring Boot)** → Continuer avec JUnit + SonarQube ✅
2. **Frontend (Flutter)** → Migrer vers `integration_test` ✅
3. **Séparer les responsabilités** → Chaque technologie utilise ses outils natifs ✅

### Bénéfices

- ✅ Tests qui **fonctionnent réellement**
- ✅ Maintenance **simplifiée**
- ✅ Conformité aux **standards Flutter**
- ✅ **Fiabilité** pour un système hospitalier
- ✅ Pipeline CI/CD **automatisé**

### Prochaines Étapes

1. Archiver les tests Selenium Flutter
2. Créer les tests `integration_test`
3. Ajouter les Keys aux widgets
4. Configurer le pipeline CI/CD
5. Former l'équipe sur `flutter test`

---

**Remarque Importante** : Pour un système hospitalier, la **fiabilité des tests** est critique. L'utilisation d'outils inadaptés (Selenium pour Flutter) compromet la qualité et augmente les risques. L'adoption de `integration_test` garantit une couverture de test professionnelle et maintenable.
