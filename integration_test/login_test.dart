import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:clean_arch_app/main.dart' as app;
    as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Flow Tests', () {
    testWidgets('TC001 - Login avec identifiants valides', (
      WidgetTester tester,
    ) async {
      // 1. Lancer l'application
      app.main();
      await tester.pumpAndSettle();

      // 2. Localiser les champs de login
      // TODO: Ajouter const Key('email_input') à votre TextField email
      final emailField = find.byKey(const Key('email_input'));
      final passwordField = find.byKey(const Key('password_input'));
      final loginButton = find.byKey(const Key('login_button'));

      // Vérifier que les éléments sont présents
      expect(
        emailField,
        findsOneWidget,
        reason: 'Le champ email doit être présent',
      );
      expect(
        passwordField,
        findsOneWidget,
        reason: 'Le champ password doit être présent',
      );
      expect(
        loginButton,
        findsOneWidget,
        reason: 'Le bouton login doit être présent',
      );

      // 3. Saisir les identifiants (ÇA FONCTIONNE avec Flutter !)
      await tester.enterText(emailField, 'admin@hospital.com');
      await tester.enterText(passwordField, 'password');
      await tester.pumpAndSettle();

      // 4. Vérifier que la saisie est visible
      expect(find.text('admin@hospital.com'), findsOneWidget);

      // 5. Cliquer sur le bouton Login
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // 6. Vérifier la redirection vers le dashboard
      // TODO: Ajouter const Key('dashboard_screen') à votre écran dashboard
      expect(
        find.byKey(const Key('dashboard_screen')),
        findsOneWidget,
        reason: 'Devrait être redirigé vers le dashboard',
      );

      // OU vérifier la présence d'un texte spécifique
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('TC002 - Login avec identifiants invalides affiche erreur', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      // Identifiants incorrects
      await tester.enterText(
        find.byKey(const Key('email_input')),
        'wrong@email.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_input')),
        'wrongpassword',
      );

      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Vérifier que l'erreur est affichée
      // TODO: Adapter selon votre message d'erreur réel
      expect(
        find.textContaining('Identifiants'),
        findsOneWidget,
        reason: 'Un message d\'erreur doit être affiché',
      );

      // Toujours sur la page de login
      expect(find.byKey(const Key('login_screen')), findsOneWidget);
    });
  });
}
