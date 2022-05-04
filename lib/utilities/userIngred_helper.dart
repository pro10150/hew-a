import 'package:hewa/utilities/query.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/userIngred_model.dart';

class UserIngredHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'userIngredientTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String uidColumn = 'uid';
  final String ingredientIdColumn = 'ingredientId';
  final String amountColumn = 'amount';
  final String unitColumn = 'unit';

  UserIngredHelper() {
    // initDatabase();
  }

  // Future<Null> initDatabase() async {
  //   await openDatabase(join(await getDatabasesPath(), nameDatabase),
  //       onCreate: (db, version) => db.execute(
  //           'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $uidColumn TEXT, $ingredientIdColumn INTEGER, $amountColumn REAL, $unitColumn TEXT)'),
  //       version: version);
  // }

  // Future<Database> connectedDatabase() async {
  //   return openDatabase(join(await getDatabasesPath(), nameDatabase));
  // }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(UserIngredModel userIngredModel) async {
    //Database database = await connectedDatabase();
    try {
      HewaAPI().insert(tableDatabase, userIngredModel.toJson());
      print(userIngredModel);
      print('inserted to userIngredModel');
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<UserIngredModel>> readlDataFromSQLite() async {
    //Database database = await connectedDatabase();
    List<UserIngredModel> userIngredModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      UserIngredModel userIngredModel = UserIngredModel.fromJson(map);
      userIngredModels.add(userIngredModel);
    }
    return userIngredModels;
  }

  Future<List<UserIngredModel>> readDataFromSQLiteWhereUser(String uid) async {
    // Database database = await connectedDatabase();
    List<UserIngredModel> userIngredModels = [];

    List<dynamic> maps = await HewaAPI()
        .query(tableDatabase, where: 'uid = ?', whereArgs: [uid]);
    for (var map in maps) {
      // print(map);
      UserIngredModel userIngredModel = UserIngredModel.fromJson(map);
      userIngredModels.add(userIngredModel);
    }
    return userIngredModels;
  }

  Future<Null> updateDataToSQLite(UserIngredModel userIngredModel) async {
    // Database database = await connectedDatabase();
    try {
      HewaAPI().update(tableDatabase, userIngredModel.toJson(),
          where: '${uidColumn} = ? AND ${ingredientIdColumn} = ?',
          whereArgs: [userIngredModel.uid, userIngredModel.ingredientId]);
    } catch (e) {
      print('e updataData ==>> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhere(String uid, String ingredient) async {
    // Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase,
          where: '$uidColumn = ? AND $ingredientIdColumn = ?',
          whereArgs: [uid, ingredient]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhereUser(String uid) async {
    // Database database = await connectedDatabase();
    try {
      await HewaAPI().rawQuery(
          'DELETE FROM $tableDatabase WHERE $uidColumn = ?',
          values: [uid]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteAlldata() async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase);
    } catch (e) {
      print('e delete All ==>> ${e.toString()}');
    }
  }
}
