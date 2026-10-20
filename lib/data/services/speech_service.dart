import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../core/config/env_config.dart';

/// Service managing Speech-To-Text microphone access and voice recognition.
class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isAvailable = false;

  bool get isAvailable => _isAvailable;
  bool get isListening => _speech.isListening;

  /// Requests microphone permissions and initializes speech recognition engine.
  Future<bool> initialize({
    required void Function(String status) onStatus,
    required void Function(dynamic error) onError,
  }) async {
    try {
      final status = await Permission.microphone.request();
      if (!status.isGranted) {
        debugPrint('[SpeechService] Microphone permission was not granted.');
        return false;
      }

      _isAvailable = await _speech.initialize(
        onStatus: onStatus,
        onError: onError,
      );
      return _isAvailable;
    } catch (e) {
      debugPrint('[SpeechService] Initialization error: $e');
      return false;
    }
  }

  /// Begins listening for speech in the requested locale.
  Future<void> listen({
    required String localeId,
    required void Function(SpeechRecognitionResult result) onResult,
  }) async {
    if (!_isAvailable) {
      debugPrint('[SpeechService] Speech recognition is not available.');
      return;
    }

    await _speech.listen(
      localeId: localeId,
      listenFor: Duration(seconds: EnvConfig.speechListenTimeoutSeconds),
      pauseFor: Duration(seconds: EnvConfig.speechPauseSeconds),
      onResult: onResult,
    );
  }

  /// Stops the current listening session.
  Future<void> stop() async {
    try {
      await _speech.stop();
    } catch (e) {
      debugPrint('[SpeechService] Error stopping listening: $e');
    }
  }
}
