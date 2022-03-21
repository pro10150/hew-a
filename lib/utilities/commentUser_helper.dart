import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/commentUser_model.dart';
import 'package:http/http.dart' as http;

import 'db_helper.dart';

class CommentUserHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'commentUserTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String recipeIdColumn = 'recipeId';
  final String nameColumn = 'name';
  final String typeColumn = ' type';
  final String imageColumn = 'image';
  final String amountColumn = 'amount';
  final String unitColumn = 'unit';

  CommentUserHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<List<CommentUserModel>> readDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<CommentUserModel> commentUserModels = [];

    List<Map<String, dynamic>> maps = await database.rawQuery(
        'select * from commentTABLE inner join userTABLE on commentTABLE.uid = userTABLE.uid;');
    for (var map in maps) {
      CommentUserModel commentUserModel = CommentUserModel.fromJson(map);
      commentUserModels.add(commentUserModel);
    }
    return commentUserModels;
  }

  Future<List<CommentUserModel>> readDataFromSQLiteWhereRecipeId(
      String recipeId) async {
    Database database = await connectedDatabase();
    List<CommentUserModel> commentUserModels = [];

    List<Map<String, dynamic>> maps = await database.rawQuery(
        'SELECT * FROM ingredientTABLE INNER join recipeIngredientTABLE ON commentTABLE.uid = userTABLE.uid WHERE commentTABLE.recipeId = $recipeId;');
    for (var map in maps) {
      CommentUserModel commentUserModel = CommentUserModel.fromJson(map);
      commentUserModels.add(commentUserModel);
    }
    return commentUserModels;
  }
}
