import 'dart:async';
import '../domain/auth_repository.dart';
import '../domain/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _controller = StreamController<User?>.broadcast();
  User? _currentUser;

  @override
  Stream<User?> get authStateChanges => _controller.stream;

  @override
  User? get currentUser => _currentUser;

  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    if (password == 'password') { // Simple mock validation
      final user = User(id: '1', email: email, name: 'Test User');
      _currentUser = user;
      _controller.add(user);
      return user;
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    _controller.add(null);
  }
}
