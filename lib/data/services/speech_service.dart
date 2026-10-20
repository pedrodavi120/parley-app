import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../core/config/env_config.dart';

/// Serviço responsável pelo acesso ao microfone e motor de reconhecimento de fala (STT).
class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isAvailable = false;

  bool get isAvailable => _isAvailable;
  bool get isListening => _speech.isListening;

  /// Solicita permissões de microfone e inicializa o motor de reconhecimento de voz.
  Future<bool> initialize({
    required void Function(String status) onStatus,
    required void Function(dynamic error) onError,
  }) async {
    try {
      final status = await Permission.microphone.request();
      if (!status.isGranted) {
        debugPrint('[SpeechService] Permissão de microfone não foi concedida pelo usuário.');
        return false;
      }

      _isAvailable = await _speech.initialize(
        onStatus: onStatus,
        onError: onError,
      );
      return _isAvailable;
    } catch (e) {
      debugPrint('[SpeechService] Erro ao inicializar reconhecimento de fala: $e');
      return false;
    }
  }

  /// Inicia a captura de fala na localidade informada.
  Future<void> listen({
    required String localeId,
    required void Function(SpeechRecognitionResult result) onResult,
  }) async {
    if (!_isAvailable) {
      debugPrint('[SpeechService] Reconhecimento de fala indisponível.');
      return;
    }

    await _speech.listen(
      localeId: localeId,
      listenFor: Duration(seconds: EnvConfig.speechListenTimeoutSeconds),
      pauseFor: Duration(seconds: EnvConfig.speechPauseSeconds),
      onResult: onResult,
    );
  }

  /// Interrompe a sessão atual de escuta.
  Future<void> stop() async {
    try {
      await _speech.stop();
    } catch (e) {
      debugPrint('[SpeechService] Erro ao interromper escuta: $e');
    }
  }
}
