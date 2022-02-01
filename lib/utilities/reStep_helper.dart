import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/userIngred_model.dart';

class ReStepHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'recipeStepTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String recipeIdColumn = 'recipeId';
  final String stepColumn = 'step';
  final String descriptionColumn = 'description';

  ReStepHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $recipeIdColumn TEXT, $stepColumn INTEGER, $descriptionColumn TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(UserIngredModel userIngredModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, userIngredModel.toJson());
      print(userIngredModel);
      print('inserted to userIngredModel');
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<UserIngredModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<UserIngredModel> userIngredModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      UserIngredModel userIngredModel = UserIngredModel.fromJson(map);
      userIngredModels.add(userIngredModel);
    }
    return userIngredModels;
  }

  Future<List<UserIngredModel>> readDataFromSQLiteWhereRecipe(
      String recipeId) async {
    Database database = await connectedDatabase();
    List<UserIngredModel> userIngredModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase,
        where: '$recipeIdColumn = ?', whereArgs: [recipeId]);
    for (var map in maps) {
      UserIngredModel userIngredModel = UserIngredModel.fromJson(map);
      userIngredModels.add(userIngredModel);
    }
    return userIngredModels;
  }

  Future<Null> deleteDataWhere(String recipeId, int step) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase,
          where: '$recipeIdColumn = ? AND $stepColumn = ?',
          whereArgs: [recipeId, step]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhereRecipe(String recipeId) async {
    Database database = await connectedDatabase();
    try {
      await database.rawDelete(
          'DELETE FROM $tableDatabase WHERE $recipeIdColumn = ?', [recipeId]);
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
