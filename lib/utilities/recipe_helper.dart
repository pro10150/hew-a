import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hewa/utilities/query.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/Recipe_model.dart';
import 'package:http/http.dart' as http;

import 'db_helper.dart';

class RecipeHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'recipeTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String uidColumn = 'uid';
  final String recipeUidColumn = 'recipeUid';
  final String menuIdColumn = 'menuId';
  final String recipeNameColumn = 'recipeName';
  final String descriptionColumn = 'description';
  final String timeHourColumn = 'timeHour';
  final String timeMinuteColumn = 'timeMinute';
  final String methodColumn = 'method';
  final String typeColumn = 'type';
  final String caloriesColumn = 'calories';
  final String proteinColumn = 'protein';
  final String carbColumn = 'carb';
  final String fatColumn = 'fat';

  MenuHelper() {
    // initDatabase();
  }

  // Future<Null> initDatabase() async {
  //   await openDatabase(join(await getDatabasesPath(), nameDatabase),
  //       onCreate: (db, version) => db.execute(
  //           'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $recipeUidColumn  TEXT, $menuIdColumn TEXT, $recipeNameColumn TEXT, $descriptionColumn TEXT, $timeHourColumn INTEGER, $timeMinuteColumn INTEGER, $methodColumn TEXT, $typeColumn TEXT, $caloriesColumn INTEGER, $proteinColumn INTEGER, $carbColumn INTEGER, $fatColumn INTEGER)'),
  //       version: version);
  // }

  // Future<Database> connectedDatabase() async {
  //   return openDatabase(join(await getDatabasesPath(), nameDatabase));
  // }

