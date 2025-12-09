import 'package:clean_arch_app/features/auth/domain/auth_repository.dart';
import 'package:clean_arch_app/features/auth/domain/user.dart';
import 'package:clean_arch_app/features/auth/presentation/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late ProviderContainer container;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('LoginController login success', () async {
    const email = 'test@example.com';
    const password = 'password';
    final user = User(id: '1', email: email, name: 'Test User');

    when(() => mockAuthRepository.login(email, password))
        .thenAnswer((_) async => user);

    final controller = container.read(loginControllerProvider.notifier);

    await controller.login(email, password);

    verify(() => mockAuthRepository.login(email, password)).called(1);
    expect(container.read(loginControllerProvider), isA<AsyncData>());
  });

  test('LoginController login failure', () async {
    const email = 'test@example.com';
    const password = 'wrong';

    when(() => mockAuthRepository.login(email, password))
        .thenThrow(Exception('Invalid credentials'));

    final controller = container.read(loginControllerProvider.notifier);

    await controller.login(email, password);

    verify(() => mockAuthRepository.login(email, password)).called(1);
    expect(container.read(loginControllerProvider), isA<AsyncError>());
  });
}
