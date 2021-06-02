import 'dart:io';

import 'package:flutter/services.dart';
import 'package:lesson_13/models/black_cards.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCAHC {
  DatabaseCAHC._();

  static const databaseName = 'data.db';

  //Constructor
  DatabaseCAHC._privateConstructor();

  static final DatabaseCAHC instance = DatabaseCAHC._privateConstructor();
  static Database _database = <Database>[][0];

  Future<Database> get database async {
    _database = await initializeDatabase();
    return _database;
  }

  initializeDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    var exists = await databaseExists(path);

    if (!exists) {
      print("Copy database to storage");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (ex) {
        print(ex);
      }
      //copy
      ByteData data = await rootBundle.load(join("assets", databaseName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //write
      await File(path).writeAsBytes(bytes, flush: true);

      return await openDatabase(path, readOnly: true);
    } else {
      print("opening existing db");
      return await openDatabase(path, readOnly: true);
    }
  }

//select
  Future<Map<String, dynamic>> getBlackCard() async {
    final db = await database;
    final List<Map<String, dynamic>> card = await db.rawQuery(
        "SELECT * FROM 'public.black_cards' ORDER BY RANDOM() LIMIT 1;");
    return card[0];
  }
}
