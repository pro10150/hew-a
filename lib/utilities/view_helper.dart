import 'dart:async';
import 'dart:io';
import 'package:hewa/utilities/query.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:collection/collection.dart';
import 'package:hewa/models/view_model.dart';

class ViewHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'viewTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String uidColumn = 'uid';
  final String recipeIdColumn = 'recipeId';
  final String isViewColumn = 'isView';

  ViewHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $uidColumn TEXT, $recipeIdColumn INTEGER, $isViewColumn INTEGER)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(ViewModel viewModel) async {
    //Database database = await connectedDatabase();
    try {
      HewaAPI().insert(tableDatabase, viewModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<Null> initInsertDataToSQLite() async {
    var uid = [
      'x8cKCoJwnqSJZgklwPSBXLtjEgQ2',
      'bpSTXKotc2Qo87o6JbImdJl4Wk43',
      'F4QoZNVQ5kUgZKfdY7etXSI8AFi2',
      'hb8DLE7if5Se2LNrSLcF2OR1uvy1',
      'VaipAkcQYfexWPTX16itUC57t1D2'
    ];
    var isView = [
      [
        1,
        1,
        1,
        1,
        1,
        1,
        0,
        1,
        0,
        0,
        0,
        1,
        0,
        1,
        0,
        1,
        1,
        0,
        0,
        1,
        1,
        1,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        1,
        1,
        1,
        1,
        0,
        0,
        0,
        0,
        1,
        1,
        1,
        1,
        1,
        0,
        0,
        0,
        0,
        1,
        0
      ],
      [
        1,
        1,
        0,
        0,
        1,
        0,
        0,
        1,
        0,
        0,
        0,
        1,
        1,
        1,
        0,
        1,
        1,
        1,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        1,
        1,
        1,
        0,
        0,
        1,
        1,
        1,
        1,
        1,
        1,
        0,
        1,
        1,
        0,
        0,
        0,
        1,
        1
      ],
      [
        1,
        0,
        1,
        1,
        1,
        1,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        1,
        1,
        1,
        1,
        1,
        0,
        1,
        1,
        0,
        0,
        1,
        1,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        1,
        0,
        1,
        1,
        0,
        1,
        0,
        0,
        1,
        1,
        1,
        0,
        1,
        1
      ],
      [
        1,
        0,
        1,
        1,
        1,
        1,
        0,
        0,
        1,
        0,
        1,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        1,
        1,
        1,
        0,
        0,
        0,
        1,
        0,
        0,
        1,
        0,
        1,
        1,
        1,
        1,
        0,
        0,
        1,
        0,
        1,
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        1,
        0,
        1
      ],
      [
        1,
        0,
        1,
        1,
        1,
        0,
        1,
        1,
        0,
        1,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        1,
        1,
        1,
        1,
        1,
        0,
        1,
        1,
        0,
        1,
        0,
        1,
        1,
        0,
        1,
        0,
        1,
        1,
        0,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        1
      ]
    ];
    try {
      uid.forEachIndexed((index, element) {
        isView[index].forEachIndexed((i, e) {
          ViewModel viewModel =
              ViewModel(uid: element, recipeId: i + 1, isView: e);
          insertDataToSQLite(viewModel);
        });
      });
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<ViewModel>> readlDataFromSQLite() async {
    //Database database = await connectedDatabase();
    List<ViewModel> viewModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      ViewModel viewModel = ViewModel.fromJson(map);
      viewModels.add(viewModel);
    }
    return viewModels;
  }

  Future<List<dynamic>> readlDataFromSQLiteAsJSON() async {
    //Database database = await connectedDatabase();

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    return maps;
  }

  Future<List<ViewModel>> readDataFromSQLiteWhereUser(String uid) async {
    // Database database = await connectedDatabase();
    List<ViewModel> viewModels = [];

    List<dynamic> maps = await HewaAPI()
        .query(tableDatabase, where: 'uid = ?', whereArgs: [uid]);
    for (var map in maps) {
      ViewModel viewModel = ViewModel.fromJson(map);
      viewModels.add(viewModel);
    }
    return viewModels;
  }

  Future<Null> updateDataToSQLite(ViewModel viewModel) async {
    // Database database = await connectedDatabase();
    try {
      HewaAPI().update(tableDatabase, viewModel.toJson(),
          where: '${uidColumn} = ? AND ${recipeIdColumn} = ?',
          whereArgs: [viewModel.uid, viewModel.recipeId]);
    } catch (e) {
      print('e updataData ==>> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhere(String uid, String ingredient) async {
    // Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase,
          where: '$uidColumn = ? AND $recipeIdColumn = ?',
          whereArgs: [uid, ingredient]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhereUser(String uid) async {
    // Database database = await connectedDatabase();
    try {
      await HewaAPI()
          .rawDelete('DELETE FROM $tableDatabase WHERE $uidColumn = ?', [uid]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteAlldata() async {
    // Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase);
    } catch (e) {
      print('e delete All ==>> ${e.toString()}');
    }
  }
}
