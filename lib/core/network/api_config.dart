/// Configuration de l'API backend
class ApiConfig {
  /// URL de base du backend - TOUJOURS localhost:8081
  static const String baseUrl = 'http://localhost:8081';

  /// Timeout pour les requêtes HTTP (en secondes)
  static const int timeout = 30;
}
