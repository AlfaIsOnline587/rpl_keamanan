/// Konfigurasi API yang dapat diberikan saat build/run.
class AppConfig {
  /// URL API demo digunakan jika `BASE_URL` belum diatur.
  static const String defaultBaseUrl = 'https://jsonplaceholder.typicode.com/';

  /// Gunakan `--dart-define=BASE_URL=...` untuk mengganti URL API.
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: defaultBaseUrl,
  );

  /// Untuk API key non-rahasia; rahasia harus disimpan di backend/proxy.
  static const String apiKey = String.fromEnvironment('API_KEY');

  /// Timeout untuk request HTTP (dalam detik).
  static const int timeoutSeconds = 10;
}
