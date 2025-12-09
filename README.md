# Clean Architecture Flutter App

A professional Flutter application demonstrating Clean Architecture principles with Riverpod state management.

## 🏗️ Architecture

This project follows **Clean Architecture** with a feature-first approach:

```
lib/
├── core/                    # Shared infrastructure
│   ├── network/            # Dio HTTP client
│   ├── router/             # GoRouter configuration
│   └── theme/              # App theming (Light/Dark)
├── features/               # Feature modules
│   ├── auth/              # Authentication feature
│   │   ├── data/          # Repository implementations, data sources
│   │   ├── domain/        # Entities, repository interfaces
│   │   └── presentation/  # UI, controllers, providers
│   ├── home/              # Home dashboard
│   └── items/             # Items list & detail
└── main.dart              # App entry point
```

### Key Principles

- **Separation of Concerns**: Each layer has a single responsibility
- **Dependency Inversion**: Domain layer doesn't depend on data/presentation
- **Testability**: Mock implementations for easy testing
- **Scalability**: Feature-first structure allows easy addition of new features

## 🚀 Features

- ✅ **Authentication** with form validation
- ✅ **Light/Dark Theme** toggle
- ✅ **Items List** with pull-to-refresh
- ✅ **Item Details** view
- ✅ **Declarative Routing** with GoRouter
- ✅ **State Management** with Riverpod
- ✅ **Mock API** for immediate testing
- ✅ **Unit & Widget Tests**

## 📦 Tech Stack

| Category | Package |
|----------|---------|
| State Management | `flutter_riverpod`, `riverpod_annotation` |
| Routing | `go_router` |
| HTTP Client | `dio` |
| Code Generation | `freezed`, `json_serializable`, `build_runner` |
| UI | `google_fonts` |
| Testing | `mocktail` |

## 🛠️ Setup

### Prerequisites

- Flutter SDK 3.9.2 or higher
- Dart 3.9.2 or higher

### Installation

1. **Clone the repository**
   ```bash
   cd flutter-project
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   # Web
   flutter run -d chrome
   
   # Windows
   flutter run -d windows
   
   # Android/iOS
   flutter run
   ```

## 🧪 Testing

Run all tests:
```bash
flutter test
```

Run specific test:
```bash
flutter test test/unit/login_controller_test.dart
```

## 📱 Usage

### Authentication

- **Email**: Any email
- **Password**: `password` (hardcoded in mock)

### Navigation Flow

1. Login Screen → Home Dashboard
2. Home → Items List
3. Items List → Item Detail

### Theme Toggle

Access theme settings from the app (can be extended with a settings screen).

## 🔧 Development

### Adding a New Feature

1. Create feature directory: `lib/features/my_feature/`
2. Add layers: `data/`, `domain/`, `presentation/`
3. Define entities in `domain/`
4. Implement repository in `data/`
5. Create UI in `presentation/`
6. Add routes in `core/router/app_router.dart`

### Code Generation

After modifying files with `@freezed`, `@riverpod`, or `@JsonSerializable`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

For continuous generation during development:
```bash
dart run build_runner watch
```

## 📊 SonarQube Compliance

This project follows best practices for SonarQube analysis:

- ✅ Proper code organization
- ✅ No code duplication
- ✅ Comprehensive test coverage
- ✅ Clear naming conventions
- ✅ Documented code structure

## 🎨 Reusable Components

The project includes reusable patterns:

- **Providers**: Centralized state management
- **Repository Pattern**: Abstracted data layer
- **Form Validation**: Reusable validators
- **Error Handling**: Consistent error states

## 📄 License

This project is created for demonstration purposes.

## 🤝 Contributing

1. Follow the existing architecture
2. Write tests for new features
3. Run `flutter analyze` before committing
4. Ensure all tests pass

---

**Built with ❤️ using Flutter & Clean Architecture**
