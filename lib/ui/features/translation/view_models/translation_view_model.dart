import 'package:flutter/foundation.dart';
import '../../../../data/models/translation_item.dart';
import '../../../../data/services/speech_service.dart';
import '../../../../data/services/translation_service.dart';
import '../../../../data/services/tts_service.dart';

/// ViewModel managing state, voice recognition, translation pipelines, and audio synthesis.
class TranslationViewModel extends ChangeNotifier {
  final SpeechService _speechService;
  final TtsService _ttsService;
  final TranslationService _translationService;

  TranslationViewModel({
    SpeechService? speechService,
    TtsService? ttsService,
    TranslationService? translationService,
  })  : _speechService = speechService ?? SpeechService(),
        _ttsService = ttsService ?? TtsService(),
        _translationService = translationService ?? TranslationService();

  final List<TranslationItem> _conversation = [];
  bool _isListening = false;
  String _activeLangId = '';
  String _partialText = '';
  bool _autoPlayAudio = true;
  VoidCallback? onScrollToBottomRequested;

  List<TranslationItem> get conversation => List.unmodifiable(_conversation);
  bool get isListening => _isListening;
  String get activeLangId => _activeLangId;
  String get partialText => _partialText;
  bool get autoPlayAudio => _autoPlayAudio;

  /// Initializes system permissions, audio categories, and engines.
  Future<void> initialize() async {
    await _ttsService.initialize();
  }

  /// Toggles automatic audio playback on completion.
  void toggleAutoPlayAudio() {
    _autoPlayAudio = !_autoPlayAudio;
    notifyListeners();
  }

  /// Clears current conversation history.
  void clearConversation() {
    _conversation.clear();
    notifyListeners();
  }

  /// Starts or stops voice recognition for the specified locale.
  Future<void> toggleListening(String localeId) async {
    if (!_isListening) {
      final available = await _speechService.initialize(
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            _isListening = false;
            notifyListeners();
          }
        },
        onError: (val) {
          _isListening = false;
          notifyListeners();
        },
      );

      if (available) {
        _isListening = true;
        _activeLangId = localeId;
        _partialText = '';
        notifyListeners();

        await _speechService.listen(
          localeId: localeId,
          onResult: (val) async {
            _partialText = val.recognizedWords;
            notifyListeners();

            if (val.finalResult && _partialText.isNotEmpty) {
              await _speechService.stop();
              _isListening = false;
              final capturedText = _partialText;
              notifyListeners();

              await _processTranslation(capturedText, localeId);
            }
          },
        );
      }
    } else {
      _isListening = false;
      _partialText = '';
      await _speechService.stop();
      notifyListeners();
    }
  }

  /// Processes text translation between Portuguese and English.
  Future<void> _processTranslation(String text, String sourceLocale) async {
    final bool isSourcePt = sourceLocale == 'pt_BR';
    final String from = isSourcePt ? 'pt' : 'en';
    final String to = isSourcePt ? 'en' : 'pt';

    try {
      final translatedText = await _translationService.translate(
        text: text,
        from: from,
        to: to,
      );

      _conversation.add(
        TranslationItem(
          originalText: text,
          translatedText: translatedText,
          originalLang: from,
        ),
      );
      notifyListeners();

      onScrollToBottomRequested?.call();

      if (_autoPlayAudio) {
        final targetLangId = isSourcePt ? 'en-US' : 'pt-BR';
        await speakText(translatedText, targetLangId);
      }
    } catch (e) {
      debugPrint('[TranslationViewModel] Translation pipeline error: $e');
    }
  }

  /// Plays synthesized audio for the given text.
  Future<void> speakText(String text, String langId) async {
    await _ttsService.speak(text: text, langId: langId);
  }

  @override
  void dispose() {
    _speechService.stop();
    _ttsService.stop();
    super.dispose();
  }
}
