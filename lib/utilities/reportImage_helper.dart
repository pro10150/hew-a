import 'dart:typed_data';

import 'package:hewa/utilities/query.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/reportImage_model.dart';

class ReportImageHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'reportImageTABLE';
  int version = 1;

  final String idColumn = "id";
  final String reportIdColumn = "reportId";
  final String imagePathColumn = "imagePath";

  ReportImageHelper() {
    // initDatabase();
  }

  // Future<Null> initDatabase() async {
  //   await openDatabase(join(await getDatabasesPath(), nameDatabase),
  //       onCreate: (db, version) => db.execute(
  //           'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $reportIdColumn INTEGER, $imagePathColumn TEXT)'),
  //       version: version);
  // }

  // Future<Database> connectedDatabase() async {
  //   return openDatabase(join(await getDatabasesPath(), nameDatabase));
  // }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(ReportImageModel reportImageModel) async {
    print(join(await getDatabasesPath(), nameDatabase));
    //Database database = await connectedDatabase();
    try {
      HewaAPI().insert(tableDatabase, reportImageModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<ReportImageModel>> readlDataFromSQLite() async {
    //Database database = await connectedDatabase();
    List<ReportImageModel> reportImageModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      ReportImageModel reportImageModel = ReportImageModel.fromJson(map);
      reportImageModels.add(reportImageModel);
    }
    return reportImageModels;
  }

  Future<List<ReportImageModel>> readWhereId(String id) async {
    //Database database = await connectedDatabase();
    List<ReportImageModel> reportImageModels = [];

    List<dynamic> maps = await HewaAPI()
        .query(tableDatabase, where: "reportId = ?", whereArgs: [id]);
    for (var map in maps) {
      ReportImageModel reportImageModel = ReportImageModel.fromJson(map);
      reportImageModels.add(reportImageModel);
    }
    return reportImageModels;
  }

  Future<Null> deleteDataWhereId(String id) async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase, where: '$idColumn = $id');
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteAlldata() async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase);
    } catch (e) {
      print('e delete All ==>> ${e.toString()}');
    }
  }
}