//insertข้อมูลและโชว์errorของดาต้าเบส
  // Future<Null> insertDataToSQLite(RecipeModel recipeModel) async {
  //   print(join(await getDatabasesPath(), nameDatabase));
  //   //Database database = await connectedDatabase();
  //   try {
  //     HewaAPI().insert(tableDatabase, recipeModel.toJson());
  //   } catch (e) {
  //     print('e insertData ==>> ${e.toString()}');
  //   }
  // }

  Future<int> insert(RecipeModel recipeModel) async {
    //Database database = await connectedDatabase();
    var results = HewaAPI().insert(tableDatabase, recipeModel.toJson());
    return results;
  }

  Future<int> update(RecipeModel recipeModel) async {
    // Database database = await connectedDatabase();
    var results = HewaAPI().update(tableDatabase, recipeModel.toJson(),
        where: '${idColumn} = ?', whereArgs: [recipeModel.id]);
    return results;
  }

  Future<Null> initInsertDataToSqlite() async {
    var uid = "k2YFM1LkbVaEf4zV4HnhTAmIdRD3";
    List<double> calories = [
      765,
      627.4,
      231.1,
      505.7,
      185.2,
      210,
      590.8,
      181.1,
      558.5,
      684.4,
      62.4,
      125,
      645.5,
      2679.6,
      300,
      452,
      146.9,
      67,
      209,
      46,
      316.9,
      840,
      565.1,
      196,
      414.5,
      500,
      140,
      253,
      320,
      150,
      392,
      166,
      730.4,
      126,
      401.5,
      187.1,
      320,
      273.9,
      197,
      768,
      429.6,
      400.2,
      261.9,
      253,
      381.4,
      107,
      227,
      584,
      520,
      562
    ];
    List<double> carb = [
      89.1,
      15,
      8.9,
      57.6,
      10.3,
      2.7,
      113.3,
      3.9,
      56.3,
      2.2,
      15.7,
      0,
      18.2,
      76.5,
      0,
      8.6,
      22.4,
      9,
      0,
      4,
      41.2,
      78,
      16.8,
      29,
      4.9,
      0,
      10,
      13,
      7.4,
      0,
      11.1,
      1,
      62.1,
      0,
      8.6,
      1.26,
      40,
      3.9,
      28.5,
      98.4,
      46.4,
      20,
      12.9,
      18,
      49.7,
      2,
      18.2,
      55.8,
      58,
      47.62
    ];
    List<double> protein = [
      27.5,
      54.7,
      32.2,
      23,
      21.8,
      14.2,
      33.1,
      20.5,
      25.5,
      27.6,
      0.7,
      0,
      8.2,
      135.5,
      0,
      29.8,
      3.4,
      1,
      20,
      3,
      19.1,
      51.3,
      27.2,
      10,
      54.7,
      0,
      7,
      13.8,
      43.8,
      213,
      18.1,
      23,
      38.6,
      9.9,
      21.3,
      12.65,
      14,
      31.6,
      10.4,
      42.1,
      20.4,
      60,
      19.6,
      17,
      12.8,
      11,
      12.9,
      14.1,
      50.4,
      38.29
    ];
    List<double> fat = [
      32.2,
      37.2,
      6.4,
      19.6,
      6.6,
      16.4,
      0.4,
      9.5,
      24.9,
      62.8,
      0.4,
      0,
      60,
      217.1,
      0,
      34.6,
      5.1,
      3,
      14,
      2,
      7.8,
      36.4,
      43.3,
      4.5,
      18.7,
      0,
      8,
      16.2,
      14.2,
      5.6,
      30.4,
      7.1,
      35.2,
      9.6,
      31.8,
      14.62,
      20,
      13.9,
      4.5,
      30,
      20.2,
      10,
      14.1,
      6,
      14.1,
      6,
      17,
      34.1,
      9.1,
      23.54
    ];
    List<int> minutes = [
      90,
      15,
      13,
      90,
      30,
      120,
      15,
      20,
      190,
      10,
      10,
      10,
      70,
      30,
      30,
      20,
      60,
      15,
      30,
      25,
      45,
      80,
      20,
      40,
      60,
      30,
      50,
      190,
      10,
      30,
      70,
      30,
      10,
      80,
      25,
      30,
      10,
      15,
      25,
      20,
      30,
      30,
      20,
      30,
      20,
      135,
      35,
      30,
      60,
      12
    ];
    var type = [
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว",
      "คาว"
    ];
    var method = [
      "Boil",
      "Fry",
      "Fry",
      "Boil",
      "Boil",
      "Boil",
      "Bake",
      "Boil",
      "Boil",
      "Fry",
      "Mix",
      "Pickle",
      "Fry",
      "Boil",
      "Fry",
      "Bake",
      "Boil",
      "Boil",
      "Gril",
      "Mix",
      "Fry",
      "Bake",
      "Fry",
      "Fry",
      "Boil",
      "Fry",
      "Steam",
      "Boil",
      "Boil",
      "Mix",
      "Fry",
      "Fry",
      "Fry",
      "Steam",
      "Fry",
      "Fry",
      "Fry",
      "Boil",
      "Fry",
      "Fry",
      "Fry",
      "Fry",
      "Grill",
      "Fry",
      "Fry",
      "Fry",
      "Mix",
      "Fry",
      "Mix",
      "Mix"
    ];
    var menuId = List<int>.generate(calories.length, (int index) => index);
    // Database database = await connectedDatabase();
    try {
      menuId.forEach((index) {
        RecipeModel recipeModel = RecipeModel(
            recipeUid: uid,
            recipeName: "Test",
            menuId: menuId[index] + 1,
            calories: calories[index],
            carb: carb[index],
            protein: protein[index],
            fat: fat[index],
            timeMinute: minutes[index],
            type: type[index],
            method: method[index]);
        // database.insert(tableDatabase, recipeModel.toJson());
      });
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<Null> updateDataToSQLite(RecipeModel recipeModel) async {
    // Database database = await connectedDatabase();
    try {
      HewaAPI().update(tableDatabase, recipeModel.toJson(),
          where: '${idColumn} = ?', whereArgs: [recipeModel.id]);
    } catch (e) {
      print('e updateData ==>> ${e.toString()}');
    }
  }

  Future<List<RecipeModel>> readlDataFromSQLite() async {
    //Database database = await connectedDatabase();
    List<RecipeModel> recipeModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      RecipeModel recipeModel = RecipeModel.fromJson(map);
      recipeModels.add(recipeModel);
    }
    return recipeModels;
  }

  Future<List<RecipeModel>> readDataFromSQLiteRecipe(
      RecipeModel recipeModel) async {
    //Database database = await connectedDatabase();
    List<RecipeModel> recipeModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase,
        where:
            '$menuIdColumn = ? and $recipeNameColumn = ? and $recipeUidColumn = ?',
        whereArgs: [
          recipeModel.menuId,
          recipeModel.recipeName,
          recipeModel.recipeUid
        ]);
    for (var map in maps) {
      RecipeModel recipeModel = RecipeModel.fromJson(map);
      recipeModels.add(recipeModel);
      print(map);
    }
    return recipeModels;
  }

  Future<List<RecipeModel>> readDataFromSQLiteId(
      RecipeModel recipeModel) async {
    //Database database = await connectedDatabase();
    List<RecipeModel> recipeModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase,
        where: '$recipeUidColumn = ?', whereArgs: [recipeModel.recipeUid]);
    for (var map in maps) {
      RecipeModel recipeModel = RecipeModel.fromJson(map);
      recipeModels.add(recipeModel);
      print(map);
    }
    return recipeModels;
  }

  Future<List<RecipeModel>> readDataFromSQLiteWhereId(int id) async {
    //Database database = await connectedDatabase();
    List<RecipeModel> recipeModels = [];
    List<dynamic> maps = await HewaAPI()
        .query(tableDatabase, where: '$idColumn = ?', whereArgs: [id]);
    for (var map in maps) {
      RecipeModel recipeModel = RecipeModel.fromJson(map);
      recipeModels.add(recipeModel);
    }
    return recipeModels;
  }

  Future<List<RecipeModel>> getAllUserRecipe(String id) async {
    //Database database = await connectedDatabase();
    List<RecipeModel> recipeModels = [];
    List<dynamic> maps = await HewaAPI()
        .query(tableDatabase, where: '$recipeUidColumn = ?', whereArgs: [id]);
    for (var map in maps) {
      RecipeModel recipeModel = RecipeModel.fromJson(map);
      recipeModels.add(recipeModel);
    }
    return recipeModels;
  }

  Future<List<RecipeModel>> getUserRecipe(String id, String recipeName) async {
    //Database database = await connectedDatabase();
    List<RecipeModel> recipeModels = [];
    List<dynamic> maps = await HewaAPI().query(tableDatabase,
        where: '$uidColumn = ? AND $recipeNameColumn = ?',
        whereArgs: [id, recipeName]);
    for (var map in maps) {
      RecipeModel recipeModel = RecipeModel.fromJson(map);
      recipeModels.add(recipeModel);
    }
    return recipeModels;
  }

  Future<List<RecipeModel>> getTrending() async {
    //Database database = await connectedDatabase();
    List<RecipeModel> recipeModels = [];
    List<dynamic> maps = await HewaAPI().rawQuery(
        "SELECT * FROM recipeTABLE WHERE id IN ( SELECT distinct recipeId FROM likeTABLE WHERE DATE(datetime) >= DATE('now', 'weekday 0', '-7 days') GROUP BY recipeId ORDER BY count(recipeId) DESC);");
    for (var map in maps) {
      RecipeModel recipeModel = RecipeModel.fromJson(map);
      recipeModels.add(recipeModel);
    }
    return recipeModels;
  }

  Future<List<RecipeModel>> getFollowing(String uid) async {
    //Database database = await connectedDatabase();
    List<RecipeModel> recipeModels = [];
    List<dynamic> maps = await HewaAPI().rawQuery(
        "SELECT * FROM recipeTABLE WHERE uid IN (SELECT followedUserId FROM followTABLE WHERE uid = $uid)");
    for (var map in maps) {
      RecipeModel recipeModel = RecipeModel.fromJson(map);
      recipeModels.add(recipeModel);
    }
    return recipeModels;
  }

  Future<List<RecipeModel>> getDailyPick() async {
    //Database database = await connectedDatabase();
    final dbPath = base64.encode(utf8.encode(await DBHelper().getDbPath()));
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:5000/recommendation?uid=' +
            FirebaseAuth.instance.currentUser!.uid +
            "&databaseLocation=" +
            dbPath));

    final decoded = json.decode(response.body) as Map<String, dynamic>;
    var uid = decoded['uid'];
    var recommendation = decoded['recommendation'];

    List<RecipeModel> recipeModels = [];
    if (recommendation.length > 0) {
      return getFollowing(uid);
    } else {
      List<dynamic> maps = await HewaAPI().query(tableDatabase,
          where:
              '$idColumn IN ${List.filled(recommendation.length, '?').join(',')}',
          whereArgs: recommendation);
      for (var map in maps) {
        RecipeModel recipeModel = RecipeModel.fromJson(map);
        recipeModels.add(recipeModel);
      }
      return recipeModels;
    }
  }

  Future<Null> deleteDataWhereId(String id) async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase, where: '$idColumn = $id');
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhereUser(String id) async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase, where: '$uidColumn = $id');
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
