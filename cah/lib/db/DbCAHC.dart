import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:cah/models/black_cards.dart';
import 'package:cah/models/white_cards.dart';
import 'package:cah/models/card_set.dart';
import 'package:cah/models/card_set_black_card.dart';
import 'package:cah/models/card_set_white_card.dart';
import 'package:cah/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCAHC {
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

  List<String> cardPacks = [];

  initializeDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    var exists = await databaseExists(path);

    if (!exists) {
      //print("Copy database to storage");
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

      return await openDatabase(path);
    } else {
      //print("opening existing db");
      return await openDatabase(path);
    }
  }

  void getAllCardPacksID() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(CardSets.tableName, columns: ['id']);
    cardPacks = List.generate(maps.length, (i) {
      return maps[i]['id'];
    });
  }

  Future<List<dynamic>> getAllCardPacksNames() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(CardSets.tableName, columns: ['name']);
    return List.generate(maps.length, (i) {
      return maps[i]['name'];
    });
  }

  void updateCardPacks() {
    // very important
    cardPacks = [];
    // Add code later
  }

  // method to insert user
  Future<void> insertUser(User user) async {
    final db = await database;

    Map<String, dynamic> map = user.toMap();
    String table = User.tableName;
    String username = map['username'];
    String password = map['password'];
    await db.rawInsert(
        "INSERT INTO $table(username, password) VALUES('$username', '$password');");
  }

  // method to retrieve all users
  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(User.tableName);
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        username: maps[i]['username'],
        password: maps[i]['password'],
      );
    });
  }

  Future<bool> validBlackCardId(String blackCardId) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
        CardSetBlackCards.tableName,
        where: "black_card_id = ?",
        whereArgs: [blackCardId]);
    List<Map<String, dynamic>> blackCard = await db.query(BlackCards.tableName,
        where: "id = ?", whereArgs: [blackCardId], limit: 1);
    if ('____'.allMatches(blackCard[0]['text']).length > 1) {
      return false;
    }
    for (dynamic row in maps) {
      if (cardPacks.contains(row['card_set_id'])) return true;
    }
    return false;
  }

  Future<bool> validWhiteCardId(String whiteCardId) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
        CardSetWhiteCards.tableName,
        where: "white_card_id = ?",
        whereArgs: [whiteCardId]);
    for (dynamic row in maps) {
      if (cardPacks.contains(row['card_set_id'])) return true;
    }
    return false;
  }

  //select
  Future<BlackCards> getBlackCard() async {
    final db = await database;
    List<Map<String, dynamic>> maps =
        await db.query(BlackCards.tableName, orderBy: "RANDOM()", limit: 1);
    while (true) {
      if (await validBlackCardId(maps[0]['id'])) break;
      maps =
          await db.query(BlackCards.tableName, orderBy: "RANDOM()", limit: 1);
    }
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
    List<int> whiteCardIds = [];
    for (int i = 0; i < n; i++) {
      while (true) {
        int j = random.nextInt(maps.length);
        if (await validWhiteCardId(maps[j]['id'])) {
          whiteCardIds.add(j);
          break;
        }
      }
    }
    return List.generate(n, (i) {
      int j = whiteCardIds[i];
      return WhiteCards(
          id: int.parse(maps[j]['id']),
          text: maps[j]['text'],
          watermark: maps[j]['watermark']);
    });
  }
}
