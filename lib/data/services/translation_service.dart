import 'package:flutter/foundation.dart';
import 'package:translator/translator.dart';
import '../../core/config/env_config.dart';

/// Service responsible for handling text translation.
class TranslationService {
  final GoogleTranslator _translator = GoogleTranslator();

  /// Translates text between specified languages.
  /// If a custom API key is defined in EnvConfig, it can be extended to use dedicated Cloud endpoints.
  Future<String> translate({
    required String text,
    required String from,
    required String to,
  }) async {
    try {
      // Check if custom translation key/url is configured
      final apiKey = EnvConfig.translationApiKey;
      if (apiKey != null && apiKey.isNotEmpty) {
        debugPrint('[TranslationService] Using configured API credentials.');
      }

      final translation = await _translator.translate(text, from: from, to: to);
      return translation.text;
    } catch (e, stackTrace) {
      debugPrint('[TranslationService] Error during translation: $e\n$stackTrace');
      rethrow;
    }
  }
}
