import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/models/reAllergy_model.dart';
import 'package:hewa/utilities/reAllergy_helper.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'query.dart';

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

  var _auth = FirebaseAuth.instance;

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

  // getAllergies() async {
  //   reAllergyModels = [];
  //   var objects = await ReAllergyHelper()
  //       .readDataFromSQLiteWhereUser(_auth.currentUser!.uid);
  //   for (var object in objects) {
  //     reAllergyModels.add(object);
  //   }
  // }

  Future<List<MenuRecipeModel>> readDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<MenuRecipeModel> menuRecipeModels = [];
    List<dynamic> maps = [];
    List<ReAllergyModel> reAllergyModels = [];
    var objects = await ReAllergyHelper()
        .readDataFromSQLiteWhereUser(_auth.currentUser!.uid);
    for (var object in objects) {
      reAllergyModels.add(object);
    }
    if (reAllergyModels.length > 0) {
      maps = await HewaAPI().rawQuery(
          'select *, recipeTABLE.id as id, menuTABLE.id as menuId from recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient left join (select * from reallergytable where reallergytable.userid = "${_auth.currentUser!.uid}") on menutable.mainIngredient = allid where allid is null;');
    } else {
      maps = await HewaAPI().rawQuery(
          'select *, recipeTABLE.id as id, menuTABLE.id as menuId from recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient;');
    }
    for (var map in maps) {
      MenuRecipeModel menuRecipeModel = MenuRecipeModel.fromJson(map);
      menuRecipeModels.add(menuRecipeModel);
    }
    return menuRecipeModels;
  }

  Future<List<MenuRecipeModel>> readDataFromSQLiteWhereId(int id) async {
    Database database = await connectedDatabase();
    List<MenuRecipeModel> menuRecipeModels = [];
    List<dynamic> maps = [];
    List<ReAllergyModel> reAllergyModels = [];
    maps = await HewaAPI().rawQuery(
        'select *, recipeTABLE.id as id, menuTABLE.id as menuId from recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient WHERE recipeTABLE.id = ?;',
        values: [id]);

    for (var map in maps) {
      MenuRecipeModel menuRecipeModel = MenuRecipeModel.fromJson(map);
      menuRecipeModels.add(menuRecipeModel);
    }
    return menuRecipeModels;
  }

  Future<List<MenuRecipeModel>> getAllUserRecipe(String id) async {
    Database database = await connectedDatabase();
    List<MenuRecipeModel> menuRecipeModels = [];
    List<dynamic> maps = [];
    maps = await HewaAPI().rawQuery(
        'select *, recipeTABLE.id as id, menuTABLE.id as menuId from recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient where recipeTABLE.recipeUid = ?;',
        values: [id]);

    for (var map in maps) {
      MenuRecipeModel menuRecipeModel = MenuRecipeModel.fromJson(map);
      menuRecipeModels.add(menuRecipeModel);
    }
    return menuRecipeModels;
  }

  Future<List<MenuRecipeModel>> getLikedRecipe(String id) async {
    Database database = await connectedDatabase();
    List<MenuRecipeModel> menuRecipeModels = [];
    List<dynamic> maps = [];
    maps = await HewaAPI().rawQuery(
        'select *, recipeTABLE.id as id, menuTABLE.id as menuId from recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient where recipeTABLE.id in (select recipeId from likeTABLE where uid = ?);',
        values: [id]);

    for (var map in maps) {
      MenuRecipeModel menuRecipeModel = MenuRecipeModel.fromJson(map);
      menuRecipeModels.add(menuRecipeModel);
    }
    return menuRecipeModels;
  }

  Future<List<MenuRecipeModel>> readWhereId(String id) async {
    Database database = await connectedDatabase();
    List<MenuRecipeModel> menuRecipeModels = [];
    List<dynamic> maps = [];
    maps = await HewaAPI().rawQuery(
        'select *, recipeTABLE.id as id from recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient where recipeTABLE.id = $id;',
        values: [id]);

    for (var map in maps) {
      MenuRecipeModel menuRecipeModel = MenuRecipeModel.fromJson(map);
      menuRecipeModels.add(menuRecipeModel);
    }
    return menuRecipeModels;
  }

  Future<List<MenuRecipeModel>> getTrending() async {
    Database database = await connectedDatabase();
    List<MenuRecipeModel> menuRecipeModels = [];
    List<dynamic> maps = [];
    List<ReAllergyModel> reAllergyModels = [];
    var objects = await ReAllergyHelper()
        .readDataFromSQLiteWhereUser(_auth.currentUser!.uid);
    for (var object in objects) {
      reAllergyModels.add(object);
    }
    if (reAllergyModels.length > 0) {
      maps = await HewaAPI().rawQuery(
          "SELECT *, recipeTABLE.id as id, menuTABLE.id as menuId FROM recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient inner join likeTABLE on recipeTABLE.id = likeTABLE.recipeId left join (select * from reallergytable where reallergytable.userid = '${_auth.currentUser!.uid}') on menutable.mainIngredient = allid WHERE allid is null and recipeTABLE.id IN ( SELECT recipeId FROM likeTABLE WHERE DATE(datetime) >= DATE('now', 'weekday 0', '-7 days') GROUP BY recipeId ORDER BY count(recipeId) DESC) GROUP BY likeTABLE.recipeId ORDER BY count(likeTABLE.recipeID) DESC;");
    } else {
      maps = await HewaAPI().rawQuery(
          "SELECT *, recipeTABLE.id as id, menuTABLE.id as menuId FROM recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient inner join likeTABLE on recipeTABLE.id = likeTABLE.recipeId WHERE recipeTABLE.id IN ( SELECT recipeId FROM likeTABLE WHERE DATE(datetime) >= DATE('now', 'weekday 0', '-7 days') GROUP BY recipeId ORDER BY count(recipeId) DESC) GROUP BY likeTABLE.recipeId ORDER BY count(likeTABLE.recipeID) DESC;");
    }
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
    List<dynamic> maps = await HewaAPI().query(tableDatabase,
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
    List<ReAllergyModel> reAllergyModels = [];
    var objects = await ReAllergyHelper()
        .readDataFromSQLiteWhereUser(_auth.currentUser!.uid);
    for (var object in objects) {
      reAllergyModels.add(object);
    }
    List<MenuRecipeModel> recipeModels = [];
    List<dynamic> maps = [];
    if (reAllergyModels.length > 0) {
      maps = await HewaAPI().rawQuery(
          "SELECT *, recipeTABLE.id as id, menuTABLE.id as menuId  FROM recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient left join (select * from reallergytable where reallergytable.userid = '${_auth.currentUser!.uid}') on menutable.mainIngredient = allid WHERE recipeTABLE.recipeUid IN (SELECT uid FROM followTABLE WHERE followedUserId = ?) and allid is null",
          values: [uid]);
    } else {
      maps = await HewaAPI().rawQuery(
          "SELECT *, recipeTABLE.id as id, menuTABLE.id as menuId  FROM recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient WHERE recipeTABLE.recipeUid IN (SELECT uid FROM followTABLE WHERE followedUserId = ?)",
          values: [uid]);
    }
    print("map -> ${maps.length}");
    for (var map in maps) {
      MenuRecipeModel recipeModel = MenuRecipeModel.fromJson(map);
      recipeModels.add(recipeModel);
    }

    return recipeModels;
  }

  Future<List<MenuRecipeModel>> getDailyPick() async {
    Database database = await connectedDatabase();
    // final dbPath = base64.encode(utf8.encode(await DBHelper().getDbPath()));
    final objects = await ViewHelper().readlDataFromSQLite();
    print(objects.runtimeType);
    var dio = Dio();
    print(await NetworkInfo().getWifiIP());
    var ip = await NetworkInfo().getWifiIP();
    final response = await dio.post(
        'https://hew-a.herokuapp.com/recommendation?uid=' +
            FirebaseAuth.instance.currentUser!.uid,
        data: objects);

    final decoded = response.data as Map<String, dynamic>;
    var uid = decoded['uid'];
    var recommendation = decoded['recommendation'];
    List<MenuRecipeModel> menuRecipeModels = [];
    if (recommendation.length == 0) {
      return getTrending();
    } else {
      List<ReAllergyModel> reAllergyModels = [];
      List<String> userId = [];
      var objects = await ReAllergyHelper()
          .readDataFromSQLiteWhereUser(_auth.currentUser!.uid);
      for (var object in objects) {
        reAllergyModels.add(object);
        userId.add(object.userID!);
      }
      List<dynamic> maps = [];
      if (reAllergyModels.length > 0) {
        maps = await HewaAPI().rawQuery(
            "SELECT *, recipeTABLE.id as id, menuTABLE.id as menuId FROM recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient left join (select * from reallergytable where reallergytable.userid = '${_auth.currentUser!.uid}') on menutable.mainIngredient = allid  WHERE recipeTABLE.id IN (${List.filled(recommendation.length, '?').join(', ')})  and allid is null",
            values: recommendation);
      } else {
        maps = await HewaAPI().rawQuery(
            "SELECT *, recipeTABLE.id as id, menuTABLE.id as menuId FROM recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id inner join ingredientTABLE on ingredientTABLE.id = menuTABLE.mainIngredient WHERE recipeTABLE.id IN (${List.filled(recommendation.length, '?').join(', ')}) ",
            values: recommendation);
      }

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
      await HewaAPI().delete(tableDatabase, where: '$uidColumn = $id');
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhereIdRecipe(String recipe) async {
    Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase, where: '$uidColumn = $recipe');
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteAlldata() async {
    Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase);
    } catch (e) {
      print('e delete All ==>> ${e.toString()}');
    }
  }
}
