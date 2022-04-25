import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';
import 'package:hewa/models/reKitchenware_model.dart';

class ReKitchenwareHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'recipeKitchenwareTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String recipeIdColumn = 'recipeId';
  final String kitchenwareIdColumn = 'kitchenwareId';
  ReKitchenwareHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $recipeIdColumn TEXT,$kitchenwareIdColumn TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(ReKitchenwareModel reKitchenwareModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, reKitchenwareModel.toJson());
    } catch (e) {
      print('e insertReKitchenwareData ==>> ${e.toString()}');
    }
  }

  Future<int> insert(ReKitchenwareModel reKitchenwareModel) async {
    Database database = await connectedDatabase();
    var results = database.insert(tableDatabase, reKitchenwareModel.toJson());
    return results;
  }

  Future<Null> initInsertDataToSQLite() async {
    var kitchenwares = [
      [3, 11, 2, 1, 8, 7],
      [1, 2, 11, 8, 7],
      [2, 11, 8, 7],
      [2, 11, 12, 27],
      [3, 24, 8, 7],
      [3, 24, 12, 27, 8, 7],
      [8, 7, 3, 24],
      [2, 11],
      [2, 11, 26],
      [2, 11, 25],
      [12, 27],
      [25],
      [2, 11, 8, 7],
      [3, 24, 8, 7],
      [2, 11, 8, 7],
      [8, 7, 2, 11],
      [3, 24, 28],
      [8, 7, 3, 24],
      [10],
      [29],
      [3, 2, 11],
      [2, 7, 30, 10],
      [8, 7, 25, 2, 11],
      [2, 11],
      [12, 27, 25, 3, 24],
      [2, 11],
      [6, 31],
      [3, 24, 12, 27],
      [25, 3, 24],
      [8, 7, 25],
      [3, 24, 32, 12, 27, 2, 11],
      [2, 11],
      [8, 7, 2, 11],
      [2, 11, 31],
      [2, 11, 8, 7],
      [8, 7, 25, 2, 11],
      [25, 2, 11],
      [2, 11, 8, 7],
      [25, 2, 11, 35, 36, 8, 7],
      [33, 34, 2, 11, 3, 8, 7],
      [2, 11, 25],
      [37, 29, 2, 11, 8, 7],
      [8, 2, 11],
      [25, 38, 34, 2, 11],
      [2, 11, 25],
      [25, 2, 11, 35, 36, 8, 7],
      [25, 34, 2, 11],
      [3, 39, 2, 11],
      [12, 27, 2, 11, 33],
      [33, 34]
    ];
    try {
      kitchenwares.forEachIndexed((index, element) {
        element.forEach((value) {
          ReKitchenwareModel reKitchenwareModel = ReKitchenwareModel(
              recipeId: (index + 1).toString(), kitchenwareId: value);
          insertDataToSQLite(reKitchenwareModel);
        });
      });
    } catch (e) {
      print('e initInsertKitchenwareData ==>> ${e.toString()}');
    }
  }

  Future<int> update(ReKitchenwareModel reKitchenwareModel) async {
    Database database = await connectedDatabase();
    var results = database.update(tableDatabase, reKitchenwareModel.toJson(),
        where: '${idColumn} = ?', whereArgs: [reKitchenwareModel.id]);
    return results;
  }

  Future<List<ReKitchenwareModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<ReKitchenwareModel> reKitchenwareModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      ReKitchenwareModel reKitchenwareModel = ReKitchenwareModel.fromJson(map);
      reKitchenwareModels.add(reKitchenwareModel);
    }
    return reKitchenwareModels;
  }

  Future<List<ReKitchenwareModel>> readDataFromSQLiteWhereId(int id) async {
    Database database = await connectedDatabase();
    List<ReKitchenwareModel> reKitchenwareModels = [];
    List<Map<String, dynamic>> maps = await database
        .query(tableDatabase, where: '$idColumn = ?', whereArgs: [id]);
    for (var map in maps) {
      ReKitchenwareModel reKitchenwareModel = ReKitchenwareModel.fromJson(map);
      reKitchenwareModels.add(reKitchenwareModel);
    }
    return reKitchenwareModels;
  }

  Future<List<ReKitchenwareModel>> readDataFromSQLiteWhereRecipe(
      String recipeId) async {
    Database database = await connectedDatabase();
    List<ReKitchenwareModel> reKitchenwareModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase,
        where: '$recipeIdColumn = ?', whereArgs: [recipeId]);
    for (var map in maps) {
      ReKitchenwareModel reKitchenwareModel = ReKitchenwareModel.fromJson(map);
      reKitchenwareModels.add(reKitchenwareModel);
    }
    return reKitchenwareModels;
  }

  Future<Null> deleteDataWhere(String recipeId, String kitchenware) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase,
          where: '$recipeIdColumn = ? AND $kitchenwareIdColumn = ?',
          whereArgs: [recipeId, kitchenware]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhereUser(String uid) async {
    Database database = await connectedDatabase();
    try {
      await database.rawDelete(
          'DELETE FROM $tableDatabase WHERE $recipeIdColumn = ?', [uid]);
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
