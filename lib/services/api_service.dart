import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../utils/logger.dart';

/// Service untuk komunikasi HTTP dengan REST API.
///
/// Class ini menangani semua request HTTP ke API, termasuk
/// penanganan error dan timeout.
class ApiService {
  ApiService({http.Client? client, String? baseUrl})
    : _client = client ?? http.Client(),
      _baseUrl = baseUrl ?? AppConfig.baseUrl;

  final http.Client _client;
  final String _baseUrl;

  /// Mengambil daftar pengguna dari API.
  Future<List<User>> getUsers() async {
    final data = await _getJson('users');
    if (data is! List) {
      throw const ApiException('Format daftar pengguna tidak valid.');
    }

    return data.map((item) {
      if (item is! Map<String, dynamic>) {
        throw const ApiException('Format data pengguna tidak valid.');
      }
      return User.fromJson(item);
    }).toList();
  }

  /// Mengambil pengguna berdasarkan [id].
  Future<User> getUserById(int id) async {
    final data = await _getJson('users/$id');
    if (data is! Map<String, dynamic>) {
      throw const ApiException('Format data pengguna tidak valid.');
    }
    return User.fromJson(data);
  }

  // read only - awal
  /// Mengambil daftar post dari API.
  Future<List<Post>> getPosts() async {
    final data = await _getJson('posts');
    if (data is! List) {
      throw const ApiException('Format daftar post tidak valid.');
    }

    return data.map((item) {
      if (item is! Map<String, dynamic>) {
        throw const ApiException('Format data post tidak valid.');
      }
      return Post.fromJson(item);
    }).toList();
  }
  // read only - akhir

  Future<Object?> _getJson(String endpoint) async {
    final normalizedBaseUrl = _baseUrl.endsWith('/') ? _baseUrl : '$_baseUrl/';
    final uri = Uri.parse(normalizedBaseUrl).resolve(endpoint);
    _logRequest(endpoint);

    try {
      final response = await _client
          .get(uri, headers: _buildHeaders())
          .timeout(const Duration(seconds: AppConfig.timeoutSeconds));
      _logResponse(response.statusCode);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          'Gagal memuat data (status ${response.statusCode}).',
          statusCode: response.statusCode,
        );
      }
      return jsonDecode(response.body);
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(
        'Request timeout. Periksa koneksi internet Anda.',
      );
    } on HandshakeException {
      throw const ApiException(
        'Koneksi aman ke server gagal. Silakan coba lagi nanti.',
      );
    } on SocketException {
      throw const ApiException(
        'Tidak ada koneksi internet. Periksa jaringan Anda.',
      );
    } on http.ClientException {
      throw const ApiException(
        'Tidak dapat menghubungi server. Silakan coba lagi nanti.',
      );
    } on FormatException {
      throw const ApiException('Format data dari server tidak valid.');
    } catch (error, stackTrace) {
      Logger.error(
        'Unexpected API error (${error.runtimeType}).',
        stackTrace: stackTrace,
      );
      throw const ApiException(
        'Terjadi kesalahan saat menghubungi server. Silakan coba lagi nanti.',
      );
    }
  }

  Map<String, String> _buildHeaders() => {
    'Accept': 'application/json',
    if (AppConfig.apiKey.isNotEmpty) 'X-API-Key': AppConfig.apiKey,
  };

  void _logRequest(String endpoint) => Logger.debug('GET /$endpoint');

  void _logResponse(int statusCode) =>
      Logger.info('API response status: $statusCode');

  /// Menutup client HTTP jika tidak lagi digunakan.
  void dispose() {
    _client.close();
  }
}

class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}
