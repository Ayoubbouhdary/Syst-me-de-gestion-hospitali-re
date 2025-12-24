# Tests d'Intégration Flutter

## Structure

```
integration_test/
├── login_test.dart           # Tests de connexion ✅
├── navigation_test.dart      # Tests de navigation (TODO)
└── patient_crud_test.dart    # Tests CRUD Patient (TODO)
```

## Prérequis

### 1. Ajouter la dépendance

Dans `pubspec.yaml` :

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
```

### 2. Ajouter des Keys aux widgets

**IMPORTANT** : Pour que les tests fonctionnent, vous devez ajouter des `Key` à vos widgets Flutter.

Exemple dans `lib/screens/login_screen.dart` :

```dart
// Champ Email
TextField(
  key: const Key('email_input'),  // ← AJOUTER
  decoration: InputDecoration(labelText: 'Email'),
  controller: _emailController,
)

// Champ Password
TextField(
  key: const Key('password_input'),  // ← AJOUTER
  decoration: InputDecoration(labelText: 'Mot de passe'),
  controller: _passwordController,
  obscureText: true,
)

// Bouton Login
ElevatedButton(
  key: const Key('login_button'),  // ← AJOUTER
  onPressed: _handleLogin,
  child: Text('Se connecter'),
)

// Écran Dashboard
Scaffold(
  key: const Key('dashboard_screen'),  // ← AJOUTER
  appBar: AppBar(title: Text('Dashboard')),
  body: ...,
)
```

## Exécution des Tests

### Web (Chrome)

```bash
flutter test integration_test/login_test.dart -d chrome
```

### Web (Edge)

```bash
flutter test integration_test/login_test.dart -d edge
```

### Mobile (Android)

```bash
flutter test integration_test/login_test.dart -d android
```

### Tous les tests

```bash
flutter test integration_test/
```

## Résolution de Problèmes

### Erreur : "findsNothing" au lieu de "findsOneWidget"

**Cause** : La Key n'existe pas dans votre code Flutter.

**Solution** : Ajoutez `key: const Key('nom_widget')` au widget concerné.

### Erreur : "package does not exist"

**Cause** : Le nom du package dans l'import ne correspond pas.

**Solution** : Vérifiez le `name:` dans `pubspec.yaml` et ajustez l'import :

```dart
import 'package:votre_nom_de_package/main.dart' as app;
```

### Le test timeout

**Cause** : L'application met du temps à charger.

**Solution** : Augmentez le timeout :

```dart
await tester.pumpAndSettle(const Duration(seconds: 10));
```

## Prochaines Étapes

1. ✅ Ajoutez les Keys aux widgets Flutter
2. ✅ Exécutez `flutter pub get`
3. ✅ Lancez `flutter test integration_test/login_test.dart -d chrome`
4. ⏳ Créez les tests de navigation
5. ⏳ Créez les tests CRUD

## Documentation

Voir : `docs/SELENIUM_FLUTTER_SOLUTION_FINALE.md`
