import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../game_logic.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'matches1.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE matches (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            size INTEGER,
            board TEXT,
            winner TEXT,
            times timestamp default current_timestamp
          )
        ''');
      },
    );
  }

  Future<void> insertMatch(Game game, String winner) async {
    final db = await database;
    await db.insert(
      'matches',
      {
        'size': game.size,
        'board': jsonEncode(game.board),
        'winner': winner,
        'times': DateTime.now().toString(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getMatches() async {
    final db = await database;
    return await db.query('matches');
  }

  Future<void> deleteAllMatches() async {
    final db = await database;
    await db.delete('matches'); 
  }

}
