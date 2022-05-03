import 'dart:typed_data';

import 'package:hewa/utilities/query.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/reportAbout_model.dart';

class ReportAboutHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'reportAboutTABLE';
  int version = 1;

  final String idColumn = "id";
  final String aboutNameColumn = "aboutName";
  final String aboutTypeColumn = "aboutType";

  ReportAboutHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $aboutNameColumn TEXT, $aboutTypeColumn INTEGER)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(ReportAboutModel reportAboutModel) async {
    print(join(await getDatabasesPath(), nameDatabase));
    //Database database = await connectedDatabase();
    try {
      HewaAPI().insert(tableDatabase, reportAboutModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<Null> initInsert() async {
    Database database = await connectedDatabase();
    List<ReportAboutModel> reportAboutModels = [
      ReportAboutModel(aboutType: 1, aboutName: 'สแปม'),
      ReportAboutModel(aboutType: 1, aboutName: 'ใช้คำไม่สุภาพ'),
      ReportAboutModel(aboutType: 1, aboutName: 'คุกคามความเป็นส่วนตัว'),
      ReportAboutModel(aboutType: 1, aboutName: 'อื่น'),
      ReportAboutModel(aboutType: 2, aboutName: 'คัดลอกสูตรอาหารคนอื่น'),
      ReportAboutModel(aboutType: 2, aboutName: 'ใช้คำไม่สุภาพ'),
      ReportAboutModel(aboutType: 2, aboutName: 'คอนเทนต์ไม่เหมาะสม'),
      ReportAboutModel(aboutType: 2, aboutName: 'อื่นๆ')
    ];
    reportAboutModels.forEach((element) {
      ReportAboutModel reportAboutModel = ReportAboutModel(
          aboutName: element.aboutName, aboutType: element.aboutType);
      try {
        database.insert(tableDatabase, reportAboutModel.toJson());
      } catch (e) {
        print('e insertData ==>> ${e.toString()}');
      }
    });
  }

  Future<List<ReportAboutModel>> readlDataFromSQLite() async {
    //Database database = await connectedDatabase();
    List<ReportAboutModel> reportAboutModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      ReportAboutModel reportAboutModel = ReportAboutModel.fromJson(map);
      reportAboutModels.add(reportAboutModel);
    }
    return reportAboutModels;
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
