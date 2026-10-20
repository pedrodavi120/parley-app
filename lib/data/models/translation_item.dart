/// Immutable model representing an entry in the live conversation.
class TranslationItem {
  final String originalText;
  final String translatedText;
  final String originalLang; // 'pt' or 'en'
  final bool isUserMe;

  const TranslationItem({
    required this.originalText,
    required this.translatedText,
    required this.originalLang,
    this.isUserMe = true,
  });

  /// Helper getter to identify if the source language was Portuguese
  bool get isSourcePortuguese => originalLang == 'pt';

  /// Returns the corresponding speech language ID for original text
  String get originalLocaleId => isSourcePortuguese ? 'pt-BR' : 'en-US';

  /// Returns the corresponding speech language ID for translated text
  String get targetLocaleId => isSourcePortuguese ? 'en-US' : 'pt-BR';
}
