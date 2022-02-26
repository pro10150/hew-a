import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:http/http.dart' as http;

import 'db_helper.dart';

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

  Future<List<MenuRecipeModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<MenuRecipeModel> menuRecipeModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
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
        'select * from recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id; where recipeTABLE.uid = $id');
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
        'select * from recipeTABLE inner join menuTABLE on recipeTABLE.menuId = menuTABLE.id where recipeTABLE.id = (select recipeId from likeTABLE where uid = ?);',
        [id]);
    for (var map in maps) {
      MenuRecipeModel menuRecipeModel = MenuRecipeModel.fromJson(map);
      menuRecipeModels.add(menuRecipeModel);
    }
    return menuRecipeModels;
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
