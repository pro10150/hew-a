import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/report_join_model.dart';
import 'package:http/http.dart' as http;

import 'db_helper.dart';

class ReIngredIngredHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'menuRecipeTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String uidColumn = 'uid';
  final String typeColumn = 'type';
  final String reportedUidColumn = 'reportedUid';
  final String reportedReciopeId = 'reportedRecipeId';
  final String aboutColumn = 'about';
  final String textColumn = 'text';
  final String dateColumn = 'date';
  final String typeNameColumn = 'typeName';
  final String aboutNameColumn = 'aboutName';
  final String aboutTypeColumn = 'aboutType';

  ReIngredIngredHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<List<ReportJoinModel>> readDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<ReportJoinModel> reportJoinModels = [];

    List<Map<String, dynamic>> maps = await database.rawQuery(
        'select *,reportTABLE.id as id from reportTABLE inner join reportTypeTABLE on reportTABLE.type = reportTypeTABLE.id inner join reportAboutTABLE on reportTABLE.about = reportAboutTABLE.id; ');
    for (var map in maps) {
      ReportJoinModel reportJoinModel = ReportJoinModel.fromJson(map);
      reportJoinModels.add(reportJoinModel);
    }
    return reportJoinModels;
  }

  Future<List<ReportJoinModel>> readDataFromSQLiteWhereId(int id) async {
    Database database = await connectedDatabase();
    List<ReportJoinModel> reportJoinModels = [];

    List<Map<String, dynamic>> maps = await database.rawQuery(
        'select *,reportTABLE.id as id from reportTABLE inner join reportTypeTABLE on reportTABLE.type = reportTypeTABLE.id inner join reportAboutTABLE on reportTABLE.about = reportAboutTABLE.id WHERE recipeIngredientTABLE.recipeId = $id;');
    for (var map in maps) {
      ReportJoinModel reportJoinModel = ReportJoinModel.fromJson(map);
      reportJoinModels.add(reportJoinModel);
    }
    return reportJoinModels;
  }
}
