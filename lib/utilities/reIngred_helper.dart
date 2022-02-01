import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/reIngred_model.dart';

class ReIngredHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'recipeIngredientTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String recipeIdColumn = 'recipeId';
  final String ingredientIdColumn = 'ingredientId';
  final String amountColumn = 'amount';
  final String unitColumn = 'unit';

  ReIngredHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $recipeIdColumn TEXT, $ingredientIdColumn INTEGER, $amountColumn REAL, $unitColumn TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(ReIngredModel reIngredModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, reIngredModel.toJson());
      print(reIngredModel);
      print('inserted to reIngredModel');
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<ReIngredModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<ReIngredModel> reIngredModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      ReIngredModel reIngredModel = ReIngredModel.fromJson(map);
      reIngredModels.add(reIngredModel);
    }
    return reIngredModels;
  }

  Future<List<ReIngredModel>> readDataFromSQLiteWhereRecipe(
      String recipeId) async {
    Database database = await connectedDatabase();
    List<ReIngredModel> reIngredModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase,
        where: '$recipeIdColumn = ?', whereArgs: [recipeId]);
    for (var map in maps) {
      ReIngredModel reIngredModel = ReIngredModel.fromJson(map);
      reIngredModels.add(reIngredModel);
    }
    return reIngredModels;
  }

  Future<Null> deleteDataWhere(String recipeId, String kitchenware) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase,
          where: '$recipeIdColumn = ? AND $ingredientIdColumn = ?',
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
