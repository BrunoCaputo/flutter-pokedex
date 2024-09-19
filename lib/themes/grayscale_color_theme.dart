import 'package:flutter/material.dart';

class GrayscaleColorTheme extends ThemeExtension<GrayscaleColorTheme> {
  const GrayscaleColorTheme({
    required this.dark,
    required this.medium,
    required this.light,
    required this.background,
    required this.white,
  });

  final Color? dark;
  final Color? medium;
  final Color? light;
  final Color? background;
  final Color? white;

  @override
  GrayscaleColorTheme copyWith({
    Color? dark,
    Color? medium,
    Color? light,
    Color? background,
    Color? white,
  }) {
    return GrayscaleColorTheme(
      dark: dark ?? this.dark,
      medium: medium ?? this.medium,
      light: light ?? this.light,
      background: background ?? this.background,
      white: white ?? this.white,
    );
  }

  @override
  GrayscaleColorTheme lerp(
    ThemeExtension<GrayscaleColorTheme>? other,
    double t,
  ) {
    if (other is! GrayscaleColorTheme) {
      return this;
    }

    return GrayscaleColorTheme(
      dark: Color.lerp(dark, other.dark, t),
      medium: Color.lerp(medium, other.medium, t),
      light: Color.lerp(light, other.light, t),
      background: Color.lerp(background, other.background, t),
      white: Color.lerp(white, other.white, t),
    );
  }
}
