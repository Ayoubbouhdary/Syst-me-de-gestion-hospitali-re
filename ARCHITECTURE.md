# Project Structure Documentation

## Overview

This Flutter project follows **Clean Architecture** principles with a **feature-first** organization strategy. Each feature is self-contained with its own data, domain, and presentation layers.

## Directory Structure

```
flutter-project/
├── lib/
│   ├── core/                      # Shared infrastructure & utilities
│   │   ├── network/
│   │   │   └── dio_provider.dart  # HTTP client configuration
│   │   ├── router/
│   │   │   └── app_router.dart    # App-wide routing configuration
│   │   └── theme/
│   │       ├── app_theme.dart     # Theme definitions (Light/Dark)
│   │       └── theme_provider.dart # Theme state management
│   │
│   ├── features/                  # Feature modules
│   │   ├── auth/                  # Authentication feature
│   │   │   ├── data/
│   │   │   │   └── auth_repository_impl.dart  # Mock auth implementation
│   │   │   ├── domain/
│   │   │   │   ├── user.dart              # User entity
│   │   │   │   └── auth_repository.dart   # Repository interface
│   │   │   └── presentation/
│   │   │       ├── auth_providers.dart    # Riverpod providers
│   │   │       └── login_screen.dart      # Login UI
│   │   │
│   │   ├── home/                  # Home dashboard
│   │   │   └── presentation/
│   │   │       └── home_screen.dart
│   │   │
│   │   └── items/                 # Items list & detail feature
│   │       ├── data/
│   │       │   └── items_repository_impl.dart
│   │       ├── domain/
│   │       │   ├── item.dart
│   │       │   └── items_repository.dart
│   │       └── presentation/
│   │           ├── items_providers.dart
│   │           ├── items_list_screen.dart
│   │           └── item_detail_screen.dart
│   │
│   └── main.dart                  # Application entry point
│
├── test/                          # Test files
│   ├── unit/
│   │   └── login_controller_test.dart
│   └── widget/
│       └── login_screen_test.dart
│
├── pubspec.yaml                   # Dependencies
├── analysis_options.yaml          # Linting rules
└── README.md                      # Project documentation
```

## Layer Responsibilities

### 1. Domain Layer (`domain/`)
**Purpose**: Business logic and entities

- **Entities**: Pure Dart classes representing business objects (e.g., `User`, `Item`)
- **Repository Interfaces**: Abstract contracts for data operations
- **No dependencies** on Flutter or external packages (except annotations)

**Example**:
```dart
// domain/user.dart
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String name,
  }) = _User;
}

// domain/auth_repository.dart
abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<void> logout();
}
```

### 2. Data Layer (`data/`)
**Purpose**: Data sources and repository implementations

- **Repository Implementations**: Concrete implementations of domain interfaces
- **Data Sources**: API clients, local storage, etc.
- **DTOs/Models**: Data transfer objects (if different from entities)

**Example**:
```dart
// data/auth_repository_impl.dart
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User> login(String email, String password) async {
    // Mock implementation
    await Future.delayed(Duration(seconds: 1));
    return User(id: '1', email: email, name: 'Test User');
  }
}
```

### 3. Presentation Layer (`presentation/`)
**Purpose**: UI and state management

- **Screens/Pages**: Flutter widgets
- **Providers**: Riverpod state management
- **Controllers**: Business logic for UI

**Example**:
```dart
// presentation/auth_providers.dart
@riverpod
class LoginController extends _$LoginController {
  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).login(email, password)
    );
  }
}
```

### 4. Core Layer (`core/`)
**Purpose**: Shared utilities and configuration

- **Network**: HTTP client setup
- **Router**: Navigation configuration
- **Theme**: App-wide theming
- **Constants**: Shared constants
- **Utilities**: Helper functions

## Code Generation

This project uses code generation for:

1. **Freezed** (`*.freezed.dart`): Immutable data classes with copyWith, equality
2. **JSON Serializable** (`*.g.dart`): JSON serialization/deserialization
3. **Riverpod Generator** (`*.g.dart`): Type-safe providers

**Generate code**:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Dependency Flow

```
Presentation → Domain ← Data
     ↓           ↑
   Core ←────────┘
```

- **Presentation** depends on Domain (uses entities and repository interfaces)
- **Data** implements Domain interfaces
- **Domain** has no dependencies (pure business logic)
- **Core** is used by all layers

## Testing Strategy

### Unit Tests (`test/unit/`)
- Test repository implementations
- Test business logic in controllers
- Use mocks for dependencies

### Widget Tests (`test/widget/`)
- Test UI components
- Test user interactions
- Test form validation

### Integration Tests (Future)
- Test complete user flows
- Test navigation
- Test state persistence

## Best Practices

1. **Single Responsibility**: Each class has one clear purpose
2. **Dependency Injection**: Use Riverpod providers for DI
3. **Immutability**: Use `@freezed` for data classes
4. **Type Safety**: Leverage Dart's strong typing
5. **Error Handling**: Use `AsyncValue` for async operations
6. **Testing**: Write tests for critical paths
7. **Code Generation**: Automate boilerplate with build_runner

## Adding New Features

1. Create feature folder: `lib/features/my_feature/`
2. Add domain layer: entities and repository interfaces
3. Add data layer: repository implementation
4. Add presentation layer: UI and providers
5. Register routes in `core/router/app_router.dart`
6. Run code generation
7. Write tests

## SonarQube Compliance

The project structure supports SonarQube analysis:

- Clear separation of concerns
- Testable architecture
- No circular dependencies
- Consistent naming conventions
- Proper error handling
- Code documentation
