import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/like_model.dart';
import 'package:intl/intl.dart';

class LikeHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'likeTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String uidColumn = 'uid';
  final String recipeIdColumn = 'recipeId';
  final String datetimeColumn = 'datetime';

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

  Future<Null> initInsertDataToSQLite() async {
    Database database = await connectedDatabase();
    var likeUsers = {
      'VaipAkcQYfexWPTX16itUC57t1D2': [1, 3, 5, 7, 10],
      'hb8DLE7if5Se2LNrSLcF2OR1uvy1': [1, 3, 5, 8, 9],
      'F4QoZNVQ5kUgZKfdY7etXSI8AFi2': [1],
      'bpSTXKotc2Qo87o6JbImdJl4Wk43': [1, 3, 6, 2],
      'x8cKCoJwnqSJZgklwPSBXLtjEgQ2': [1, 3]
    };
    try {
      likeUsers.forEach((key, value) {
        for (var i in value) {
          Map<String, dynamic> row = {
            uidColumn: key,
            recipeIdColumn: i,
            datetimeColumn:
                DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
          };
          database.insert(tableDatabase, row);
        }
      });
    } catch (e) {
      print('e insert like data ==>> ${e.toString()}');
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

    List<Map<String, dynamic>> maps = await database
        .query(tableDatabase, where: '$uidColumn = ?', whereArgs: [uid]);
    for (var map in maps) {
      LikeModel likeModel = LikeModel.fromJson(map);
      likeModels.add(likeModel);
    }
    return likeModels;
  }

  Future<List<LikeModel>> readDataFromSQLiteWhereRecipe(String id) async {
    Database database = await connectedDatabase();
    List<LikeModel> likeModels = [];

    List<Map<String, dynamic>> maps = await database
        .query(tableDatabase, where: '$recipeIdColumn = ?', whereArgs: [id]);
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

  Future<Null> deleteDataWhereUser(String id) async {
    Database database = await connectedDatabase();
    try {
      await database
          .delete(tableDatabase, where: '$uidColumn = ?', whereArgs: [id]);
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
