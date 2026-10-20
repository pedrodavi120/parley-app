import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/translation_item.dart';

/// Widget de exibição para cada balão de mensagem traduzida.
class ChatBubble extends StatelessWidget {
  final TranslationItem item;
  final void Function(String text, String langId) onSpeak;

  const ChatBubble({
    super.key,
    required this.item,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    final isPt = item.isSourcePortuguese;
    final originalLangId = item.originalLocaleId;
    final translatedLangId = item.targetLocaleId;

    return Align(
      alignment: isPt ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          crossAxisAlignment:
              isPt ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(24),
                  topRight: const Radius.circular(24),
                  bottomLeft: isPt ? Radius.zero : const Radius.circular(24),
                  bottomRight: isPt ? const Radius.circular(24) : Radius.zero,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000), // black with 0.04 alpha
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: isPt ? AppTheme.ptBorder : AppTheme.enBorder,
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 3,
                        height: 14,
                        color: isPt ? AppTheme.ptIndicator : AppTheme.enIndicator,
                        margin: const EdgeInsets.only(right: 8),
                      ),
                      Expanded(
                        child: Text(
                          item.originalText,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => onSpeak(item.originalText, originalLangId),
                        child: Icon(
                          Icons.volume_up_outlined,
                          size: 18,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(
                    height: 1,
                    thickness: 0.5,
                    color: Color(0xFFF5F5F5),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.translatedText,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: isPt ? AppTheme.ptText : AppTheme.enText,
                            height: 1.3,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () =>
                            onSpeak(item.translatedText, translatedLangId),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isPt ? AppTheme.ptBgLight : AppTheme.enBgLight,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.volume_up_rounded,
                            size: 20,
                            color: isPt ? AppTheme.ptIndicator : AppTheme.enIndicator,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 8, right: 8),
              child: Text(
                isPt ? 'Português' : 'Inglês',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
