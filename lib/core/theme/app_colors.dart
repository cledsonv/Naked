import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Cores principais do aplicativo
  static const Color primary = Color(0xFFFF6B9D);
  static const Color secondary = Color(0xFFE74C3C);

  // Cores de fundo
  static const Color backgroundDark = Color(0xFF1A1A1A);
  static const Color backgroundDarker = Color(0xFF0F0F0F);
  static const Color backgroundAccent = Color(0xFF2C1810);

  // Cores de texto
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(
    0xFFFFFFFF,
  ); // Será usado com opacity

  // Cores do tema para perguntas e categorias
  static const Color purple = Color(0xFF8E44AD);
  static const Color purpleDark = Color(0xFF9B59B6);
  static const Color blue = Color(0xFF3498DB);
  static const Color blueGray = Color(0xFF34495E);
  static const Color green = Color(0xFF27AE60);
  static const Color teal = Color(0xFF1ABC9C);
  static const Color orange = Color(0xFFF39C12);
  static const Color gray = Color(0xFF95A5A6);

  // Cores transparentes
  static const Color transparent = Colors.transparent;

  // Gradientes comuns
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
  );

  static const LinearGradient purpleBlueGradient = LinearGradient(
    colors: [purple, blue],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [backgroundDark, backgroundDarker, backgroundAccent],
  );

  // Métodos auxiliares para cores com alpha (versão mais recente do Flutter)
  static Color primaryWithAlpha(double alpha) =>
      primary.withValues(alpha: alpha);
  static Color secondaryWithAlpha(double alpha) =>
      secondary.withValues(alpha: alpha);
  static Color whiteWithAlpha(double alpha) =>
      Colors.white.withValues(alpha: alpha);
  static Color blackWithAlpha(double alpha) =>
      Colors.black.withValues(alpha: alpha);

  // Cores específicas para categorias de perguntas
  static const List<Color> questionCategoryColors = [
    secondary, // Vermelho
    purple, // Roxo
    blueGray, // Azul acinzentado
    secondary, // Vermelho (repetido)
    primary, // Rosa
    green, // Verde
    blue, // Azul
    orange, // Laranja
    secondary, // Vermelho (repetido)
    purpleDark, // Roxo escuro
    teal, // Azul esverdeado
    gray, // Cinza
    primary, // Rosa (repetido)
    secondary, // Vermelho (repetido)
    green, // Verde (repetido)
  ];

  // Gradientes para diferentes seções
  static const List<LinearGradient> truthOrDareGradients = [
    LinearGradient(colors: [primary, secondary]),
    LinearGradient(colors: [purple, blue]),
  ];

  // Cores para estados de UI
  static Color borderColor({double alpha = 0.3}) =>
      primary.withValues(alpha: alpha);
  static Color overlayColor({double alpha = 0.1}) =>
      Colors.white.withValues(alpha: alpha);
  static Color shadowColor({double alpha = 0.2}) =>
      Colors.white.withValues(alpha: alpha);
}
