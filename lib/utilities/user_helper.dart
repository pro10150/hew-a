import 'dart:typed_data';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/models/follow_model.dart';
import 'follow_helper.dart';
import 'query.dart';

class UserHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'userTABLE';
  int version = 1;

  final String uidColumn = 'uid';
  final String nameColumn = 'name';
  final String usernameColumn = 'username';
  final String imageColumn = 'image';
  final String ingredientsColumn = 'ingredients';
  final String kitchenwaresColumn = 'kitchenwares';
  final String isAdminColumn = 'isColumn';
  // final String AllergyID = 'AllergyID';
  // final String AllergyName = 'AllergyName';
  // final String RecipeID = 'RecipeID';
  // final String nameRecipy = 'nameRecipy';
  // final String decrip = 'decrip';
  // final String FoodImage = 'FoodImage';
  // final String Callories = 'Callories';
  // final String type = 'type';
  // final String Quarity = 'Quarity';
  // final String IngreID = 'IngreID';
  // final String nameIngre = 'nameIngre';
  // final String nameKitch = 'nameKitch';
  // final String numStep = 'numStep';
  // final String textStep = 'textStep';
  // final String commentID = 'commentID';
  // final String textComment = 'textComment';

  UserHelper() {
    // initDatabase();
  }

  // Future<Null> initDatabase() async {
  //   await openDatabase(join(await getDatabasesPath(), nameDatabase),
  //       onCreate: (db, version) => db.execute(
  //           'CREATE TABLE $tableDatabase ($uidColumn TEXT PRIMARY KEY, $nameColumn TEXT,$usernameColumn TEXT, $imageColumn TEXT, $ingredientsColumn INTEGER, $kitchenwaresColumn INTEGERS)'),
  //       version: version);
  // }

  // Future<Database> connectedDatabase() async {
  //   return openDatabase(join(await getDatabasesPath(), nameDatabase));
  // }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(UserModel userModel) async {
    print(join(await getDatabasesPath(), nameDatabase));
    //Database database = await connectedDatabase();
    try {
      HewaAPI().insert(tableDatabase, userModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<Null> initInsert() async {
    // Database database = await connectedDatabase();
    var uids = [
      'k2YFM1LkbVaEf4zV4HnhTAmIdRD3',
      'x8cKCoJwnqSJZgklwPSBXLtjEgQ2',
      'bpSTXKotc2Qo87o6JbImdJl4Wk43',
      'F4QoZNVQ5kUgZKfdY7etXSI8AFi2',
      'hb8DLE7if5Se2LNrSLcF2OR1uvy1',
      'VaipAkcQYfexWPTX16itUC57t1D2'
    ];
    uids.forEach((element) {
      UserModel userModel = UserModel(uid: element, username: 'pro10150');
      try {
        HewaAPI().insert(tableDatabase, userModel.toJson());
      } catch (e) {
        print('e insertData ==>> ${e.toString()}');
      }
    });
    UserModel userModel = UserModel(
        uid: "j3I1vMW7xLPCnT3t1L3zUyEw0Ne2", username: "admin", isAdmin: 1);
    try {
      HewaAPI().insert(tableDatabase, userModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<Null> updateDataToSQLite(UserModel userModel) async {
    //Database database = await connectedDatabase();
    try {
      HewaAPI().update(tableDatabase, userModel.toJson(),
          where: '${uidColumn} = ?', whereArgs: [userModel.uid]);
    } catch (e) {
      print('e updateData ==>> ${e.toString()}');
    }
  }

  Future<List<UserModel>> readlDataFromSQLite() async {
    // Database database = await connectedDatabase();
    List<UserModel> userModels = [];

    var maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      UserModel userModel = UserModel.fromJson(map);
      if (userModel.isAdmin != 1) {
        userModels.add(userModel);
      }
    }
    return userModels;
  }

  Future<List<UserModel>> readDataFromSQLiteWhereId(String id) async {
    // Database database = await connectedDatabase();
    List<UserModel> userModels = [];
    List<dynamic> maps = await HewaAPI()
        .query(tableDatabase, where: '$uidColumn = ?', whereArgs: [id]);
    for (var map in maps) {
      UserModel userModel = UserModel.fromJson(map);
      userModels.add(userModel);
    }
    return userModels;
  }

  Future<List<UserModel>> getUserTop5(String uid) async {
    // Database database = await connectedDatabase();
    List<UserModel> userModels = [];
    List<dynamic> maps;
    var objects = await FollowHelper().readlDataFromSQLite();
    if (objects.length > 0) {
      maps = await HewaAPI().rawQuery(
          'SELECT * FROM userTABLE INNER JOIN followTABLE ON userTABLE.uid = followTABLE.uid WHERE userTABLE.uid <> ? AND usertable.uid IN (SELECT uid FROM followTABLE GROUP BY uid ORDER BY count(uid) DESC) GROUP BY followTABLE.uid ORDER BY count(followTABLE.uid) DESC;',
          values: [uid]);
    } else {
      maps = await HewaAPI().query(tableDatabase,
          limit: 6, where: '$uidColumn <> ?', whereArgs: [uid]);
    }
    for (var map in maps) {
      UserModel userModel = UserModel.fromJson(map);
      userModels.add(userModel);
    }
    return userModels;
  }

  Future<List<UserModel>> readDataFromSQLiteWhereUsername(
      String username) async {
    // Database database = await connectedDatabase();
    List<UserModel> userModels = [];
    List<dynamic> maps = await HewaAPI().query(tableDatabase,
        where: '$usernameColumn = ?', whereArgs: [username]);
    for (var map in maps) {
      UserModel userModel = UserModel.fromJson(map);
      userModels.add(userModel);
    }
    return userModels;
  }

  Future<List> allUser() async {
    // Database database = await connectedDatabase();
    return HewaAPI().query(tableDatabase);
  }

  Future<Null> deleteDataWhereId(String id) async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase, where: '$uidColumn = $id');
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteAlldata() async {
    // Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase);
    } catch (e) {
      print('e delete All ==>> ${e.toString()}');
    }
  }
}
