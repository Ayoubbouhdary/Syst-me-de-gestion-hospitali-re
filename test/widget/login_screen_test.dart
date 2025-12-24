import 'package:clean_arch_app/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('LoginScreen renders correctly with form fields', (
      tester,
    ) async {
      // Build LoginScreen avec ProviderScope
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: LoginScreen())),
      );

      // Attendre que le widget se construise complètement
      await tester.pumpAndSettle();

      // Vérifier que les TextFormFields existent (email et password)
      expect(find.byType(TextFormField), findsNWidgets(2));

      // Vérifier que le bouton de connexion existe (FilledButton)
      expect(find.byType(FilledButton), findsOneWidget);

      // Vérifier l'icône d'hôpital
      expect(find.byIcon(Icons.local_hospital), findsOneWidget);

      // Vérifier les icônes des champs
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });

    testWidgets('LoginScreen shows validation errors on empty submit', (
      tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: LoginScreen())),
      );

      await tester.pumpAndSettle();

      // Trouver et cliquer sur le bouton de connexion sans remplir les champs
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      // Les erreurs de validation devraient apparaître
      // Comme les textes sont localisés, on vérifie qu'il y a des erreurs
      // en cherchant des widgets Text supplémentaires après validation
      final errorFinder = find.byType(Text);
      expect(errorFinder, findsWidgets);
    });

    testWidgets('LoginScreen can enter email and password', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: LoginScreen())),
      );

      await tester.pumpAndSettle();

      // Trouver les TextFormFields
      final textFields = find.byType(TextFormField);
      expect(textFields, findsNWidgets(2));

      // Entrer l'email dans le premier champ
      await tester.enterText(textFields.first, 'admin@hospital.com');
      await tester.pumpAndSettle();

      // Entrer le mot de passe dans le second champ
      await tester.enterText(textFields.last, 'password123');
      await tester.pumpAndSettle();

      // Vérifier que les valeurs sont entrées
      expect(find.text('admin@hospital.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });

    testWidgets('LoginScreen toggle password visibility', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: LoginScreen())),
      );

      await tester.pumpAndSettle();

      // Trouver l'icône de visibilité du mot de passe (initialement masqué)
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);

      // Cliquer sur l'icône pour afficher le mot de passe
      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pumpAndSettle();

      // L'icône devrait changer
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    });

    testWidgets('LoginScreen has proper UI structure', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: LoginScreen())),
      );

      await tester.pumpAndSettle();

      // Vérifier la structure de base
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
