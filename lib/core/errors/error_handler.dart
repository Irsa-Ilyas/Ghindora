import 'package:flutter/foundation.dart';
import 'package:ghindora/core/utils/logger.dart';

class ErrorHandler {
  static void logError(dynamic error, StackTrace stackTrace) {
    if (kDebugMode) {
      AppLogger.e(
        'Unhandled Error: $error',
        error: error,
        stackTrace: stackTrace,
      );
    }
    // Future: send to Crashlytics/Sentry here
  }
}
