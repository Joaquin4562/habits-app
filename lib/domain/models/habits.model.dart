import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';

class Habitos {
  String? nombre;
  String? categoria;
  List<String>? dias;
  String? hora;
  Color? color;
  
  Habitos({this.categoria, this.dias, this.hora, this.nombre, this.color});


  getPredeterminatedHabits () {
    return [
      Habitos(
        categoria: 'salud',
        color: CustomColors.nature,
        nombre: 'Naturaleza'
      ),
    ];
  }
}

class Categories {
  String nombre;
  Color color;
  String icono;

  Categories({required this.color, required this.icono, required this.nombre});
}