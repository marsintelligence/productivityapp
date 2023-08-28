import 'package:flutter/material.dart';
import 'package:productivityapp/database_helper.dart';
import 'package:productivityapp/models/productivity.dart';

class ProductivityTools extends ChangeNotifier {
  late List<Productivity> productivityList;
  List<int> workDuration = [];
  List<int> entDuration = [];
  List<int> routineDuration = [];
  ProductivityTools() {
    productivityList = [];
  }

  List<Productivity> getProductivityList() {
    return productivityList;
  }

  Future<void> loadProductivityList() async {
    productivityList = await DatabaseHelper.instance.getProductivityList();
    notifyListeners();
  }

  Future<void> addToProductivityList(Productivity item) async {
    await DatabaseHelper.instance.addToList(item);
    await loadProductivityList();
  }

  Future<List<Productivity>> filterProductivityListByDateTime(
      DateTime date, TimeOfDay startTime, TimeOfDay endTime, Categ type) async {
    var filteredList = await DatabaseHelper.instance
        .getProductivityListForDateTime(date, startTime, endTime, type);
    notifyListeners();
    return filteredList;
  }

  Future<void> filterProductivityListByDate(DateTime date) async {
    int typeTime = 0;
    var filteredList =
        await DatabaseHelper.instance.getProductivityListForDate(date);
    for (var item in filteredList) {
      typeTime = item.duration;
      if (item.type == Categ.work) {
        if (item.startTime.hour == workDuration[item.startTime.hour]) {
          workDuration[item.startTime.hour] += typeTime;
        }
      }
      if (item.type == Categ.entertainment) {
        if (item.startTime.hour == workDuration[item.startTime.hour]) {
          entDuration[item.startTime.hour] += typeTime;
        }
      }
      if (item.type == Categ.routine) {
        if (item.startTime.hour == workDuration[item.startTime.hour]) {
          routineDuration[item.startTime.hour] += typeTime;
        }
      }
      for (int i = 0; i < workDuration.length; i++) {
        if (workDuration[i] == null) {
          workDuration[i] = 0;
        }
      }
      for (int i = 0; i < entDuration.length; i++) {
        if (entDuration[i] == null) {
          entDuration[i] = 0;
        }
      }
      for (int i = 0; i < routineDuration.length; i++) {
        if (routineDuration[i] == null) {
          routineDuration[i] = 0;
        }
      }
    }
    for (var item in workDuration) {
      print(item);
    }
    notifyListeners();
  }

  getTotalTypeDuration(
      DateTime date, TimeOfDay startTime, TimeOfDay endTime, Categ type) async {
    var filteredList =
        await filterProductivityListByDateTime(date, startTime, endTime, type);
    int typeTime = 0;
    for (var item in filteredList) {
      typeTime = typeTime + item.duration;
    }
    if (type == Categ.work) {
      workDuration[startTime.hour] = typeTime;
    } else if (type == Categ.entertainment) {
      entDuration[startTime.hour] = typeTime;
    } else {
      routineDuration[startTime.hour] = typeTime;
    }
    notifyListeners();
  }

  Future<void> removeFromProductivityList(Productivity item) async {
    await DatabaseHelper.instance.removeFromList(item.id!);
  }

  Future<void> updateItem(Productivity item) async {
    await DatabaseHelper.instance.updateList(item);
  }
}
