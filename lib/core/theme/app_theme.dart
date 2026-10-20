import 'package:flutter/material.dart';

/// Design tokens e tema visual da aplicação em estrita conformidade com a identidade do Parley.
class AppTheme {
  AppTheme._();

  // Cores Principais da Marca
  static const Color primary = Color(0xFF7B1FA2);
  static const Color seedColor = Color(0xFF8E24AA);
  static const Color secondary = Color(0xFF039BE5);
  static const Color surface = Colors.white;
  static const Color onSurface = Color(0xFF2E3A59);

  // Definições de Gradientes
  static const List<Color> ptGradient = [
    Color(0xFF4FC3F7), // Azul Claro 300
    Color(0xFF0288D1), // Azul Claro 700
  ];

  static const List<Color> enGradient = [
    Color(0xFFE1BEE7), // Roxo Claro 100
    Color(0xFF8E24AA), // Roxo Vibrante 600
  ];

  // Tokens de Realce por Idioma
  static const Color ptBorder = Color(0x4D4FC3F7); // ~0.3 opacidade
  static const Color enBorder = Color(0x4DE1BEE7); // ~0.3 opacidade
  static const Color ptIndicator = Color(0xFF039BE5);
  static const Color enIndicator = Color(0xFF8E24AA);
  static const Color ptText = Color(0xFF0277BD);
  static const Color enText = Color(0xFF7B1FA2);
  static const Color ptBgLight = Color(0xFFE1F5FE);
  static const Color enBgLight = Color(0xFFF3E5F5);

  /// Tema claro da aplicação
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        primary: primary,
        secondary: secondary,
        surface: surface,
        onSurface: onSurface,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primary),
      ),
    );
  }
}
