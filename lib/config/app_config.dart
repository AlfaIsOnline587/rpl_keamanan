import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Konfigurasi API yang dapat diubah melalui file `.env`.
class AppConfig {
  /// URL API demo digunakan jika `BASE_URL` belum diatur.
  static const String defaultBaseUrl = 'https://jsonplaceholder.typicode.com/';

  /// Base URL API, dengan API demo sebagai nilai bawaan.
  static String get baseUrl {
    final configuredUrl = dotenv.isInitialized
        ? dotenv.env['BASE_URL']?.trim()
        : null;
    return configuredUrl == null || configuredUrl.isEmpty
        ? defaultBaseUrl
        : configuredUrl;
  }

  /// API key bersifat opsional untuk API demo.
  static String get apiKey {
    if (!dotenv.isInitialized) return '';
    return dotenv.env['API_KEY']?.trim() ?? '';
  }

  /// Timeout untuk request HTTP (dalam detik).
  static const int timeoutSeconds = 10;
}
