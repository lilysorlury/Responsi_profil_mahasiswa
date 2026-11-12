import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Class untuk mengelola konfigurasi aplikasi dari file .env.
class AppConfig {
  /// URL dasar API yang digunakan aplikasi.
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  /// API Key untuk kebutuhan konfigurasi API.
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}
