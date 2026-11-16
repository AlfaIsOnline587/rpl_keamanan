import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

// << awal class Logger
/// Logger terstruktur yang hanya menulis log pada build debug.
class Logger {
  static void debug(String message) => _log(LogLevel.debug, message);

  static void info(String message) => _log(LogLevel.info, message);

  static void warning(String message) => _log(LogLevel.warning, message);

  static void error(String message, {StackTrace? stackTrace}) =>
      _log(LogLevel.error, message, stackTrace: stackTrace);

  static void _log(LogLevel level, String message, {StackTrace? stackTrace}) {
    if (!kDebugMode) return;

    developer.log(
      '[${level.name.toUpperCase()}] $message',
      name: 'AppLogger',
      level: switch (level) {
        LogLevel.debug => 500,
        LogLevel.info => 800,
        LogLevel.warning => 900,
        LogLevel.error => 1000,
      },
      stackTrace: stackTrace,
    );
  }
}
// << akhir class Logger
