import 'package:flutter/material.dart';

class RequestSaveUserHabit {
  String name;
  String category;
  List<bool> days;
  String hour;

  RequestSaveUserHabit({
    required this.name,
    required this.category,
    required this.days,
    required this.hour,
  });
}
