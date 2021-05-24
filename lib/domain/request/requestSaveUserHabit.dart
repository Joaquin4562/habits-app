import 'package:flutter/material.dart';

class RequestSaveUserHabit {
  String name;
  String category;
  List<dynamic> days;
  String hour;

  RequestSaveUserHabit({
    required this.name,
    required this.category,
    required this.days,
    required this.hour,
  });
}
