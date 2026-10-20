import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parley_app/data/models/translation_item.dart';
import 'package:parley_app/ui/features/translation/widgets/chat_bubble.dart';

void main() {
  testWidgets('ChatBubble displays original and translated text with speech buttons',
      (WidgetTester tester) async {
    String spokenText = '';
    String spokenLocale = '';

    const item = TranslationItem(
      originalText: 'Bom dia mundo',
      translatedText: 'Good morning world',
      originalLang: 'pt',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatBubble(
            item: item,
            onSpeak: (text, langId) {
              spokenText = text;
              spokenLocale = langId;
            },
          ),
        ),
      ),
    );

    expect(find.text('Bom dia mundo'), findsOneWidget);
    expect(find.text('Good morning world'), findsOneWidget);
    expect(find.text('Português'), findsOneWidget);

    // Tap original speak icon
    final volumeIcons = find.byIcon(Icons.volume_up_outlined);
    expect(volumeIcons, findsOneWidget);
    await tester.tap(volumeIcons);
    expect(spokenText, equals('Bom dia mundo'));
    expect(spokenLocale, equals('pt-BR'));

    // Tap translated audio button
    final playRoundedIcons = find.byIcon(Icons.volume_up_rounded);
    expect(playRoundedIcons, findsOneWidget);
    await tester.tap(playRoundedIcons);
    expect(spokenText, equals('Good morning world'));
    expect(spokenLocale, equals('en-US'));
  });
}
