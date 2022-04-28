import 'dart:typed_data';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/report_model.dart';

class ReportHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'reportTABLE';
  int version = 1;

  final String idColumn = "id";
  final String uidColumn = "uid";
  final String typeColumn = "type";
  final String reportedUidColumn = "reportedUid";
  final String reportedRecipeIdColumn = "reportedRecipeId";
  final String aboutColumn = "about";
  final String textColumn = "text";
  final String dateColumn = 'date';

  ReportHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $uidColumn TEXT, $typeColumn INTEGER, $reportedUidColumn TEXT, $reportedRecipeIdColumn INTEGER, $aboutColumn INTEGER, $textColumn TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(ReportModel reportModel) async {
    print(join(await getDatabasesPath(), nameDatabase));
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, reportModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  // Future<Null> initInsert() async {
  //   Database database = await connectedDatabase();
  //   var uids = [
  //     'k2YFM1LkbVaEf4zV4HnhTAmIdRD3',
  //     'x8cKCoJwnqSJZgklwPSBXLtjEgQ2',
  //     'bpSTXKotc2Qo87o6JbImdJl4Wk43',
  //     'F4QoZNVQ5kUgZKfdY7etXSI8AFi2',
  //     'hb8DLE7if5Se2LNrSLcF2OR1uvy1',
  //     'VaipAkcQYfexWPTX16itUC57t1D2'
  //   ];
  //   uids.forEach((element) {
  //     ReportModel reportModel = ReportModel(uid: element, uid: 'pro10150');
  //     try {
  //       database.insert(tableDatabase, reportModel.toJson());
  //     } catch (e) {
  //       print('e insertData ==>> ${e.toString()}');
  //     }
  //   });
  // }

  Future<Null> updateDataToSQLite(ReportModel reportModel) async {
    Database database = await connectedDatabase();
    try {
      database.update(tableDatabase, reportModel.toJson(),
          where: '${idColumn} = ?', whereArgs: [reportModel.id]);
    } catch (e) {
      print('e updateData ==>> ${e.toString()}');
    }
  }

  Future<Null> updateAllDataToSQLite(ReportModel reportModel) async {
    Database database = await connectedDatabase();
    try {
      var objects = await readDataFromSQLiteWhereReportedRecipeId(
          reportModel.reportedRecipeId.toString());
      for (var object in objects) {
        object.isSolve = 1;
        updateDataToSQLite(object);
      }
    } catch (e) {
      print('e updateData ==>> ${e.toString()}');
    }
  }

  Future<Null> updateAllUserToSQLite(ReportModel reportModel) async {
    Database database = await connectedDatabase();
    try {
      var objects =
          await readDataFromSQLiteWhereUid(reportModel.reportedUid.toString());
      for (var object in objects) {
        object.isSolve = 1;
        updateDataToSQLite(object);
      }
    } catch (e) {
      print('e updateData ==>> ${e.toString()}');
    }
  }

  Future<List<ReportModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<ReportModel> reportModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      ReportModel reportModel = ReportModel.fromJson(map);
      reportModels.add(reportModel);
    }
    return reportModels;
  }

  Future<List<ReportModel>> readDataFromSQLiteWhereId(String id) async {
    Database database = await connectedDatabase();
    List<ReportModel> reportModels = [];
    List<Map<String, dynamic>> maps = await database
        .query(tableDatabase, where: '$idColumn = ?', whereArgs: [id]);
    for (var map in maps) {
      ReportModel reportModel = ReportModel.fromJson(map);
      reportModels.add(reportModel);
    }
    return reportModels;
  }

  Future<List<ReportModel>> readDataFromSQLiteWhereReportedRecipeId(
      String id) async {
    Database database = await connectedDatabase();
    List<ReportModel> reportModels = [];
    List<Map<String, dynamic>> maps = await database.query(tableDatabase,
        where: '$reportedRecipeIdColumn = ?', whereArgs: [id]);
    for (var map in maps) {
      ReportModel reportModel = ReportModel.fromJson(map);
      reportModels.add(reportModel);
    }
    return reportModels;
  }

  Future<List<ReportModel>> readDataFromSQLiteWhereUid(String uid) async {
    Database database = await connectedDatabase();
    List<ReportModel> reportModels = [];
    List<Map<String, dynamic>> maps = await database
        .query(tableDatabase, where: '$uidColumn = ?', whereArgs: [uid]);
    for (var map in maps) {
      ReportModel reportModel = ReportModel.fromJson(map);
      reportModels.add(reportModel);
    }
    return reportModels;
  }

  Future<ReportModel> readDataFromSQLiteWhereDateReportedUid(
      String uid, String date) async {
    Database database = await connectedDatabase();
    ReportModel? reportModel;
    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    // List<Map<String, dynamic>> maps = await database
    //     .query(tableDatabase, where: '$dateColumn = ?', whereArgs: [date]);
    for (var map in maps) {
      ReportModel object = ReportModel.fromJson(map);
      if (object.date == date) {
        reportModel = object;
      }
    }
    return reportModel!;
  }

  Future<List<ReportModel>> getAllRecipeReport() async {
    Database database = await connectedDatabase();
    List<ReportModel> reportModels = [];
    List<Map<String, dynamic>> maps =
        await database.query(tableDatabase, where: '$typeColumn = 2');
    for (var map in maps) {
      ReportModel reportModel = ReportModel.fromJson(map);
      reportModels.add(reportModel);
    }
    return reportModels;
  }

  Future<List<ReportModel>> getAllUserReport() async {
    Database database = await connectedDatabase();
    List<ReportModel> reportModels = [];
    List<Map<String, dynamic>> maps =
        await database.query(tableDatabase, where: '$typeColumn = 1');
    for (var map in maps) {
      ReportModel reportModel = ReportModel.fromJson(map);
      reportModels.add(reportModel);
    }
    return reportModels;
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
