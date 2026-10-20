import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Service managing Text-To-Speech engine lifecycle and speech playback.
class TtsService {
  final FlutterTts _flutterTts = FlutterTts();

  /// Configures TTS audio categories for iOS and shared audio instances.
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
      debugPrint('[TtsService] Audio configuration error: $e');
    }
  }

  /// Synthesizes and plays the provided text in the target language.
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
      debugPrint('[TtsService] Speech playback failed: $e');
    }
  }

  /// Stops any currently playing audio.
  Future<void> stop() async {
    try {
      await _flutterTts.stop();
    } catch (e) {
      debugPrint('[TtsService] Error stopping audio: $e');
    }
  }
}
