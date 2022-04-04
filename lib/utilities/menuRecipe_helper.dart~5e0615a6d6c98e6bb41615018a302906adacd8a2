import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'db_helper.dart';
import 'view_helper.dart';

class MenuRecipeHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'menuRecipeTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String uidColumn = 'uid';
  final String nameMenuColumn = 'nameMenu';
  final String recipeNameColumn = 'recipeName';
  final String descriptionColumn = 'description';
  final String timeHourColumn = 'timeHour';
  final String timeMinuteColumn = 'timeMinute';
  final String methodColumn = 'method';
  final String typeColumn = 'type';
  final String caloriesColumn = 'calories';
  final String proteinColumn = 'protein';
  final String carbColumn = 'carb';
  final String fatColumn = 'fat';
  final String mainIngredientColumn = 'mainIngredient';
  final String userIDColumn = 'userID';
  final String imageColumn = 'image';

  MenuRecipeHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $uidColumn TEXT, $nameMenuColumn TEXT, $recipeNameColumn TEXT, $descriptionColumn TEXT, $timeHourColumn INTEGER, $timeMinuteColumn INTEGER, $methodColumn TEXT, $typeColumn TEXT, $caloriesColumn INTEGER, $proteinColumn INTEGER, $carbColumn INTEGER, $fatColumn INTEGER, $mainIngredientColumn TEXT, $userIDColumn TEXT, $imageColumn TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<List<MenuRecipeModel>> readDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<MenuRecipeModel> menuRecipeModels = [];

    List<Map<String, dynamic>> maps = await database.rawQuery(
        'select * from recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient; ');
    for (var map in maps) {
      MenuRecipeModel menuRecipeModel = MenuRecipeModel.fromJson(map);
      menuRecipeModels.add(menuRecipeModel);
    }
    return menuRecipeModels;
  }

  Future<List<MenuRecipeModel>> getAllUserRecipe(String id) async {
    Database database = await connectedDatabase();
    List<MenuRecipeModel> menuRecipeModels = [];
    List<Map<String, dynamic>> maps = await database.rawQuery(
        'select * from recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient; where recipeTABLE.recipeUid = $id');
    for (var map in maps) {
      MenuRecipeModel menuRecipeModel = MenuRecipeModel.fromJson(map);
      menuRecipeModels.add(menuRecipeModel);
    }
    return menuRecipeModels;
  }

  Future<List<MenuRecipeModel>> getLikedRecipe(String id) async {
    Database database = await connectedDatabase();
    List<MenuRecipeModel> menuRecipeModels = [];
    List<Map<String, dynamic>> maps = await database.rawQuery(
        'select * from recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient where recipeTABLE.id = (select recipeId from likeTABLE where uid = ?);',
        [id]);
    for (var map in maps) {
      MenuRecipeModel menuRecipeModel = MenuRecipeModel.fromJson(map);
      menuRecipeModels.add(menuRecipeModel);
    }
    return menuRecipeModels;
  }

  Future<List<MenuRecipeModel>> getTrending() async {
    Database database = await connectedDatabase();
    List<MenuRecipeModel> menuRecipeModels = [];
    List<Map<String, dynamic>> maps = await database.rawQuery(
        "SELECT *, recipeTABLE.id as id FROM recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient inner join likeTABLE on recipeTABLE.id = likeTABLE.recipeId WHERE recipeTABLE.id IN ( SELECT recipeId FROM likeTABLE WHERE DATE(datetime) >= DATE('now', 'weekday 0', '-7 days') GROUP BY recipeId ORDER BY count(recipeId) DESC) GROUP BY likeTABLE.recipeId ORDER BY count(likeTABLE.recipeID) DESC;");
    if (maps.length == 0) {
      return readDataFromSQLite();
    } else {
      for (var map in maps) {
        MenuRecipeModel menuRecipeModel = MenuRecipeModel.fromJson(map);
        menuRecipeModels.add(menuRecipeModel);
      }
      return menuRecipeModels;
    }
  }

  Future<List<MenuRecipeModel>> getUserRecipe(
      String id, String recipeName) async {
    Database database = await connectedDatabase();
    List<MenuRecipeModel> menuRecipeModels = [];
    List<Map<String, dynamic>> maps = await database.query(tableDatabase,
        where: '$uidColumn = ? AND $recipeNameColumn = ?',
        whereArgs: [id, recipeName]);
    for (var map in maps) {
      MenuRecipeModel menuRecipeModel = MenuRecipeModel.fromJson(map);
      menuRecipeModels.add(menuRecipeModel);
    }
    return menuRecipeModels;
  }

  Future<List<MenuRecipeModel>> getFollowing(String uid) async {
    Database database = await connectedDatabase();
    List<MenuRecipeModel> recipeModels = [];
    List<Map<String, dynamic>> maps = await database.rawQuery(
        "SELECT *, recipeTABLE.id as id  FROM recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient WHERE recipeTABLE.recipeUid IN (SELECT followedUserId FROM followTABLE WHERE uid = ?)",
        [uid]);
    for (var map in maps) {
      MenuRecipeModel recipeModel = MenuRecipeModel.fromJson(map);
      recipeModels.add(recipeModel);
    }
    return recipeModels;
  }

  Future<List<MenuRecipeModel>> getDailyPick() async {
    Database database = await connectedDatabase();
    final dbPath = base64.encode(utf8.encode(await DBHelper().getDbPath()));
    final objects = await ViewHelper().readlDataFromSQLite();
    print(objects.runtimeType);
    var dio = Dio();
    final response = await dio.post(
        'http://192.168.1.108:5000/recommendation?uid=' +
            FirebaseAuth.instance.currentUser!.uid,
        data: objects);

    final decoded = response.data as Map<String, dynamic>;
    var uid = decoded['uid'];
    var recommendation = decoded['recommendation'];
    List<MenuRecipeModel> menuRecipeModels = [];
    if (recommendation.length == 0) {
      return getTrending();
    } else {
      List<Map<String, dynamic>> maps = await database.rawQuery(
          "SELECT *, recipeTABLE.id as id FROM recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient WHERE recipeTABLE.id IN (${List.filled(recommendation.length, '?').join(', ')})",
          recommendation);
      for (var map in maps) {
        MenuRecipeModel menuRecipeModel = MenuRecipeModel.fromJson(map);
        menuRecipeModels.add(menuRecipeModel);
      }
      return menuRecipeModels;
    }
  }

  Future<Null> deleteDataWhereId(String id) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase, where: '$uidColumn = $id');
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteAlldata() async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase);
    } catch (e) {
      print('e delete All ==>> ${e.toString()}');
    }
  }
}
