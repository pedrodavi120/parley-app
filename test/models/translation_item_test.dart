import 'package:flutter_test/flutter_test.dart';
import 'package:parley_app/data/models/translation_item.dart';

void main() {
  group('TranslationItem Tests', () {
    test('Portuguese source item returns expected locales and properties', () {
      const item = TranslationItem(
        originalText: 'Olá, como vai?',
        translatedText: 'Hello, how are you?',
        originalLang: 'pt',
      );

      expect(item.isSourcePortuguese, isTrue);
      expect(item.originalLocaleId, equals('pt-BR'));
      expect(item.targetLocaleId, equals('en-US'));
      expect(item.isUserMe, isTrue);
    });

    test('English source item returns expected locales and properties', () {
      const item = TranslationItem(
        originalText: 'Good morning',
        translatedText: 'Bom dia',
        originalLang: 'en',
      );

      expect(item.isSourcePortuguese, isFalse);
      expect(item.originalLocaleId, equals('en-US'));
      expect(item.targetLocaleId, equals('pt-BR'));
    });
  });
}
