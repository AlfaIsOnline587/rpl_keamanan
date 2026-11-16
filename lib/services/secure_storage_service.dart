import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/logger.dart';

class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
    Logger.info('Secure storage write completed.');
  }

  Future<String?> read(String key) async {
    final value = await _storage.read(key: key);
    Logger.debug('Secure storage read completed.');
    return value;
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
    Logger.info('Secure storage delete completed.');
  }
}
