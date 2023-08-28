import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productivityapp/models/productivity.dart';

class HiveDatabase {
  final productivityBox = Hive.box('ProductivityDatabase');
  List<Map<String, dynamic>> items = [];

  void add(Map<String, dynamic> newItem) async {
    await productivityBox.add(newItem);
  }
}
