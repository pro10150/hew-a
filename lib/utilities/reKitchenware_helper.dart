import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/reKitchenware_model.dart';

class ReIngredHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'recipeKitchenwareTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String recipeIdColumn = 'recipeId';
  final String kitchenwareIdColumn = 'kitchenwareId';
  ReIngredHelper() {
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
      print(reKitchenwareModel);
      print('inserted to reIngredModel');
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
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
