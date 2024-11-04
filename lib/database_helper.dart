import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'artifact.dart'; // 引入你的 Artifact 类

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'artifacts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE artifacts(
            id TEXT PRIMARY KEY,
            name TEXT,
            category TEXT,
            size TEXT,
            era TEXT,
            description TEXT
          )
          ''',
        );
      },
    );
  }

  Future<void> insertArtifact(Artifact artifact) async {
    final db = await database;
    await db.insert(
      'artifacts',
      artifact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Artifact>> getArtifacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('artifacts');
    return List.generate(maps.length, (i) {
      return Artifact(
        id: maps[i]['id'],
        name: maps[i]['name'],
        category: maps[i]['category'],
        size: maps[i]['size'],
        era: maps[i]['era'],
        description: maps[i]['description'],
      );
    });
  }

  Future<void> updateArtifact(Artifact artifact) async {
    final db = await database;
    await db.update(
      'artifacts',
      artifact.toMap(),
      where: 'id = ?',
      whereArgs: [artifact.id],
    );
  }

  Future<void> deleteArtifact(String id) async {
    final db = await database;
    await db.delete(
      'artifacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}