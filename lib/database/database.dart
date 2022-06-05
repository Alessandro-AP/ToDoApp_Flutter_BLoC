import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const TODO_TABLE = 'Todo';

class DatabaseProvider {

  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _createDatabase();
    return _database!;
  }

  Future<Database> _createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // "todo.db" is our database filename
    String path = join(documentsDirectory.path, "todo.db");
    var database = await openDatabase(path,
        version: 1, onCreate: _initDB, onUpgrade: _onUpgrade);
    return database;
  }

  void _initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $TODO_TABLE ("
        "id INTEGER PRIMARY KEY, "
        "description TEXT, "
        "is_done INTEGER " // sqlite doesn't have boolean format, we use 1 or 0
        ")");
  }

  //This is optional, and only used for changing DB schema migrations
  void _onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) { /* can be used to migrate database format */ }
  }

}