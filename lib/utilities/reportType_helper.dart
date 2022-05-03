import 'dart:typed_data';

import 'package:hewa/utilities/query.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/reportType_model.dart';

class ReportTypeHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'reportTypeTABLE';
  int version = 1;

  final String idColumn = "id";
  final String typeNameColumn = "typeName";

  ReportTypeHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $typeNameColumn TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(ReportTypeModel reportTypeModel) async {
    print(join(await getDatabasesPath(), nameDatabase));
    // Database database = await connectedDatabase();
    try {
      HewaAPI().insert(tableDatabase, reportTypeModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<Null> initInsert() async {
    Database database = await connectedDatabase();
    var typeNames = ["user", "recipe"];
    typeNames.forEach((element) {
      ReportTypeModel reportTypeModel = ReportTypeModel(typeName: element);
      try {
        database.insert(tableDatabase, reportTypeModel.toJson());
      } catch (e) {
        print('e insertData ==>> ${e.toString()}');
      }
    });
  }

  Future<List<ReportTypeModel>> readlDataFromSQLite() async {
    // Database database = await connectedDatabase();
    List<ReportTypeModel> reportTypeModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      ReportTypeModel reportTypeModel = ReportTypeModel.fromJson(map);
      reportTypeModels.add(reportTypeModel);
    }
    return reportTypeModels;
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
