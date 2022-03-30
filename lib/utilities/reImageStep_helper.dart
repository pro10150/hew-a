import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/reImageStep_model.dart';
import 'package:intl/intl.dart';

class ReImageStepHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'reImageStepTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String nameColumn = 'name';
  final String recipeIdColumn = 'recipeId';
  final String stepIdColumn = 'stepId';

  ReImageStepHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $stepIdColumn INTEGER)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(ReImageStepModel reImageStepModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, reImageStepModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<ReImageStepModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<ReImageStepModel> reImageStepModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      ReImageStepModel reImageStepModel = ReImageStepModel.fromJson(map);
      reImageStepModels.add(reImageStepModel);
    }
    return reImageStepModels;
  }

  Future<List<ReImageStepModel>> readDataFromSQLiteWhereRecipe(
      int recipeId) async {
    Database database = await connectedDatabase();
    List<ReImageStepModel> reImageStepModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase,
        where: '$recipeIdColumn = ?', whereArgs: [recipeId]);
    for (var map in maps) {
      ReImageStepModel reImageStepModel = ReImageStepModel.fromJson(map);
      reImageStepModels.add(reImageStepModel);
    }
    return reImageStepModels;
  }

  Future<List<ReImageStepModel>> readDataFromSQLiteWhereStep(
      int recipeId, stepId) async {
    Database database = await connectedDatabase();
    List<ReImageStepModel> reImageStepModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase,
        where: '$recipeIdColumn = ? AND $stepIdColumn = ?',
        whereArgs: [recipeId, stepId]);
    for (var map in maps) {
      ReImageStepModel reImageStepModel = ReImageStepModel.fromJson(map);
      reImageStepModels.add(reImageStepModel);
    }
    return reImageStepModels;
  }

  Future<Null> deleteDataWhereRecipe(int stepId) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase,
          where: '$stepIdColumn = ?', whereArgs: [stepId]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhere(int id) async {
    Database database = await connectedDatabase();
    try {
      await database
          .delete(tableDatabase, where: '$idColumn = ?', whereArgs: [id]);
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
