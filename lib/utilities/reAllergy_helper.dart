import 'package:hewa/utilities/query.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/reAllergy_model.dart';

class ReAllergyHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'reAllergyTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String userIDColumn = 'userID';
  final String allIDColumn = 'allID';

  ReAllergyHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $userIDColumn TEXT, $allIDColumn INTEGER)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(ReAllergyModel reAllergyModel) async {
    //Database database = await connectedDatabase();
    try {
      HewaAPI().insert(tableDatabase, reAllergyModel.toJson());
      print(reAllergyModel);
      print('inserted to reAllergyTABLE');
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<ReAllergyModel>> readlDataFromSQLite() async {
    // Database database = await connectedDatabase();
    List<ReAllergyModel> reAllergyModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      ReAllergyModel reAllergyModel = ReAllergyModel.fromJson(map);
      reAllergyModels.add(reAllergyModel);
    }
    return reAllergyModels;
  }

  Future<List<ReAllergyModel>> readDataFromSQLiteWhereUser(String uid) async {
    // Database database = await connectedDatabase();
    List<ReAllergyModel> reAllergyModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      ReAllergyModel reAllergyModel = ReAllergyModel.fromJson(map);
      reAllergyModels.add(reAllergyModel);
    }
    return reAllergyModels;
  }

  Future<Null> deleteDataWhere(String uid, int allergy) async {
    // Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase,
          where: '$userIDColumn = ? AND $allIDColumn = ?',
          whereArgs: [uid, allergy]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhereUser(String uid) async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI()
          .delete(tableDatabase, where: '$userIDColumn = ?', whereArgs: [uid]);
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
