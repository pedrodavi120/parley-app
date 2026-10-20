/// Modelo imutável que representa uma mensagem dentro do fluxo de conversa.
class TranslationItem {
  final String originalText;
  final String translatedText;
  final String originalLang; // 'pt' ou 'en'
  final bool isUserMe;

  const TranslationItem({
    required this.originalText,
    required this.translatedText,
    required this.originalLang,
    this.isUserMe = true,
  });

  /// Identifica se o idioma de origem foi o Português
  bool get isSourcePortuguese => originalLang == 'pt';

  /// Retorna o código de localidade para reprodução do texto original
  String get originalLocaleId => isSourcePortuguese ? 'pt-BR' : 'en-US';

  /// Retorna o código de localidade para reprodução do texto traduzido
  String get targetLocaleId => isSourcePortuguese ? 'en-US' : 'pt-BR';
}
