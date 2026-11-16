import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:rpl_keamanan/services/api_service.dart';

void main() {
  test('converts HTTP client errors to a safe ApiException', () async {
    final service = ApiService(
      client: MockClient((_) async {
        throw http.ClientException('private transport details');
      }),
      baseUrl: 'https://example.test',
    );

    await expectLater(
      service.getPosts(),
      throwsA(
        isA<ApiException>().having(
          (error) => error.message,
          'message',
          'Tidak dapat menghubungi server. Silakan coba lagi nanti.',
        ),
      ),
    );
    service.dispose();
  });

  test('does not expose unexpected error details', () async {
    final service = ApiService(
      client: MockClient((_) async {
        throw StateError('private internal details');
      }),
      baseUrl: 'https://example.test',
    );

    await expectLater(
      service.getPosts(),
      throwsA(
        isA<ApiException>().having(
          (error) => error.message,
          'message',
          'Terjadi kesalahan saat menghubungi server. Silakan coba lagi nanti.',
        ),
      ),
    );
    service.dispose();
  });
}
