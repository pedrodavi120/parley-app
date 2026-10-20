import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

/// Botão flutuante de microfone com pulso animado (AvatarGlow) e gradiente estético.
class MicButton extends StatelessWidget {
  final String langName;
  final String langCode;
  final List<Color> gradientColors;
  final bool isActive;
  final bool isOtherActive;
  final VoidCallback onTap;

  const MicButton({
    super.key,
    required this.langName,
    required this.langCode,
    required this.gradientColors,
    required this.isActive,
    required this.isOtherActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AvatarGlow(
          animate: isActive,
          glowColor: gradientColors.last,
          duration: const Duration(milliseconds: 2000),
          repeat: true,
          child: GestureDetector(
            onTap: isOtherActive ? null : onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.elasticOut,
              width: isActive ? 84 : 72,
              height: isActive ? 84 : 72,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isOtherActive
                      ? [Colors.grey[100]!, Colors.grey[200]!]
                      : gradientColors,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  if (!isOtherActive)
                    BoxShadow(
                      color: gradientColors.last.withValues(alpha: 0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                ],
              ),
              child: Icon(
                isActive ? Icons.graphic_eq : Icons.mic_rounded,
                color: isOtherActive ? Colors.grey[400] : Colors.white,
                size: isActive ? 36 : 30,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isOtherActive ? 0.4 : 1.0,
          child: Text(
            langName,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF5E35B1),
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
