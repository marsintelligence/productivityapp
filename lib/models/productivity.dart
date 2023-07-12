import 'package:flutter/material.dart';

enum Categ { work, entertainment, routine }

class Productivity {
  String taskName;
  TimeOfDay startTime;
  TimeOfDay endTime;
  int duration;
  Categ type;

  Productivity(
      {required this.taskName,
      required this.startTime,
      required this.endTime,
      required this.duration,
      required this.type});
}
