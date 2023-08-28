import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'models/productivity.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'productivity.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1 && newVersion == 2) {
          await db
              .execute('ALTER TABLE productivityTable ADD COLUMN date TEXT');
        }
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE productivityTable(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    taskName TEXT,
    startTime TEXT,
    endTime TEXT,
    duration TEXT,
    type TEXT,
    date TEXT
   )''');
  }

  Future<List<Productivity>> getProductivityList() async {
    Database db = await instance.database;
    var maps = await db.query('productivityTable');

    return List.generate(maps.length, (i) {
      return Productivity.fromMap(maps[i]);
    });
  }

  Future<int> addToList(Productivity productivity) async {
    Database db = await instance.database;
    return await db.insert('productivityTable', productivity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateList(Productivity productivity) async {
    Database db = await instance.database;
    int? id = productivity.id;
    return await db.update('productivitiyTable', productivity.toMap(),
        where: 'id=?', whereArgs: [id]);
  }

  Future<List<Productivity>> getProductivityListForDateTime(
      DateTime date, TimeOfDay startTime, TimeOfDay endTime, Categ type) async {
    Database db = await instance.database;
    var maps = await db.query('productivityTable',
        where: 'date=? AND type=?',
        whereArgs: [
          '${date.year}/${date.month}/${date.day}',
          categToString(type)
        ]);
    List<Productivity> filteredList = [];
    for (var map in maps) {
      Productivity productivity = Productivity.fromMap(map);
      TimeOfDay taskStartTime = productivity.startTime;
      TimeOfDay taskEndTime = productivity.endTime;
      int compareTimeOfDay(TimeOfDay a, TimeOfDay b) {
        if (a.hour > b.hour) {
          return 1;
        } else if (a.hour < b.hour) {
          return -1;
        } else if (a.minute > b.minute) {
          return 1;
        } else if (a.minute < b.minute) {
          return -1;
        } else
          return 0;
      }

      if (compareTimeOfDay(taskStartTime, startTime) >= 0 &&
          compareTimeOfDay(taskEndTime, endTime) <= 0) {
        filteredList.add(productivity);
      }
    }
    return filteredList;
  }

  Future<List<Productivity>> getProductivityListForDate(DateTime date) async {
    Database db = await instance.database;
    var maps = await db.query('productivityTable',
        where: 'date=?', whereArgs: ['${date.year}/${date.month}/${date.day}']);
    List<Productivity> filteredList = [];
    for (var map in maps) {
      Productivity productivity = Productivity.fromMap(map);

      filteredList.add(productivity);
    }
    return filteredList;
  }

  Future<void> removeFromList(int id) async {
    Database db = await instance.database;
    await db.delete('productivityTable', where: 'id=?', whereArgs: [id]);
  }
}
