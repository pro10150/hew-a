import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/reImage_model.dart';
import 'package:intl/intl.dart';

class ReImageHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'reImageTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String nameColumn = 'name';
  final String recipeIdColumn = 'recipeId';

  ReImageHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $recipeIdColumn INTEGER)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(ReImageModel reImageModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, reImageModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<ReImageModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<ReImageModel> reImageModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      ReImageModel reImageModel = ReImageModel.fromJson(map);
      reImageModels.add(reImageModel);
    }
    return reImageModels;
  }

  Future<List<ReImageModel>> readDataFromSQLiteWhereRecipe(int recipeId) async {
    Database database = await connectedDatabase();
    List<ReImageModel> reImageModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase,
        where: '$recipeIdColumn = ?', whereArgs: [recipeId]);
    for (var map in maps) {
      ReImageModel reImageModel = ReImageModel.fromJson(map);
      reImageModels.add(reImageModel);
    }
    return reImageModels;
  }

  Future<Null> deleteDataWhereRecipe(int recipeId) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase,
          where: '$recipeIdColumn = ?', whereArgs: [recipeId]);
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
