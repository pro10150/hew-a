import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/like_model.dart';

class LikeHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'likeTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String uidColumn = 'uid';
  final String recipeIdColumn = 'recipeId';

  LikeHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $uidColumn TEXT, $recipeIdColumn INTEGER)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(LikeModel likeModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, likeModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<LikeModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<LikeModel> likeModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      LikeModel likeModel = LikeModel.fromJson(map);
      likeModels.add(likeModel);
    }
    return likeModels;
  }

  Future<List<LikeModel>> readDataFromSQLiteWhereUser(String uid) async {
    Database database = await connectedDatabase();
    List<LikeModel> likeModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      LikeModel likeModel = LikeModel.fromJson(map);
      likeModels.add(likeModel);
    }
    return likeModels;
  }

  Future<Null> deleteDataWhere(String uid, String recipeId) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase,
          where: '$uidColumn = ? AND $recipeIdColumn = ?',
          whereArgs: [uid, recipeId]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhereRecipe(String recipeId) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase,
          where: '$recipeIdColumn = ?', whereArgs: [recipeId]);
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
