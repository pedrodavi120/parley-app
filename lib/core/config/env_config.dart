import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuração centralizada para gestão segura de variáveis de ambiente (.env).
class EnvConfig {
  EnvConfig._();

  /// Inicializa o dotenv. Trata ausência do arquivo .env com fallbacks seguros.
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: '.env');
      debugPrint('[EnvConfig] Variáveis de ambiente carregadas do .env com sucesso.');
    } catch (e) {
      debugPrint('[EnvConfig] Aviso: Arquivo .env não encontrado ($e). Utilizando configurações padrão.');
    }
  }

  /// Nome de exibição da aplicação
  static String get appName => dotenv.maybeGet('APP_NAME') ?? 'Parley';

  /// Ambiente de execução (development, staging, production)
  static String get appEnv => dotenv.maybeGet('APP_ENV') ?? 'development';

  /// Tempo limite de escuta contínua do microfone em segundos
  static int get speechListenTimeoutSeconds =>
      int.tryParse(dotenv.maybeGet('SPEECH_LISTEN_TIMEOUT_SECONDS') ?? '') ?? 20;

  /// Intervalo de silêncio para encerramento de captura em segundos
  static int get speechPauseSeconds =>
      int.tryParse(dotenv.maybeGet('SPEECH_PAUSE_SECONDS') ?? '') ?? 2;

  /// Localidade de origem padrão (Português)
  static String get defaultSourceLocale =>
      dotenv.maybeGet('DEFAULT_SOURCE_LOCALE') ?? 'pt_BR';

  /// Localidade de destino padrão (Inglês)
  static String get defaultTargetLocale =>
      dotenv.maybeGet('DEFAULT_TARGET_LOCALE') ?? 'en_US';

  /// Credenciais opcionais de API dedicada de tradução
  static String? get translationApiKey => dotenv.maybeGet('TRANSLATION_API_KEY');
  static String? get translationApiUrl => dotenv.maybeGet('TRANSLATION_API_URL');
}
