import 'package:flutter/material.dart';

/// Indicator displayed while the speech recognition engine is actively listening.
class ListeningIndicator extends StatelessWidget {
  final String partialText;

  const ListeningIndicator({
    super.key,
    required this.partialText,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: child,
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                partialText.isEmpty ? 'Ouvindo...' : partialText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
