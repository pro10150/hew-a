import 'package:hewa/screen/add/recipe_step_1.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/userKitch_model.dart';

class UserKitchHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'userKitchenwareTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String uidColumn = 'uid';
  final String kitchenwareColumn = 'kitchenware';

  UserKitchHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $uidColumn TEXT, $kitchenwareColumn TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(
      UserKitchenwareModel userKitchenwareModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, userKitchenwareModel.toJson());
      print(userKitchenwareModel);
      print('inserted to userKitchenware');
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<UserKitchenwareModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<UserKitchenwareModel> userKitchenwareModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      UserKitchenwareModel userKitchenwareModel =
          UserKitchenwareModel.fromJson(map);
      userKitchenwareModels.add(userKitchenwareModel);
    }
    return userKitchenwareModels;
  }

  Future<List<UserKitchenwareModel>> readDataFromSQLiteWhereUser(
      String uid) async {
    Database database = await connectedDatabase();
    List<UserKitchenwareModel> userKitchenwareModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      UserKitchenwareModel userKitchenwareModel =
          UserKitchenwareModel.fromJson(map);
      userKitchenwareModels.add(userKitchenwareModel);
    }
    return userKitchenwareModels;
  }

  Future<Null> deleteDataWhere(String uid, String kitchenware) async {
    Database database = await connectedDatabase();
    print(uid);
    print(kitchenware);
    try {
      await database.delete(tableDatabase,
          where: '$uidColumn = ? AND $kitchenwareColumn = ?',
          whereArgs: [uid, kitchenware]);
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
