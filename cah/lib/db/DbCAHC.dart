import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:lesson_13/models/black_cards.dart';
import 'package:lesson_13/models/white_cards.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCAHC {
  DatabaseCAHC._();

  static const databaseName = 'data.db';
  Random random = new Random();
  //Constructor
  DatabaseCAHC._privateConstructor();

  static final DatabaseCAHC instance = DatabaseCAHC._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    _database = await initializeDatabase();
    return _database!;
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
  Future<BlackCards> getBlackCard() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(BlackCards.tableName, orderBy: "RANDOM()", limit: 1);
    return BlackCards(
      id: int.parse(maps[0]['id']),
      draw: int.parse(maps[0]['draw']),
      pick: int.parse(maps[0]['pick']),
      text: maps[0]['text'],
      watermark: maps[0]['watermark'],
    );
  }

  Future<List<WhiteCards>> getWhiteCards(int n) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(WhiteCards.tableName);
    return List.generate(n, (i) {
      int j = random.nextInt(maps.length);
      return WhiteCards(
          id: int.parse(maps[j]['id']),
          text: maps[j]['text'],
          watermark: maps[j]['watermark']);
    });
  }
}
