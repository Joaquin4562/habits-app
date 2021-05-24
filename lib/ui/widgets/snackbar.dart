import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';

SnackBar getSnackBar(String label) {
  return SnackBar(
    backgroundColor: CustomColors.lila,
    content: Text(
      label,
      style: TextStyle(
        color: CustomColors.azul,
        fontSize: 20,
      ),
    ),
  );
}
