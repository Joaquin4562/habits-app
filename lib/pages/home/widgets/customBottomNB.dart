import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';

BottomNavigationBarItem customBottomNB(String label, IconData icono) {
  return BottomNavigationBarItem(
    backgroundColor: CustomColors.azul.dark,
    icon: Icon(
      icono,
      color: CustomColors.blanco,
      size: 30,
    ),
    label: label,
    activeIcon: Column(
      children: [
        Icon(
          icono,
          color: CustomColors.amarillo,
          size: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
          child: Container(
            height: 5,
            width: 5,
            decoration: BoxDecoration(
              color: CustomColors.amarillo,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        )
      ],
    ),
  );
}
