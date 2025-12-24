# Selenium + Flutter : Limitation Technique et Solution

## ⚠️ Problème : Limitation Architecturale

### Pourquoi Selenium ne fonctionne pas avec Flutter Web

**Cause racine** : **Incompatibilité fondamentale entre l'architecture de Selenium et le rendu Flutter**.

```
Selenium WebDriver          Flutter Web
─────────────────          ───────────
Cherche : <input>     ←─X─→  Génère : <canvas> ou <flt-semantics>
Méthode : sendKeys()         Rendu : Pixels dessinés
DOM : HTML standard          DOM : Custom elements
```

### Architecture de Flutter Web

Flutter utilise **deux modes de rendu** incompatibles avec Selenium :

**1. Mode CanvasKit (Production)** :
```html
<canvas id="canvas" width="1920" height="1080">
  <!-- TOUTE l'interface est dessinée pixel par pixel -->
  <!-- Pas de <input>, <button>, rien -->
</canvas>
```

**2. Mode HTML (Développement)** :
```html
<flt-glass-pane>
  <flt-semantics role="textbox">
    <input style="position: absolute; top: -9999px;"> <!-- Caché ! -->
  </flt-semantics>
</flt-glass-pane>
```

### Conséquence Technique

```java
// ❌ Ce code NE FONCTIONNE PAS avec Flutter
driver.findElement(By.cssSelector("input[type='email']"));
// → NoSuchElementException : l'élément n'existe pas dans le DOM

element.sendKeys("admin@hospital.com");
// → Ne tape rien : l'input réel est caché ou virtuel
```

**Verdict** : Selenium ne peut pas tester Flutter. Ce n'est pas un bug, c'est une **limitation architecturale**.

---

## ✅ Solution Professionnelle : integration_test

### Stratégie de Tests pour Projet Hospitalier

```
┌──────────────────────────────────────────────────┐
│  BACKEND (Spring Boot)                           │
│  ✅ JUnit 5 + Mockito                            │
│  ✅ @SpringBootTest                              │
│  ✅ SonarQube                                    │
└──────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────┐
│  FRONTEND (Flutter)                              │
│  ✅ flutter analyze                              │
│  ✅ flutter test (unit)                          │
│  ✅ integration_test (E2E)                       │
└──────────────────────────────────────────────────┘
```

---

## 🛠️ Implémentation : Test de Login Flutter

### Étape 1 : Configuration

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
```

### Étape 2 : Ajouter des Keys aux Widgets

**AVANT (non testable)** :
```dart
// lib/screens/login_screen.dart
TextField(
  decoration: InputDecoration(labelText: 'Email'),
  controller: _emailController,
)
```

**APRÈS (testable)** :
```dart
TextField(
  key: const Key('email_input'),  // ← AJOUTER
  decoration: InputDecoration(labelText: 'Email'),
  controller: _emailController,
)

TextField(
  key: const Key('password_input'),  // ← AJOUTER
  decoration: InputDecoration(labelText: 'Mot de passe'),
  controller: _passwordController,
  obscureText: true,
)

ElevatedButton(
  key: const Key('login_button'),  // ← AJOUTER
  onPressed: _handleLogin,
  child: Text('Se connecter'),
)
```

### Étape 3 : Test de Login Fonctionnel

```dart
// integration_test/login_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hospital_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login avec identifiants valides', (tester) async {
    // 1. Lancer l'application
    app.main();
    await tester.pumpAndSettle();

    // 2. Localiser les champs (fonctionne avec Flutter !)
    final emailField = find.byKey(const Key('email_input'));
    final passwordField = find.byKey(const Key('password_input'));
    final loginButton = find.byKey(const Key('login_button'));

    // Vérifier la présence
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);

    // 3. Saisir les identifiants (ÇA FONCTIONNE !)
    await tester.enterText(emailField, 'admin@hospital.com');
    await tester.enterText(passwordField, 'password');
    await tester.pumpAndSettle();

    // 4. Vérifier la saisie
    expect(find.text('admin@hospital.com'), findsOneWidget);

    // 5. Cliquer sur Login
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // 6. Vérifier la redirection
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.byKey(const Key('dashboard_screen')), findsOneWidget);
  });

  testWidgets('Login avec identifiants invalides', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('email_input')), 
      'wrong@email.com'
    );
    await tester.enterText(
      find.byKey(const Key('password_input')), 
      'wrongpassword'
    );
    await tester.tap(find.byKey(const Key('login_button')));
    await tester.pumpAndSettle();

    // Vérifier l'erreur
    expect(find.text('Identifiants incorrects'), findsOneWidget);
  });
}
```

### Étape 4 : Exécution

```bash
# Tester sur Chrome
flutter test integration_test/login_test.dart -d chrome

# Tester sur tous les navigateurs
flutter test integration_test/ -d chrome
flutter test integration_test/ -d edge

