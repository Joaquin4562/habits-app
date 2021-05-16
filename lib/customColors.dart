import 'package:flutter/material.dart';

class CustomColors {
  static _BluePalette azul = _BluePalette(
    0xFF251057,
    dark: Color(0xFF150638),
    light: Color(0xFF332BFF),
  );
  static const Color blanco = Color(0xFFF0F0F6);
  static const Color lila = Color(0xFFFFAAE1);
  static const Color amarillo = Color(0xFFFFAA00);
  static const Color fisico = Color(0xFFDBA753);
  static const Color morado = Color(0xFFB353DB);
  static const Color cea = Color(0xFF59ADFF);
  static const Color redAccion = Color(0xFFDB6353);
  static const Color nature = Color(0xFF8CC385);
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
