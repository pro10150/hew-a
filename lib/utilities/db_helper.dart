import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  final String nameDatabase = 'Hewa.db';
  int version = 1;

  final String idColumn = 'id';
  final String nameKitcColumn = 'nameKitc';
  final String nameColumn = 'name';
  final String nameMenuColumn = 'nameMenu';
  final String mainIngredientColumn = 'mainIngredient';
  final String userIDColumn = 'userID';
  final String uidColumn = 'uid';
  final String usernameColumn = 'username';
  final String imageColumn = 'image';

  Future<Null> deleteDB() async {
    await deleteDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), nameDatabase),
      onCreate: (db, version) => {_createDb(db)},
      version: 1,
    );
  }

  static void _createDb(Database db) {
    db.execute(
        'CREATE TABLE kitchenwareTABLE (id INTEGER PRIMARY KEY, nameKitc TEXT)');
    db.execute(
        'CREATE TABLE ingredientTABLE (id INTEGER PRIMARY KEY, name TEXT)');
    db.execute(
        'CREATE TABLE menuTABLE (id INTEGER PRIMARY KEY, nameMenu TEXT, mainIngredient TEXT, userID TEXT)');
    db.execute(
        'CREATE TABLE userTABLE (uid TEXT PRIMARY KEY, name TEXT,username TEXT image BLOB)');
    db.execute(
        'CREATE TABLE userKitchenwareTABLE(id INTEGER PRIMARY KEY, uid TEXT, kitchenware INTEGER)');
    db.execute(
        'CREATE TABLE followTABLE (id INTEGER PRIMARY KEY, uid TEXT, followedUserID TEXT)');
    db.execute(
        'CREATE TABLE recipeTABLE (id INTEGER PRIMARY KEY, uid TEXT, nameMenu TEXT, recipeName TEXT, description TEXT, timeHour INTEGER, timeMinute INTEGER, method TEXT, type TEXT, calories INTEGER, protein INTEGER, carb INTEGER, fat INTEGER)');
  }
}
