import 'package:news_app/models/news.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// class DatabaseHelper{
//
//   static dinal _d
//
//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance=DatabaseHelper._privateConstructor();
//
// }

class Newsdatabase {
  static final Newsdatabase instance = Newsdatabase._init();

  static Database? _database;

  Newsdatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('news.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableNews ( 
  ${NewsFields.id} $idType, 
  ${NewsFields.isImportant} $boolType,
  ${NewsFields.number} $integerType,
  ${NewsFields.title} $textType,
  ${NewsFields.description} $textType,
  ${NewsFields.time} $textType
  )
''');
  }

  Future<News> create(News news) async {
    final db = await instance.database;

    // final json = news.toJson();
    // final columns =
    //     '${NewsFields.title}, ${NewsFields.description}, ${NewsFields.time}';
    // final values =
    //     '${json[NewsFields.title]}, ${json[NewsFields.description]}, ${json[NewsFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableNews, news.toJson());
    return news.copy(id: id);
  }

  Future<News> readNews(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNews,
      columns: NewsFields.values,
      where: '${NewsFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return News.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<News>> readAllNews() async {
    final db = await instance.database;

    final orderBy = '${NewsFields.time} DES';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNews ORDER BY $orderBy');

    final result = await db.query(tableNews, orderBy: orderBy);

    return result.map((json) => News.fromJson(json)).toList();
  }

  Future<int> update(News news) async {
    final db = await instance.database;

    return db.update(
      tableNews,
      news.toJson(),
      where: '${NewsFields.id} = ?',
      whereArgs: [news.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNews,
      where: '${NewsFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
