import 'package:calc_app/models/entries_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbEntries {
  static Database? _database;
  static final DbEntries db = DbEntries._();
  DbEntries._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "EntriesDB.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Expenses (
        id INTEGER PRIMARY KEY,
        link INTEGER,
        year INTEGER,
        month INTEGER,
        day INTEGER,
        comment TEXT,
        entrie DOUBLE
        )
        ''');
      await db.execute('''
        CREATE TABLE Entries (
        id INTEGER PRIMARY KEY,
        year INTEGER,
        month INTEGER,
        day INTEGER,
        comment TEXT,
        expense DOUBLE
        )
        ''');
    });
  }

  addEntrie(EntriesModel exp) async {
    final db = await database;
    final response = await db.insert('Entries', exp.toJson());
    return response;
  }

  Future<List<EntriesModel>> getEntrieByDate(int month, int year) async {
    final db = await database;
    final response = await db.query('Expenses',
        where: 'month = ? and year = ?', whereArgs: [month, year]);
    List<EntriesModel> eList = response.isNotEmpty
        ? response.map((e) => EntriesModel.fromJson(e)).toList()
        : [];
    return eList;
  }

  Future<int> updateEntries(EntriesModel exp) async {
    final db = await database;
    final response = db
        .update('Entries', exp.toJson(), where: 'id = ?', whereArgs: [exp.id]);
    return response;
  }

  Future<int> deleteEntries(int id) async {
    final db = await database;
    final response = db.delete('Entries', where: 'id = ?', whereArgs: [id]);
    return response;
  }
}