# Mobile
flutter test integration_test/ -d android
```

---

## 📋 Tests CRUD Complets

```dart
// integration_test/patient_crud_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hospital_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CRUD Patient complet', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    
    // Login
    await _login(tester);
    
    // Naviguer vers Patients
    await tester.tap(find.text('Patients'));
    await tester.pumpAndSettle();

    // CREATE
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    
    await tester.enterText(find.byKey(const Key('first_name')), 'Jean');
    await tester.enterText(find.byKey(const Key('last_name')), 'Dupont');
    await tester.enterText(find.byKey(const Key('email')), 'jean@test.com');
    await tester.tap(find.byKey(const Key('save_button')));
    await tester.pumpAndSettle();

    // READ
    expect(find.text('Jean Dupont'), findsOneWidget);

    // UPDATE
    await tester.tap(find.text('Jean Dupont'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();
    
    await tester.enterText(find.byKey(const Key('email')), 'jean.dupont@test.com');
    await tester.tap(find.byKey(const Key('save_button')));
    await tester.pumpAndSettle();
    
    expect(find.text('jean.dupont@test.com'), findsOneWidget);

    // DELETE
    await tester.tap(find.text('Jean Dupont'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Confirmer'));
    await tester.pumpAndSettle();
    
    expect(find.text('Jean Dupont'), findsNothing);
  });
}

Future<void> _login(WidgetTester tester) async {
  await tester.enterText(find.byKey(const Key('email_input')), 'admin@hospital.com');
  await tester.enterText(find.byKey(const Key('password_input')), 'password');
  await tester.tap(find.byKey(const Key('login_button')));
  await tester.pumpAndSettle();
}
```

---

## 🏗️ Architecture de Tests Complète

### Backend (Spring Boot)

```java
// src/test/java/com/hospital/service/PatientServiceTest.java
@SpringBootTest
class PatientServiceTest {
    
    @Autowired
    private PatientService patientService;
    
    @Test
    void shouldCreatePatient() {
        Patient patient = new Patient("Jean", "Dupont", "jean@test.com");
        Patient saved = patientService.save(patient);
        assertNotNull(saved.getId());
        assertEquals("Jean", saved.getFirstName());
    }
}
```

```xml
<!-- pom.xml -->
<build>
    <plugins>
        <plugin>
            <groupId>org.sonarsource.scanner.maven</groupId>
            <artifactId>sonar-maven-plugin</artifactId>
        </plugin>
    </plugins>
</build>
```

```bash
# Exécuter les tests backend
mvn clean verify

# Analyse SonarQube
mvn sonar:sonar \
  -Dsonar.projectKey=hospital-backend \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=your-token
```

### Frontend (Flutter)

```yaml
# analysis_options.yaml
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
```

```bash
# Analyse statique
flutter analyze

# Tests unitaires
flutter test test/

# Tests d'intégration
flutter test integration_test/ -d chrome

# Couverture de code
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

---

## 🚀 Pipeline CI/CD

```yaml
# .github/workflows/ci.yml
name: Hospital Dashboard CI

on: [push, pull_request]

jobs:
  backend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-java@v3
        with:
          java-version: '17'
      
      - name: Backend Tests + SonarQube
        working-directory: backend
        run: |
          mvn clean verify sonar:sonar \
            -Dsonar.projectKey=hospital-backend \
            -Dsonar.host.url=${{ secrets.SONAR_URL }} \
            -Dsonar.login=${{ secrets.SONAR_TOKEN }}

  frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      
      - name: Flutter Analyze
        run: flutter analyze
      
      - name: Unit Tests
        run: flutter test test/ --coverage
      
      - name: Integration Tests
        run: flutter test integration_test/ -d chrome
      
      - name: Upload Coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info
```

---

## 📊 Résumé : Selenium vs integration_test

| Critère | Selenium + Flutter | integration_test |
|---------|-------------------|------------------|
| **Fonctionne** | ❌ Non | ✅ Oui |
| **Saisie visible** | ❌ Non | ✅ Oui |
| **Multi-plateforme** | ❌ Web uniquement | ✅ Web + Mobile + Desktop |
| **Maintenance** | ❌ Impossible | ✅ Simple |
| **Fiabilité** | ❌ 0% | ✅ 100% |

---

## ✅ Actions Immédiates

### 1. Abandonner Selenium pour Flutter

```bash
# Archiver les tests Selenium Flutter
mkdir selenium-tests/ARCHIVE
mv selenium-tests/src/test/java/com/hospital/selenium/tests/HospitalApplicationTest.java \
   selenium-tests/ARCHIVE/

echo "❌ Selenium ne fonctionne pas avec Flutter.
✅ Utiliser integration_test/ à la place." > selenium-tests/ARCHIVE/README.txt
```

### 2. Créer les tests Flutter

```bash
# Créer la structure
mkdir integration_test
touch integration_test/login_test.dart
touch integration_test/navigation_test.dart
touch integration_test/patient_crud_test.dart
```

### 3. Ajouter les Keys

Identifier tous les widgets interactifs dans votre code Flutter et ajouter :
```dart
key: const Key('nom_unique')
```

### 4. Tester

```bash
flutter test integration_test/login_test.dart -d chrome
```

---

## 🎯 Conclusion

### Pourquoi Selenium échoue
- Flutter dessine l'UI sur Canvas, pas en HTML
- Pas de `<input>` réels dans le DOM
- Shadow DOM fermé inaccessible

### Solution Professionnelle
- **Backend** : JUnit + SonarQube ✅
- **Frontend** : `integration_test` + `flutter analyze` ✅
- **Séparation claire** : Chaque technologie utilise ses outils natifs

### Bénéfices pour un Système Hospitalier
- ✅ Tests fiables et maintenables
- ✅ Couverture de code mesurable
- ✅ Conformité aux standards Flutter/Spring Boot
- ✅ CI/CD automatisé
- ✅ Qualité adaptée à un contexte critique (santé)

**Prochaine étape** : Créer votre premier test `integration_test/login_test.dart` et ajouter les Keys aux widgets Flutter.
