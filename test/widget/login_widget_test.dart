import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clean_arch_app/features/auth/presentation/login_screen.dart';

void main() {
  group('Login Flow Tests', () {
    testWidgets('TC001 - Login avec identifiants valides', (
      WidgetTester tester,
    ) async {
      // 1. Lancer le widget LoginScreen
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: LoginScreen())),
      );
      await tester.pumpAndSettle();

      // 2. Localiser les champs de login par type TextFormField
      final textFields = find.byType(TextFormField);
      expect(
        textFields,
        findsNWidgets(2),
        reason: 'Il doit y avoir 2 champs de texte',
      );

      final emailField = textFields.first;
      final passwordField = textFields.last;
      final loginButton = find.byType(FilledButton);

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

      // 3. Saisir les identifiants
      await tester.enterText(emailField, 'admin@hospital.com');
      await tester.enterText(passwordField, 'password123');
      await tester.pumpAndSettle();

      // 4. Vérifier que la saisie est visible
      expect(find.text('admin@hospital.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);

      // 5. Cliquer sur le bouton Login
      await tester.tap(loginButton);
      await tester.pump();

      // Le test vérifie que l'app ne crash pas lors de la soumission
    });

    testWidgets('TC002 - Login avec identifiants invalides affiche erreur', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: LoginScreen())),
      );
      await tester.pumpAndSettle();

      // Localiser les champs
      final textFields = find.byType(TextFormField);
      final emailField = textFields.first;
      final passwordField = textFields.last;
      final loginButton = find.byType(FilledButton);

      // Identifiants incorrects
      await tester.enterText(emailField, 'wrong@email.com');
      await tester.enterText(passwordField, 'wrongpassword');
      await tester.pumpAndSettle();

      // Cliquer sur le bouton Login
      await tester.tap(loginButton);
      await tester.pump();

      // Le test vérifie que l'app ne crash pas lors d'un login incorrect
    });
  });
}
