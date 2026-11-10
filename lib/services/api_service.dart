import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/user.dart';

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
          'Gagal memuat data pengguna (status ${response.statusCode}).',
          statusCode: response.statusCode,
        );
      }
      return jsonDecode(response.body);
    } on TimeoutException {
      throw const ApiException(
        'Request timeout. Periksa koneksi internet Anda.',
      );
    } on SocketException {
      throw const ApiException(
        'Tidak ada koneksi internet. Periksa jaringan Anda.',
      );
    } on FormatException {
      throw const ApiException('Format data dari server tidak valid.');
    }
  }

  Map<String, String> _buildHeaders() => {
    'Accept': 'application/json',
    if (AppConfig.apiKey.isNotEmpty) 'X-API-Key': AppConfig.apiKey,
  };

  void _logRequest(String endpoint) {
    if (kDebugMode) {
      developer.log('GET /$endpoint', name: 'ApiService');
    }
  }

  void _logResponse(int statusCode) {
    if (kDebugMode) {
      developer.log('Response status: $statusCode', name: 'ApiService');
    }
  }

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
