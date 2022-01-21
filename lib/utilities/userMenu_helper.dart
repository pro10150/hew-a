import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/userMenu_model.dart';

class UserMenuHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'userMenuTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String uidColumn = 'uid';
  final String menuIdColumn = 'menuId';

  UserMenuHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $uidColumn TEXT, $menuIdColumn INTEGER)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(UserMenuModel userMenuModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, userMenuModel.toJson());
      print(userMenuModel);
      print('inserted to userKitchenware');
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<UserMenuModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<UserMenuModel> userMenuModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      UserMenuModel userMenuModel = UserMenuModel.fromJson(map);
      userMenuModels.add(userMenuModel);
    }
    return userMenuModels;
  }

  Future<List<UserMenuModel>> readDataFromSQLiteWhereUser(String uid) async {
    Database database = await connectedDatabase();
    List<UserMenuModel> userMenuModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      UserMenuModel userMenuModel = UserMenuModel.fromJson(map);
      userMenuModels.add(userMenuModel);
    }
    return userMenuModels;
  }

  Future<Null> deleteDataWhere(String uid, int menuId) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase,
          where: '$uidColumn = ? AND $menuIdColumn = ?',
          whereArgs: [uid, menuId]);
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
