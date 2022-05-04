import 'package:hewa/utilities/query.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/method_model.dart';

class MethodHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'methodTABLE';
  int version = 1;

  final String methodidColumn = 'methodid';
  final String nameMethodColumn = 'nameMethod';

  MethodHelper() {
    // initDatabase();
  }

  // Future<Null> initDatabase() async {
  //   await openDatabase(join(await getDatabasesPath(), nameDatabase),
  //       onCreate: (db, version) => db.execute(
  //           'CREATE TABLE $tableDatabase ($methodidColumn INTEGER PRIMARY KEY, $nameMethodColumn TEXT)'),
  //       version: version);
  // }

  // Future<Database> connectedDatabase() async {
  //   return openDatabase(join(await getDatabasesPath(), nameDatabase));
  // }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(MethodModel methodModel) async {
    print(join(await getDatabasesPath(), nameDatabase));
    // Database database = await connectedDatabase();
    try {
      HewaAPI().insert(tableDatabase, methodModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<Null> initInsertDataToSqlite() async {
    // Database database = await connectedDatabase();
    List<String> methods = [
      'Boil',
      'Fry',
      'Bake',
      'Mix',
      'Pickle',
      'Grill',
      'Steam',
    ];
    methods.asMap().forEach((key, value) async {
      Map<String, dynamic> row = {
        nameMethodColumn: value,
      };
      // database.insert(tableDatabase, row);
    });
  }

  // Future<List<MethodModel>> getAllCategories() async {
  //   Database database = await connectedDatabase();
  //   List<Map<String, dynamic>> allRows = await database.query(tableDatabase);
  //   List<MethodModel> methods =
  //   allRows.map((methodModel) => MethodModel.fromJson(methodModel)).toList();
  //   return methods;
  // }

  Future<List<MethodModel>> getMethod() async {
    // Database database = await connectedDatabase();
    List<Map> list = HewaAPI().rawQuery("SELECT * FROM methodTABLE");
    List<MethodModel> _methods = [];
    for (int i = 0; i < list.length; i++) {
      _methods.add(new MethodModel(methodid: null, nameMethod: ''));
    }
    return _methods;
  }

  Future<Null> updateDataToSQLite(MethodModel methodModel) async {
    // Database database = await connectedDatabase();
    try {
      HewaAPI().update(tableDatabase, methodModel.toJson(),
          where: '${methodidColumn} = ? AND ${nameMethodColumn} = ?',
          whereArgs: [methodModel.methodid, methodModel.nameMethod]);
    } catch (e) {
      print('e updateData ==>> ${e.toString()}');
    }
  }

  Future<List<MethodModel>> readDataFromSQLite() async {
    //Database database = await connectedDatabase();
    List<MethodModel> methodModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      MethodModel methodModel = MethodModel.fromJson(map);
      methodModels.add(methodModel);
    }
    return methodModels;
  }

  Future<Null> deleteDataWhereId(String id) async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase, where: '$methodidColumn = $id');
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
