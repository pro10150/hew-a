import 'package:hewa/utilities/reStep_helper.dart';
import 'package:hewa/utilities/recipe_helper.dart';
import 'package:hewa/utilities/user_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'ingred_helper.dart';
import 'kitch_helper.dart';
import 'menu.helper.dart';
import 'reIngred_helper.dart';
import 'reKitchenware_helper.dart';
import 'view_helper.dart';
import 'like_helper.dart';
import 'method_helper.dart';
import 'comment_helper.dart';
import 'reportAbout_helper.dart';
import 'reportType_helper.dart';

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
    print(join(await getDatabasesPath(), nameDatabase));
    return openDatabase(
      join(await getDatabasesPath(), nameDatabase),
      onCreate: (db, version) => {_createDb(db)},
      version: 1,
    );
  }

  Future<String> getDbPath() async {
    return join(await getDatabasesPath(), nameDatabase);
  }

  static void _createDb(Database db) {
    db.execute(
        'CREATE TABLE kitchenwareTABLE (id INTEGER PRIMARY KEY, nameKitc TEXT)');
    db.execute(
        'CREATE TABLE ingredientTABLE (id INTEGER PRIMARY KEY, name TEXT, image TEXT)');
    db.execute(
        'CREATE TABLE menuTABLE (id INTEGER PRIMARY KEY, nameMenu TEXT, descMenu TEXT, mainIngredient INTEGER, userID TEXT, menuImage TEXT, methodid INTEGER)');
    db.execute(
        'CREATE TABLE userTABLE (uid TEXT PRIMARY KEY, name TEXT,username TEXT, image TEXT, ingredients INTEGER, kitchenwares INTEGER, isAdmin INTEGER)');
    db.execute(
        'CREATE TABLE userKitchenwareTABLE(id INTEGER PRIMARY KEY, uid TEXT, kitchenware TEXT)');
    db.execute(
        'CREATE TABLE userMenuTABLE(id INTEGER PRIMARY KEY, uid TEXT, menuId INTEGER)');
    db.execute(
        'CREATE TABLE followTABLE (id INTEGER PRIMARY KEY, uid TEXT, followedUserID TEXT)');
    db.execute(
        'CREATE TABLE recipeTABLE (id INTEGER PRIMARY KEY, recipeUid TEXT, menuId INTEGER, recipeName TEXT, description TEXT,  timeMinute INTEGER, method TEXT, type TEXT, calories REAL, protein REAL, carb REAL, fat REAL)');
    db.execute(
        'CREATE TABLE reAllergyTABLE(id INTEGER PRIMARY KEY, userID TEXT, allID INTEGER)');
    db.execute(
        'CREATE TABLE recipeIngredientTABLE (id INTEGER PRIMARY KEY, recipeId TEXT, ingredientId INTEGER, amount REAL, unit TEXT)');
    db.execute(
        'CREATE TABLE recipeStepTABLE (id INTEGER PRIMARY KEY, recipeId TEXT, step INTEGER, minute INTEGER, description TEXT)');
    db.execute(
        'CREATE TABLE userIngredientTABLE (id INTEGER PRIMARY KEY, uid TEXT, ingredientId INTEGER, amount REAL, unit TEXT)');
    db.execute(
        'CREATE TABLE recipeKitchenwareTABLE (id INTEGER PRIMARY KEY, recipeId TEXT,kitchenwareId INTEGER)');
    db.execute(
        'CREATE TABLE commentTABLE (id INTEGER PRIMARY KEY, uid TEXT, recipeId INTEGER, text TEXT, date INTEGER)');
    db.execute(
        'CREATE TABLE commentLikeTABLE (id INTEGER PRIMARY KEY, uid TEXT, commentId TEXT)');
    db.execute(
        'CREATE TABLE likeTABLE (id INTEGER PRIMARY KEY, uid TEXT, recipeId INTEGER, datetime TEXT)');
    db.execute(
        'CREATE TABLE viewTABLE (id INTEGER PRIMARY KEY, uid TEXT, recipeId INTEGER, isView INTEGER, UNIQUE(uid, recipeId))');
    db.execute(
        'CREATE TABLE menuRecipeTABLE (id INTEGER PRIMARY KEY, uid TEXT, nameMenu TEXT, recipeName TEXT, description TEXT, timeHour INTEGER, timeMinute INTEGER, method TEXT, type TEXT, calories INTEGER, protein INTEGER, carb INTEGER, fat INTEGER, mainIngredient TEXT, userID TEXT, image TEXT)');
    db.execute(
        'CREATE TABLE methodTABLE (methodid INTEGER PRIMARY KEY, nameMethod TEXT)');
    db.execute(
        'CREATE TABLE reImageTABLE (id INTEGER PRIMARY KEY, name TEXT, recipeId INTEGER)');
    db.execute(
        'CREATE TABLE reImageStepTABLE (id INTEGER PRIMARY KEY, recipeId INTEGER, stepId INTEGER, name TEXT)');
    db.execute(
        'CREATE TABLE reportTABLE (id INTEGER PRIMARY KEY, uid TEXT, type INTEGER, reportedUid TEXT, reportedRecipeId INTEGER, about INTEGER, text TEXT, date TEXT)');
    db.execute(
        'CREATE TABLE reportTypeTABLE (id INTEGER PRIMARY KEY, typeName TEXT)');
    db.execute(
        'CREATE TABLE reportAboutTABLE (id INTEGER PRIMARY KEY, aboutName Text, aboutType INTEGER)');
    db.execute(
        'CREATE TABLE reportImageTABLE (id INTEGER PRIMARY KEY, reportId INTEGER, imagePath TEXT)');
  }

  void initInsert() {
    MenuHelper().initInsertToSQLite();
    IngredHelper().initInsertToSQLite();
    KitchHelper().initialInsert();
    UserHelper().initInsert();
    RecipeHelper().initInsertDataToSqlite();
    ReStepHelper().initInsertDataToSQLite();
    ReIngredHelper().initInsertDataToSQLite();
    ReKitchenwareHelper().initInsertDataToSQLite();
    ViewHelper().initInsertDataToSQLite();
    LikeHelper().initInsertDataToSQLite();
    MethodHelper().initInsertDataToSqlite();
    CommentHelper().initInsert();
    ReportAboutHelper().initInsert();
    ReportTypeHelper().initInsert();
  }
}
