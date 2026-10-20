import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Centralized configuration managing environment variables from .env
class EnvConfig {
  EnvConfig._();

  /// Initializes dotenv. Gracefully handles missing .env in CI/CD or fresh clones.
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: '.env');
      debugPrint('[EnvConfig] Environment variables loaded from .env');
    } catch (e) {
      debugPrint('[EnvConfig] Notice: .env not loaded ($e). Using default configurations.');
    }
  }

  /// App display name
  static String get appName => dotenv.maybeGet('APP_NAME') ?? 'Parley';

  /// App environment mode (development, staging, production)
  static String get appEnv => dotenv.maybeGet('APP_ENV') ?? 'development';

  /// Speech recognition listen timeout in seconds
  static int get speechListenTimeoutSeconds =>
      int.tryParse(dotenv.maybeGet('SPEECH_LISTEN_TIMEOUT_SECONDS') ?? '') ?? 20;

  /// Speech recognition pause timeout in seconds
  static int get speechPauseSeconds =>
      int.tryParse(dotenv.maybeGet('SPEECH_PAUSE_SECONDS') ?? '') ?? 2;

  /// Default source locale for Portuguese
  static String get defaultSourceLocale =>
      dotenv.maybeGet('DEFAULT_SOURCE_LOCALE') ?? 'pt_BR';

  /// Default target locale for English
  static String get defaultTargetLocale =>
      dotenv.maybeGet('DEFAULT_TARGET_LOCALE') ?? 'en_US';

  /// Optional translation API credentials
  static String? get translationApiKey => dotenv.maybeGet('TRANSLATION_API_KEY');
  static String? get translationApiUrl => dotenv.maybeGet('TRANSLATION_API_URL');
}
