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
        'CREATE TABLE ingredientTABLE (id INTEGER PRIMARY KEY, name TEXT, image TEXT)');
    db.execute(
        'CREATE TABLE menuTABLE (id INTEGER PRIMARY KEY, nameMenu TEXT, mainIngredient TEXT, userID TEXT, image TEXT)');
    db.execute(
        'CREATE TABLE userTABLE (uid TEXT PRIMARY KEY, name TEXT,username TEXT, image TEXT, ingredients INTEGER, kitchenwares INTEGER)');
    db.execute(
        'CREATE TABLE userKitchenwareTABLE(id INTEGER PRIMARY KEY, uid TEXT, kitchenware TEXT)');
    db.execute(
        'CREATE TABLE userMenuTABLE(id INTEGER PRIMARY KEY, uid TEXT, menuId INTEGER)');
    db.execute(
        'CREATE TABLE followTABLE (id INTEGER PRIMARY KEY, uid TEXT, followedUserID TEXT)');
    db.execute(
        'CREATE TABLE recipeTABLE (id INTEGER PRIMARY KEY, uid TEXT, menuId INTEGER, recipeName TEXT, description TEXT,  timeMinute INTEGER, method TEXT, type TEXT, calories REAL, protein REAL, carb REAL, fat REAL)');
    db.execute(
        'CREATE TABLE reAllergyTABLE(id INTEGER PRIMARY KEY, userID TEXT, allID INTEGER)');
    db.execute(
        'CREATE TABLE recipeIngredientTABLE (id INTEGER PRIMARY KEY, recipeId TEXT, ingredientId INTEGER, amount REAL, unit TEXT)');
    db.execute(
        'CREATE TABLE recipeStepTABLE (id INTEGER PRIMARY KEY, recipeId TEXT, step INTEGER, description TEXT)');
    db.execute(
        'CREATE TABLE userIngredientTABLE (id INTEGER PRIMARY KEY, uid TEXT, ingredientId INTEGER, amount REAL, unit TEXT)');
    db.execute(
        'CREATE TABLE recipeKitchenwareTABLE (id INTEGER PRIMARY KEY, recipeId TEXT,kitchenwareId TEXT)');
    db.execute(
        'CREATE TABLE commentTABLE (id INTEGER PRIMARY KEY, uid TEXT, recipeId INTEGER, text TEXT, date INTEGER)');
    db.execute(
        'CREATE TABLE commentLikeTABLE (id INTEGER PRIMARY KEY, uid TEXT, commentId TEXT)');
    db.execute(
        'CREATE TABLE likeTABLE (id INTEGER PRIMARY KEY, uid TEXT, recipeId INTEGER)');
  }
}
