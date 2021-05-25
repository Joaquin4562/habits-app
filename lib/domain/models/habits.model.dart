import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';

class Habitos {
  String? nombre;
  String? categoria;
  List<dynamic>? dias;
  String? hora;

  Habitos({this.categoria, this.dias, this.hora, this.nombre});
}

class Categories {
  String nombre;
  Color color;
  String icono;

  Categories({required this.color, required this.icono, required this.nombre});
}