import 'package:flutter_test/flutter_test.dart';
import 'package:parley_app/data/models/translation_item.dart';

void main() {
  group('Testes de TranslationItem', () {
    test('Mensagem com origem em Português retorna localidades e propriedades esperadas', () {
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

    test('Mensagem com origem em Inglês retorna localidades e propriedades esperadas', () {
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
