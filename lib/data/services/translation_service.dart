import 'package:flutter/foundation.dart';
import 'package:translator/translator.dart';
import '../../core/config/env_config.dart';

/// Serviço responsável pelo pipeline de tradução de texto.
class TranslationService {
  final GoogleTranslator _translator = GoogleTranslator();

  /// Traduz o texto entre os idiomas especificados.
  /// Caso uma chave de API esteja configurada no EnvConfig, pode ser estendido para endpoints dedicados.
  Future<String> translate({
    required String text,
    required String from,
    required String to,
  }) async {
    try {
      final apiKey = EnvConfig.translationApiKey;
      if (apiKey != null && apiKey.isNotEmpty) {
        debugPrint('[TranslationService] Utilizando credenciais de API configuradas no ambiente.');
      }

      final translation = await _translator.translate(text, from: from, to: to);
      return translation.text;
    } catch (e, stackTrace) {
      debugPrint('[TranslationService] Erro durante a tradução: $e\n$stackTrace');
      rethrow;
    }
  }
}
