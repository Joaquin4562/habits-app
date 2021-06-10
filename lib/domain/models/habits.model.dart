import 'package:flutter/material.dart';

class Habitos {
  String nombre;
  String categoria;
  List<dynamic> dias;
  String hora;
  bool isFinished;
  Habitos({
    required this.categoria,
    required this.dias,
    required this.hora,
    required this.nombre,
    required this.isFinished,
  });
}

class Categories {
  String nombre;
  Color color;
  String icono;

  Categories({required this.color, required this.icono, required this.nombre});
}
