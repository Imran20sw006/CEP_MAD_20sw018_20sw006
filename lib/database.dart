import 'package:path_provider/path_provider.dart';
import 'package:calculator/datamodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; 
import 'dart:io' as io;

class Helper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationCacheDirectory();
    String path = join(documentDirectory.path, 'bmi2.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE bmi2 (id INTEGER PRIMARY KEY AUTOINCREMENT, height INTEGER NOT NULL, weight INTEGER NOT NULL, bmi TEXT NOT NULL)"
    );
  }

  Future<BMiMODEL> insert(BMiMODEL dbmodel) async {
    var dbClient = await db;
    await dbClient!.insert('bmi2', dbmodel.toMap());
    print("data has been saved");
    return dbmodel;
  }

  Future<List<BMiMODEL>> getNOteList() async{
    var dbClient = await db;
    final List<Map<String, Object?>> querryResult = await dbClient!.query("bmi2");
    return querryResult.map((e) => BMiMODEL.fromMap(e)).toList();
  }
  

}
