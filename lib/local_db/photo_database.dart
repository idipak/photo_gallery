
import 'package:sqflite/sqflite.dart';

import '../models/photo_model.dart';

class PhotoDatabase {
  static final PhotoDatabase instance = PhotoDatabase._init();

  static Database? _database;

  PhotoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('photos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    return await openDatabase(
        dbPath + filePath, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tablePhoto $idType,
    ${PhotoFields.title} $textType,
    ${PhotoFields.url} $textType,
    ${PhotoFields.tag} $textType
    ''');
  }

  Future<Photo> savePhoto(Photo issue) async {
    final db = await instance.database;
    final id = await db.insert(tablePhoto, issue.toJson());
    return issue.copy(id: id);
  }

  Future<Photo> readPhoto(int id) async {
    final db = await instance.database;
    final map = await db.query(
      tablePhoto,
      columns: PhotoFields.values,
      where: '${PhotoFields.id} == ?',
      whereArgs: [id],
    );

    if (map.isNotEmpty) {
      return Photo.fromJson(map.first);
    } else {
      throw Exception('ID $id not found.');
    }
  }

  Future<List<Photo>> readAllPhotos() async {
    final db = await instance.database;
    const orderBy = '${PhotoFields.id} ASC';
    final result = await db.query(tablePhoto, orderBy: orderBy);
    return result.map((json) => Photo.fromJson(json)).toList();
  }

  Future<int> updatePhoto(Photo issue) async {
    final db = await instance.database;
    return db.update(
        tablePhoto,
        issue.toJson(),
        where: "${PhotoFields.id} == ?",
        whereArgs: [issue.id]
    );
  }

  Future<int> deletePhoto(int id) async {
    final db = await instance.database;
    return db.delete(
        tablePhoto,
        where: "${PhotoFields.id} == ?",
        whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }


}
