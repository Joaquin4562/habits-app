import 'package:flutter/material.dart';

class CustomColors {
  static _BluePalette azul = _BluePalette(
    0xFF251057,
    dark: Color(0xFF150638),
    light: Color(0xFF332BFF),
  );
  static Color blanco = Color(0xFFF0F0F6);
  static Color lila = Color(0xFFFFAAF6);
  static Color amarillo = Color(0xFFFFAA00);
  static Color rosa = Color(0xFFFFAAF6);
  static Color morado = Color(0xFFB032E7);
  static Color cea = Color(0xFF59ADFF);
  static Color redAccion = Color(0xFFFF5678);
  static Color nature = Color(0xFF8CC385);
}

class _BluePalette extends Color {
  Color? light;
  Color? dark;
  _BluePalette(
    int value, {
    this.dark,
    this.light,
  }) : super(value);
}
