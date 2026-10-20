import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Serviço gerenciador do ciclo de vida do motor de Síntese de Voz (TTS) e reprodução de áudio.
class TtsService {
  final FlutterTts _flutterTts = FlutterTts();

  /// Configura categorias de áudio do TTS para instâncias compartilhadas e Bluetooth.
  Future<void> initialize() async {
    try {
      await _flutterTts.setSharedInstance(true);
      await _flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        ],
      );
    } catch (e) {
      debugPrint('[TtsService] Erro ao configurar categoria de áudio: $e');
    }
  }

  /// Sintetiza e reproduz o texto informado no idioma especificado.
  Future<void> speak({
    required String text,
    required String langId,
    double pitch = 1.0,
  }) async {
    try {
      await _flutterTts.setLanguage(langId);
      await _flutterTts.setPitch(pitch);
      await _flutterTts.speak(text);
    } catch (e) {
      debugPrint('[TtsService] Falha na reprodução de síntese de voz: $e');
    }
  }

  /// Interrompe qualquer áudio em reprodução ativa.
  Future<void> stop() async {
    try {
      await _flutterTts.stop();
    } catch (e) {
      debugPrint('[TtsService] Erro ao interromper áudio: $e');
    }
  }
}
