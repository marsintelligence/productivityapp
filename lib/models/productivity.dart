import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

enum Categ { work, entertainment, routine }

String categToString(Categ type) {
  switch (type) {
    case Categ.work:
      return 'work';
    case Categ.routine:
      return 'routine';
    case Categ.entertainment:
      return 'entertainment';

    default:
      throw Exception('Invalid Category');
  }
}

Categ stringToCateg(String type) {
  switch (type) {
    case 'work':
      return Categ.work;
    case 'routine':
      return Categ.routine;
    case 'entertainment':
      return Categ.entertainment;
    default:
      throw Exception('Invalid category');
  }
}

class Productivity {
  int? id;
  String taskName;
  TimeOfDay startTime;
  TimeOfDay endTime;
  int duration;
  Categ type;
  DateTime date;

  Productivity({
    this.id,
    required this.taskName,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.type,
    required this.date,
  });

  factory Productivity.fromMap(Map<String, dynamic> json) {
    return Productivity(
        id: json['id'],
        taskName: json['taskName'],
        startTime: TimeOfDay(
          hour: int.parse(json['startTime'].split(':')[0]),
          minute: int.parse(json['startTime'].split(':')[1]),
        ),
        endTime: TimeOfDay(
          hour: int.parse(json['endTime'].split(':')[0]),
          minute: int.parse(json['endTime'].split(':')[1]),
        ),
        duration: int.parse(json['duration']),
        type: stringToCateg(json['type']),
        date: DateTime(
          int.parse(json['date'].split('/')[2]),
          int.parse(json['date'].split('/')[1]),
          int.parse(json['date'].split('/')[0]),
        ));
  }
  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'startTime': '${startTime.hour}:${startTime.minute}',
      'endTime': '${endTime.hour}:${endTime.minute}',
      'duration': duration,
      'type': categToString(type),
      'date': '${date.day}/${date.month}/${date.year}'
    };
  }
}
