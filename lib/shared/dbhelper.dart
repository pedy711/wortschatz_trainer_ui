import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:wortschatz_trainer/models/user.dart';
import 'package:wortschatz_trainer/shared/constants.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  String tblUser      = "user";
  String colId        = "id";
  String colEmail     = "email";
  String colPassword  = "password";
  String colEnabled   = "enabled";
  String colCreatedOn = "createdOn";

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if(_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + Constants.APP_NAME_ENGLISH + ".db";
    var dbApp = await openDatabase(path,
        version: Constants.APP_VERSION, onCreate: _createDb);
    return dbApp;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblUser($colId INTEGER PRIMARY KEY, $colEmail TEXT, " +
            "$colPassword TEXT)");
  }

  Future<int> insertUser(User user) async {
    Database db = await this.db;
    var result = await db.insert(tblUser, user.toJson());
    return result;
  }
  
  Future<List> getUsers() async {
    Database db = await this.db;
    var resutlt = await db.rawQuery("SELECT * FROM $tblUser order by $colEmail ASC");
    return resutlt;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
      await db.rawQuery("SELECT count (*) from $tblUser")
    );
    return result;
  }
  
  Future<int> updateUser(User user) async {
    var db = await this.db;
    var result = await db.update(tblUser, user.toJson(),
      where: "$colId = ?", whereArgs: [user.id]);
    return result;
  }

  Future<int> deleteUser(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete('DELETE FROM $tblUser WHERE $colId = $id');
    return result;
  }
}
