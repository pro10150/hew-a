import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/reIngredIngred_model.dart';
import 'package:http/http.dart' as http;

import 'db_helper.dart';

class ReIngredIngredHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'menuRecipeTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String recipeIdColumn = 'recipeId';
  final String nameColumn = 'name';
  final String typeColumn = ' type';
  final String imageColumn = 'image';
  final String amountColumn = 'amount';
  final String unitColumn = 'unit';

  ReIngredIngredHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $recipeIdColumn TEXT, $nameColumn TEXT, $typeColumn TEXT, $imageColumn TEXT, $amountColumn REAL, $unitColumn TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<List<ReIngredIngredModel>> readDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<ReIngredIngredModel> reIngredIngredModels = [];

    List<Map<String, dynamic>> maps = await database.rawQuery(
        'select *,ingredientTABLE.id as id from ingredientTABLE inner join recipeIngredientTABLE on ingredientTABLE.id = recipeIngredientTABLE.recipeId; ');
    for (var map in maps) {
      ReIngredIngredModel reIngredIngredModel =
          ReIngredIngredModel.fromJson(map);
      reIngredIngredModels.add(reIngredIngredModel);
    }
    return reIngredIngredModels;
  }

  Future<List<ReIngredIngredModel>> readDataFromSQLiteWhereRecipeId(
      String recipeId) async {
    Database database = await connectedDatabase();
    List<ReIngredIngredModel> reIngredIngredModels = [];

    List<Map<String, dynamic>> maps = await database.rawQuery(
        'SELECT *,ingredientTABLE.id as id FROM ingredientTABLE INNER join recipeIngredientTABLE ON ingredientTABLE.id = recipeIngredientTABLE.ingredientId WHERE recipeIngredientTABLE.recipeId = $recipeId;');
    for (var map in maps) {
      ReIngredIngredModel reIngredIngredModel =
          ReIngredIngredModel.fromJson(map);
      reIngredIngredModels.add(reIngredIngredModel);
    }
    return reIngredIngredModels;
  }
}
