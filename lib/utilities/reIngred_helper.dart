import 'package:hewa/utilities/query.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';
import 'package:hewa/models/reIngred_model.dart';

class ReIngredHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'recipeIngredientTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String recipeIdColumn = 'recipeId';
  final String ingredientIdColumn = 'ingredientId';
  final String amountColumn = 'amount';
  final String unitColumn = 'unit';

  ReIngredHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $recipeIdColumn TEXT, $ingredientIdColumn INTEGER, $amountColumn REAL, $unitColumn TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(ReIngredModel reIngredModel) async {
    //Database database = await connectedDatabase();
    try {
      HewaAPI().insert(tableDatabase, reIngredModel.toJson());
    } catch (e) {
      print('e insertReIngredData ==>> ${e.toString()}');
    }
  }

  Future<int> insert(ReIngredModel reIngredModel) async {
    // Database database = await connectedDatabase();
    var results = HewaAPI().insert(tableDatabase, reIngredModel.toJson());
    return results;
  }

  Future<Null> initInsertDataToSQLite() async {
    var ingred = [
      {"recipeId": 1, "ingredId": 3},
      {"recipeId": 1, "ingredId": 27, "amount": 3.00},
      {"recipeId": 1, "ingredId": 157, "amount": 6.00},
      {"recipeId": 1, "ingredId": 48, "amount": 6.00},
      {"recipeId": 1, "ingredId": 33, "amount": 30.00},
      {"recipeId": 1, "ingredId": 30, "unit": "tbsp", "amount": 1.50},
      {"recipeId": 1, "ingredId": 105, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 1, "ingredId": 41, "unit": "cup", "amount": 2.00},
      {"recipeId": 1, "ingredId": 43, "unit": "tbsp", "amount": 3.00},
      {"recipeId": 1, "ingredId": 34, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 1, "ingredId": 93},
      {"recipeId": 1, "ingredId": 40},
      {"recipeId": 2, "ingredId": 75, "unit": "cup", "amount": 3.00},
      {"recipeId": 2, "ingredId": 109, "unit": "tbsp", "amount": 4.00},
      {"recipeId": 2, "ingredId": 27},
      {"recipeId": 2, "ingredId": 53, "unit": "g", "amount": 500.00},
      {"recipeId": 2, "ingredId": 1, "amount": 3.00},
      {"recipeId": 2, "ingredId": 43, "unit": "tbsp", "amount": 4.00},
      {"recipeId": 2, "ingredId": 31},
      {"recipeId": 2, "ingredId": 29, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 2, "ingredId": 14},
      {"recipeId": 2, "ingredId": 180},
      {"recipeId": 3, "ingredId": 2, "unit": "g", "amount": 300.00},
      {"recipeId": 3, "ingredId": 116, "unit": "g", "amount": 50.00},
      {"recipeId": 3, "ingredId": 32, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 3, "ingredId": 27, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 3, "ingredId": 52, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 3, "ingredId": 28, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 3, "ingredId": 189, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 3, "ingredId": 109, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 4, "ingredId": 141, "unit": "g", "amount": 70.00},
      {"recipeId": 4, "ingredId": 164, "unit": "g", "amount": 300.00},
      {"recipeId": 4, "ingredId": 46, "unit": "ml", "amount": 250.00},
      {"recipeId": 4, "ingredId": 181, "unit": "ml", "amount": 400.00},
      {"recipeId": 4, "ingredId": 150, "unit": "g", "amount": 100.00},
      {"recipeId": 4, "ingredId": 151, "unit": "g", "amount": 50.00},
      {"recipeId": 4, "ingredId": 44, "amount": 3.00},
      {"recipeId": 4, "ingredId": 144, "amount": 2.00},
      {"recipeId": 4, "ingredId": 190, "unit": "g", "amount": 15.00},
      {"recipeId": 4, "ingredId": 28, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 4, "ingredId": 55, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 4, "ingredId": 56, "unit": "g", "amount": 44.00},
      {"recipeId": 4, "ingredId": 27, "unit": "g", "amount": 18.00},
      {"recipeId": 4, "ingredId": 30, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 4, "ingredId": 57, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 4, "ingredId": 157, "unit": "g", "amount": 2.00},
      {"recipeId": 4, "ingredId": 33, "amount": 10.00},
      {"recipeId": 4, "ingredId": 144, "amount": 10.00},
      {"recipeId": 4, "ingredId": 191, "amount": 15.00},
      {"recipeId": 4, "ingredId": 45, "unit": "g", "amount": 6.00},
      {"recipeId": 4, "ingredId": 47, "unit": "g", "amount": 6.00},
      {"recipeId": 4, "ingredId": 138, "unit": "tbsp", "amount": 0.25},
      {"recipeId": 4, "ingredId": 160, "unit": "g", "amount": 2.00},
      {"recipeId": 4, "ingredId": 156, "unit": "g", "amount": 1.00},
      {"recipeId": 4, "ingredId": 158, "unit": "tbsp", "amount": 0.20},
      {"recipeId": 5, "ingredId": 12, "unit": "g", "amount": 600.00},
      {"recipeId": 5, "ingredId": 47, "amount": 1.00},
      {"recipeId": 5, "ingredId": 44, "amount": 1.00},
      {"recipeId": 5, "ingredId": 191, "amount": 10.00},
      {"recipeId": 5, "ingredId": 193, "amount": 7.00},
      {"recipeId": 5, "ingredId": 107, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 5, "ingredId": 98, "unit": "tbsp", "amount": 7.00},
      {"recipeId": 5, "ingredId": 28, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 5, "ingredId": 29, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 5, "ingredId": 49, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 5, "ingredId": 56, "amount": 6.00},
      {"recipeId": 5, "ingredId": 194},
      {"recipeId": 5, "ingredId": 65},
      {"recipeId": 6, "ingredId": 1, "amount": 10.00},
      {"recipeId": 6, "ingredId": 195, "unit": "tbsp", "amount": 3.00},
      {"recipeId": 6, "ingredId": 206, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 6, "ingredId": 179, "unit": "kg", "amount": 0.50},
      {"recipeId": 6, "ingredId": 33, "amount": 15.00},
      {"recipeId": 6, "ingredId": 157, "amount": 3.00},
      {"recipeId": 6, "ingredId": 27, "unit": "clove", "amount": 10.00},
      {"recipeId": 6, "ingredId": 109, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 6, "ingredId": 197, "unit": "tbsp", "amount": 4.00},
      {"recipeId": 6, "ingredId": 198, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 6, "ingredId": 30, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 7, "ingredId": 70, "amount": 5.00},
      {"recipeId": 7, "ingredId": 36, "unit": "g", "amount": 150.00},
      {"recipeId": 7, "ingredId": 179, "amount": 5.00},
      {"recipeId": 7, "ingredId": 157, "amount": 1.00},
      {"recipeId": 7, "ingredId": 33, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 7, "ingredId": 27, "unit": "clove", "amount": 2.00},
      {"recipeId": 7, "ingredId": 48, "unit": "slice", "amount": 3.00},
      {"recipeId": 7, "ingredId": 43, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 7, "ingredId": 28, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 7, "ingredId": 37, "unit": "tbsp", "amount": 1.50},
      {"recipeId": 7, "ingredId": 189, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 7, "ingredId": 184, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 7, "ingredId": 110, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 7, "ingredId": 34, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 7, "ingredId": 199, "unit": "cup", "amount": 1.00},
      {"recipeId": 7, "ingredId": 35, "amount": 3.00},
      {"recipeId": 7, "ingredId": 62, "amount": 2.00},
      {"recipeId": 7, "ingredId": 200},
      {"recipeId": 8, "ingredId": 4, "unit": "g", "amount": 300.00},
      {"recipeId": 8, "ingredId": 143, "unit": "g", "amount": 50.00},
      {"recipeId": 8, "ingredId": 69, "unit": "g", "amount": 270.00},
      {"recipeId": 8, "ingredId": 201, "unit": "tbsp", "amount": 15.00},
      {"recipeId": 8, "ingredId": 28, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 8, "ingredId": 44},
      {"recipeId": 8, "ingredId": 32},
      {"recipeId": 9, "ingredId": 16, "amount": 1.00},
      {"recipeId": 9, "ingredId": 125, "unit": "tbsp", "amount": 3.00},
      {"recipeId": 9, "ingredId": 202},
      {"recipeId": 9, "ingredId": 171},
      {"recipeId": 9, "ingredId": 157},
      {"recipeId": 9, "ingredId": 27},
      {"recipeId": 9, "ingredId": 48},
      {"recipeId": 9, "ingredId": 92},
      {"recipeId": 9, "ingredId": 52},
      {"recipeId": 9, "ingredId": 34},
      {"recipeId": 9, "ingredId": 48},
      {"recipeId": 9, "ingredId": 41},
      {"recipeId": 9, "ingredId": 93},
      {"recipeId": 9, "ingredId": 203},
      {"recipeId": 9, "ingredId": 40},
      {"recipeId": 10, "ingredId": 1, "amount": 3.00},
      {"recipeId": 10, "ingredId": 2, "unit": "cup", "amount": 0.50},
      {"recipeId": 10, "ingredId": 43, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 10, "ingredId": 37, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 10, "ingredId": 204, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 10, "ingredId": 34, "unit": "tbsp", "amount": 4.00},
      {"recipeId": 11, "ingredId": 64},
      {"recipeId": 11, "ingredId": 95},
      {"recipeId": 11, "ingredId": 14},
      {"recipeId": 11, "ingredId": 32},
      {"recipeId": 11, "ingredId": 49},
      {"recipeId": 11, "ingredId": 27},
      {"recipeId": 11, "ingredId": 28},
      {"recipeId": 11, "ingredId": 55},
      {"recipeId": 11, "ingredId": 71},
      {"recipeId": 12, "ingredId": 1, "amount": 4.00},
      {"recipeId": 12, "ingredId": 28, "unit": "ml", "amount": 125.00},
      {"recipeId": 12, "ingredId": 205, "unit": "ml", "amount": 250.00},
      {"recipeId": 12, "ingredId": 55, "unit": "cup", "amount": 0.30},
      {"recipeId": 12, "ingredId": 32},
      {"recipeId": 12, "ingredId": 35},
      {"recipeId": 13, "ingredId": 179, "unit": "g", "amount": 300.00},
      {"recipeId": 13, "ingredId": 165, "unit": "g", "amount": 200.00},
      {"recipeId": 13, "ingredId": 43, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 13, "ingredId": 31, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 13, "ingredId": 222, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 13, "ingredId": 37, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 13, "ingredId": 189, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 13, "ingredId": 55, "unit": "tbsp", "amount": 3.00},
      {"recipeId": 13, "ingredId": 56, "amount": 4.00},
      {"recipeId": 13, "ingredId": 34, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 14, "ingredId": 164, "unit": "g", "amount": 400.00},
      {"recipeId": 14, "ingredId": 182, "unit": "g", "amount": 200.00},
      {"recipeId": 14, "ingredId": 46, "unit": "ml", "amount": 300.00},
      {"recipeId": 14, "ingredId": 181, "unit": "ml", "amount": 500.00},
      {"recipeId": 14, "ingredId": 47, "unit": "slice", "amount": 5.00},
      {"recipeId": 14, "ingredId": 45, "amount": 3.00},
      {"recipeId": 14, "ingredId": 44, "amount": 5.00},
      {"recipeId": 14, "ingredId": 28, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 14, "ingredId": 32, "unit": "g", "amount": 10.00},
      {"recipeId": 14, "ingredId": 49, "amount": 1.00},
      {"recipeId": 14, "ingredId": 30, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 15, "ingredId": 75, "unit": "cup", "amount": 3.00},
      {"recipeId": 15, "ingredId": 27, "unit": "cup", "amount": 1.00},
      {"recipeId": 15, "ingredId": 10, "unit": "cup", "amount": 1.00},
      {"recipeId": 15, "ingredId": 21, "unit": "tbsp", "amount": 1.50},
      {"recipeId": 15, "ingredId": 84, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 15, "ingredId": 29, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 15, "ingredId": 30, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 15, "ingredId": 33, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 15, "ingredId": 35, "unit": "tbsp", "amount": 3.00},
      {"recipeId": 16, "ingredId": 6, "amount": 1.00},
      {"recipeId": 16, "ingredId": 27, "unit": "clove", "amount": 3.00},
      {"recipeId": 16, "ingredId": 13, "unit": "g", "amount": 200.00},
      {"recipeId": 16, "ingredId": 121, "unit": "g", "amount": 100.00},
      {"recipeId": 16, "ingredId": 99, "unit": "cup", "amount": 1.00},
      {"recipeId": 16, "ingredId": 21, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 16, "ingredId": 30, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 16, "ingredId": 33, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 16, "ingredId": 148},
      {"recipeId": 17, "ingredId": 39, "amount": 3.00},
      {"recipeId": 17, "ingredId": 162, "unit": "cup", "amount": 0.50},
      {"recipeId": 17, "ingredId": 115, "unit": "cup", "amount": 0.50},
      {"recipeId": 17, "ingredId": 97, "unit": "cup", "amount": 1.00},
      {"recipeId": 17, "ingredId": 30, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 17, "ingredId": 33, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 17, "ingredId": 207},
      {"recipeId": 17, "ingredId": 147, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 18, "ingredId": 183, "amount": 10.00},
      {"recipeId": 18, "ingredId": 180, "unit": "cup", "amount": 0.25},
      {"recipeId": 18, "ingredId": 103, "unit": "cup", "amount": 1.00},
      {"recipeId": 18, "ingredId": 162, "unit": "cup", "amount": 0.50},
      {"recipeId": 18, "ingredId": 30, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 18, "ingredId": 208, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 18, "ingredId": 114, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 18, "ingredId": 51, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 19, "ingredId": 15, "unit": "kg", "amount": 2.00},
      {"recipeId": 19, "ingredId": 86, "unit": "g", "amount": 150.00},
      {"recipeId": 19, "ingredId": 209, "unit": "cup", "amount": 0.50},
      {"recipeId": 19, "ingredId": 30, "unit": "cup", "amount": 0.50},
      {"recipeId": 19, "ingredId": 130, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 19, "ingredId": 129, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 19, "ingredId": 131, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 19, "ingredId": 210, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 19, "ingredId": 127, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 19, "ingredId": 128, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 19, "ingredId": 186},
      {"recipeId": 20, "ingredId": 137},
      {"recipeId": 20, "ingredId": 187, "amount": 2.00},
      {"recipeId": 20, "ingredId": 27, "unit": "clove", "amount": 2.00},
      {"recipeId": 20, "ingredId": 154, "unit": "cup", "amount": 1.00},
      {"recipeId": 20, "ingredId": 211, "unit": "cup", "amount": 0.30},
      {"recipeId": 20, "ingredId": 212, "unit": "cup", "amount": 0.25},
      {"recipeId": 20, "ingredId": 152, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 20, "ingredId": 108, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 20, "ingredId": 163, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 20, "ingredId": 111, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 20, "ingredId": 30},
      {"recipeId": 20, "ingredId": 210},
      {"recipeId": 21, "ingredId": 174, "unit": "g", "amount": 300.00},
      {"recipeId": 21, "ingredId": 10, "unit": "g", "amount": 100.00},
      {"recipeId": 21, "ingredId": 111, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 21, "ingredId": 114, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 21, "ingredId": 27, "unit": "clove", "amount": 4.00},
      {"recipeId": 21, "ingredId": 180, "unit": "g", "amount": 100.00},
      {"recipeId": 21, "ingredId": 82, "unit": "cup", "amount": 0.50},
      {"recipeId": 21, "ingredId": 1, "amount": 1.00},
      {"recipeId": 21, "ingredId": 30, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 21, "ingredId": 33, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 21, "ingredId": 83},
      {"recipeId": 22, "ingredId": 66},
      {"recipeId": 22, "ingredId": 152},
      {"recipeId": 22, "ingredId": 10},
      {"recipeId": 22, "ingredId": 65},
      {"recipeId": 22, "ingredId": 119},
      {"recipeId": 22, "ingredId": 114},
      {"recipeId": 22, "ingredId": 1},
      {"recipeId": 22, "ingredId": 90},
      {"recipeId": 23, "ingredId": 168, "unit": "g", "amount": 300.00},
      {"recipeId": 23, "ingredId": 118, "unit": "cup", "amount": 0.50},
      {"recipeId": 23, "ingredId": 30, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 23, "ingredId": 33, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 23, "ingredId": 34, "unit": "cup", "amount": 2.00},
      {"recipeId": 23, "ingredId": 27, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 23, "ingredId": 169, "unit": "cup", "amount": 0.50},
      {"recipeId": 23, "ingredId": 180, "amount": 1.00},
      {"recipeId": 23, "ingredId": 213, "amount": 0.50},
      {"recipeId": 23, "ingredId": 214, "amount": 0.50},
      {"recipeId": 23, "ingredId": 89, "unit": "cup", "amount": 0.50},
      {"recipeId": 23, "ingredId": 189, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 23, "ingredId": 43, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 24, "ingredId": 140},
      {"recipeId": 24, "ingredId": 112, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 24, "ingredId": 157, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 24, "ingredId": 27, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 24, "ingredId": 210, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 24, "ingredId": 178, "unit": "g", "amount": 150.00},
      {"recipeId": 24, "ingredId": 36, "unit": "g", "amount": 200.00},
      {"recipeId": 24, "ingredId": 216},
      {"recipeId": 24, "ingredId": 52, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 24, "ingredId": 87, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 24, "ingredId": 189, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 24, "ingredId": 63},
      {"recipeId": 24, "ingredId": 25},
      {"recipeId": 24, "ingredId": 94},
      {"recipeId": 24, "ingredId": 77, "amount": 1.00},
      {"recipeId": 24, "ingredId": 34},
      {"recipeId": 25, "ingredId": 139, "amount": 20.00},
      {"recipeId": 25, "ingredId": 215, "unit": "g", "amount": 100.00},
      {"recipeId": 25, "ingredId": 2, "unit": "g", "amount": 100.00},
      {"recipeId": 25, "ingredId": 27, "unit": "clove", "amount": 1.00},
      {"recipeId": 25, "ingredId": 145, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 25, "ingredId": 157, "amount": 3.00},
      {"recipeId": 25, "ingredId": 87, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 25, "ingredId": 110, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 25, "ingredId": 1, "amount": 1.00},
      {"recipeId": 25, "ingredId": 189, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 25, "ingredId": 104, "unit": "l", "amount": 1.00},
      {"recipeId": 25, "ingredId": 35},
      {"recipeId": 25, "ingredId": 132},
      {"recipeId": 25, "ingredId": 52, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 26, "ingredId": 12, "amount": 8.00},
      {"recipeId": 26, "ingredId": 25, "amount": 0.50},
      {"recipeId": 26, "ingredId": 63, "amount": 0.50},
      {"recipeId": 26, "ingredId": 35, "unit": "cup", "amount": 1.00},
      {"recipeId": 26, "ingredId": 216, "unit": "cup", "amount": 1.00},
      {"recipeId": 26, "ingredId": 36, "unit": "cup", "amount": 1.00},
      {"recipeId": 26, "ingredId": 180, "amount": 1.00},
      {"recipeId": 26, "ingredId": 91, "unit": "cup", "amount": 0.50},
      {"recipeId": 26, "ingredId": 28, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 26, "ingredId": 52, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 26, "ingredId": 189, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 26, "ingredId": 184, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 26, "ingredId": 34, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 27, "ingredId": 139, "amount": 1.00},
      {"recipeId": 27, "ingredId": 2, "unit": "g", "amount": 550.00},
      {"recipeId": 27, "ingredId": 1, "amount": 0.50},
      {"recipeId": 27, "ingredId": 120, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 27, "ingredId": 33, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 27, "ingredId": 27, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 27, "ingredId": 56, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 27, "ingredId": 189, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 27, "ingredId": 110, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 27, "ingredId": 217, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 27, "ingredId": 37, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 27, "ingredId": 124, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 27, "ingredId": 218, "unit": "cup", "amount": 0.50},
      {"recipeId": 27, "ingredId": 25, "unit": "cup", "amount": 1.00},
      {"recipeId": 27, "ingredId": 35, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 27, "ingredId": 219, "unit": "cup", "amount": 0.50},
      {"recipeId": 27, "ingredId": 109, "unit": "cup", "amount": 0.50},
      {"recipeId": 27, "ingredId": 40},
      {"recipeId": 27, "ingredId": 137},
      {"recipeId": 27, "ingredId": 220},
      {"recipeId": 27, "ingredId": 221},
      {"recipeId": 28, "ingredId": 16, "amount": 1.00},
      {"recipeId": 28, "ingredId": 55, "unit": "cup", "amount": 1.00},
      {"recipeId": 28, "ingredId": 125, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 28, "ingredId": 43, "unit": "cup", "amount": 1.00},
      {"recipeId": 28, "ingredId": 222, "unit": "cup", "amount": 0.50},
      {"recipeId": 28, "ingredId": 87, "unit": "cup", "amount": 0.30},
      {"recipeId": 28, "ingredId": 37, "unit": "cup", "amount": 1.00},
      {"recipeId": 28, "ingredId": 184, "unit": "cup", "amount": 0.30},
      {"recipeId": 28, "ingredId": 157, "amount": 2.00},
      {"recipeId": 28, "ingredId": 210, "amount": 0.25},
      {"recipeId": 28, "ingredId": 122, "amount": 5.00},
      {"recipeId": 28, "ingredId": 185, "amount": 3.00},
      {"recipeId": 28, "ingredId": 47, "amount": 2.00},
      {"recipeId": 28, "ingredId": 27, "amount": 1.00},
      {"recipeId": 29, "ingredId": 2, "unit": "g", "amount": 300.00},
      {"recipeId": 29, "ingredId": 223, "amount": 1.00},
      {"recipeId": 29, "ingredId": 224, "amount": 1.00},
      {"recipeId": 29, "ingredId": 27, "amount": 0.50},
      {"recipeId": 29, "ingredId": 25},
      {"recipeId": 29, "ingredId": 134},
      {"recipeId": 29, "ingredId": 225},
      {"recipeId": 29, "ingredId": 145},
      {"recipeId": 29, "ingredId": 43, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 29, "ingredId": 28, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 30, "ingredId": 17},
      {"recipeId": 30, "ingredId": 45},
      {"recipeId": 30, "ingredId": 44},
      {"recipeId": 30, "ingredId": 56},
      {"recipeId": 30, "ingredId": 190},
      {"recipeId": 30, "ingredId": 133},
      {"recipeId": 30, "ingredId": 226},
      {"recipeId": 30, "ingredId": 27},
      {"recipeId": 30, "ingredId": 108, "unit": "tbsp", "amount": 5.00},
      {"recipeId": 30, "ingredId": 28, "unit": "tbsp", "amount": 5.00},
      {"recipeId": 30, "ingredId": 189, "unit": "tbsp", "amount": 1.50},
      {"recipeId": 31, "ingredId": 80, "unit": "g", "amount": 200.00},
      {"recipeId": 31, "ingredId": 27, "unit": "clove", "amount": 6.00},
      {"recipeId": 31, "ingredId": 191, "amount": 9.00},
      {"recipeId": 31, "ingredId": 92, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 31, "ingredId": 37, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 31, "ingredId": 189, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 31, "ingredId": 87, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 31, "ingredId": 38, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 31, "ingredId": 179, "unit": "g", "amount": 250.00},
      {"recipeId": 31, "ingredId": 30, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 31, "ingredId": 38, "unit": "ml", "amount": 750.00},
      {"recipeId": 31, "ingredId": 113, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 31, "ingredId": 30, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 31, "ingredId": 1, "amount": 2.00},
      {"recipeId": 32, "ingredId": 112, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 32, "ingredId": 27, "unit": "g", "amount": 40.00},
      {"recipeId": 32, "ingredId": 53, "unit": "g", "amount": 250.00},
      {"recipeId": 32, "ingredId": 52, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 32, "ingredId": 43, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 32, "ingredId": 189, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 32, "ingredId": 33, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 32, "ingredId": 208, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 33, "ingredId": 176, "unit": "g", "amount": 100.00},
      {"recipeId": 33, "ingredId": 53, "unit": "cup", "amount": 0.30},
      {"recipeId": 33, "ingredId": 80, "amount": 3.00},
      {"recipeId": 33, "ingredId": 1, "amount": 1.00},
      {"recipeId": 33, "ingredId": 27, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 33, "ingredId": 109, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 33, "ingredId": 31, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 33, "ingredId": 37, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 33, "ingredId": 43, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 33, "ingredId": 189, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 33, "ingredId": 33},
      {"recipeId": 33, "ingredId": 126, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 34, "ingredId": 228, "unit": "g", "amount": 200.00},
      {"recipeId": 34, "ingredId": 229, "unit": "g", "amount": 200.00},
      {"recipeId": 34, "ingredId": 142, "unit": "g", "amount": 70.00},
      {"recipeId": 34, "ingredId": 46, "unit": "cup", "amount": 2.00},
      {"recipeId": 34, "ingredId": 1, "amount": 2.00},
      {"recipeId": 34, "ingredId": 55, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 34, "ingredId": 28, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 34, "ingredId": 144, "amount": 3.00},
      {"recipeId": 34, "ingredId": 44, "amount": 10.00},
      {"recipeId": 34, "ingredId": 134, "amount": 1.00},
      {"recipeId": 35, "ingredId": 67},
      {"recipeId": 35, "ingredId": 231, "unit": "g", "amount": 300.00},
      {"recipeId": 35, "ingredId": 28, "unit": "tbsp", "amount": 3.00},
      {"recipeId": 35, "ingredId": 189, "unit": "tbsp", "amount": 3.00},
      {"recipeId": 35, "ingredId": 38, "unit": "cup", "amount": 0.50},
      {"recipeId": 35, "ingredId": 135},
      {"recipeId": 36, "ingredId": 2, "unit": "g", "amount": 250.00},
      {"recipeId": 36, "ingredId": 177, "amount": 9.00},
      {"recipeId": 36, "ingredId": 43, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 36, "ingredId": 37, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 36, "ingredId": 33},
      {"recipeId": 36, "ingredId": 27, "amount": 1.00},
      {"recipeId": 36, "ingredId": 34},
      {"recipeId": 36, "ingredId": 124},
      {"recipeId": 36, "ingredId": 189, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 37, "ingredId": 36, "unit": "g", "amount": 40.00},
      {"recipeId": 37, "ingredId": 53, "unit": "g", "amount": 50.00},
      {"recipeId": 37, "ingredId": 159, "amount": 5.00},
      {"recipeId": 37, "ingredId": 1, "amount": 1.00},
      {"recipeId": 37, "ingredId": 134, "amount": 3.00},
      {"recipeId": 37, "ingredId": 136, "amount": 5.00},
      {"recipeId": 37, "ingredId": 35, "amount": 2.00},
      {"recipeId": 37, "ingredId": 25, "amount": 4.00},
      {"recipeId": 37, "ingredId": 102, "unit": "tbsp", "amount": 3.00},
      {"recipeId": 37, "ingredId": 87, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 37, "ingredId": 191, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 37, "ingredId": 49, "unit": "clove", "amount": 1.00},
      {"recipeId": 37, "ingredId": 27, "unit": "clove", "amount": 3.00},
      {"recipeId": 37, "ingredId": 109, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 38, "ingredId": 166, "unit": "g", "amount": 200.00},
      {"recipeId": 38, "ingredId": 143, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 38, "ingredId": 151, "unit": "cup", "amount": 1.00},
      {"recipeId": 38, "ingredId": 69, "unit": "ml", "amount": 250.00},
      {"recipeId": 38, "ingredId": 28, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 38, "ingredId": 106, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 38, "ingredId": 44, "amount": 3.00},
      {"recipeId": 39, "ingredId": 1, "amount": 2.00},
      {"recipeId": 39, "ingredId": 38, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 39, "ingredId": 189, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 39, "ingredId": 30, "unit": "tbsp", "amount": 0.25},
      {"recipeId": 39, "ingredId": 34, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 40, "ingredId": 48, "unit": "g", "amount": 5.00},
      {"recipeId": 40, "ingredId": 180, "amount": 1.00},
      {"recipeId": 40, "ingredId": 233, "unit": "g", "amount": 300.00},
      {"recipeId": 40, "ingredId": 172, "unit": "g", "amount": 200.00},
      {"recipeId": 40, "ingredId": 189, "unit": "tbsp", "amount": 1.30},
      {"recipeId": 40, "ingredId": 123, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 40, "ingredId": 170, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 40, "ingredId": 155, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 40, "ingredId": 84, "unit": "tbsp", "amount": 6.00},
      {"recipeId": 40, "ingredId": 38, "unit": "cup", "amount": 1.50},
      {"recipeId": 40, "ingredId": 34, "unit": "tbsp", "amount": 3.00},
      {"recipeId": 41, "ingredId": 173, "unit": "g", "amount": 450.00},
      {"recipeId": 41, "ingredId": 3, "unit": "g", "amount": 250.00},
      {"recipeId": 41, "ingredId": 25, "amount": 1.00},
      {"recipeId": 41, "ingredId": 63, "amount": 0.50},
      {"recipeId": 41, "ingredId": 7, "amount": 8.00},
      {"recipeId": 41, "ingredId": 35, "amount": 5.00},
      {"recipeId": 41, "ingredId": 27, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 41, "ingredId": 109},
      {"recipeId": 41, "ingredId": 87, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 41, "ingredId": 52, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 41, "ingredId": 189, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 41, "ingredId": 33, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 41, "ingredId": 206, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 42, "ingredId": 234},
      {"recipeId": 42, "ingredId": 167, "unit": "g", "amount": 250.00},
      {"recipeId": 42, "ingredId": 121, "amount": 1.00},
      {"recipeId": 42, "ingredId": 1, "amount": 1.00},
      {"recipeId": 42, "ingredId": 235, "amount": 1.00},
      {"recipeId": 42, "ingredId": 63},
      {"recipeId": 42, "ingredId": 30, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 42, "ingredId": 33, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 42, "ingredId": 161},
      {"recipeId": 43, "ingredId": 85, "unit": "tbsp", "amount": 4.00},
      {"recipeId": 43, "ingredId": 68, "amount": 2.00},
      {"recipeId": 43, "ingredId": 110, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 43, "ingredId": 38, "unit": "tbsp", "amount": 3.00},
      {"recipeId": 44, "ingredId": 178, "unit": "g", "amount": 250.00},
      {"recipeId": 44, "ingredId": 27, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 44, "ingredId": 180, "amount": 1.00},
      {"recipeId": 44, "ingredId": 63, "amount": 0.25},
      {"recipeId": 44, "ingredId": 117, "amount": 3.00},
      {"recipeId": 44, "ingredId": 35, "amount": 3.00},
      {"recipeId": 44, "ingredId": 48, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 44, "ingredId": 120, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 44, "ingredId": 84, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 44, "ingredId": 110, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 44, "ingredId": 34, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 44, "ingredId": 189, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 44, "ingredId": 236, "unit": "g", "amount": 50.00},
      {"recipeId": 45, "ingredId": 188, "unit": "cup", "amount": 0.50},
      {"recipeId": 45, "ingredId": 96, "unit": "cup", "amount": 0.50},
      {"recipeId": 45, "ingredId": 25, "unit": "cup", "amount": 0.50},
      {"recipeId": 45, "ingredId": 74, "unit": "cup", "amount": 0.50},
      {"recipeId": 45, "ingredId": 75, "unit": "cup", "amount": 2.00},
      {"recipeId": 45, "ingredId": 89, "unit": "tbsp", "amount": 3.00},
      {"recipeId": 45, "ingredId": 43, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 45, "ingredId": 34, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 45, "ingredId": 1, "amount": 3.00},
      {"recipeId": 45, "ingredId": 30, "unit": "tbsp", "amount": 0.25},
      {"recipeId": 45, "ingredId": 98, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 45, "ingredId": 34, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 46, "ingredId": 19, "unit": "kg", "amount": 0.50},
      {"recipeId": 46, "ingredId": 28, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 46, "ingredId": 232, "unit": "tbsp", "amount": 3.00},
      {"recipeId": 46, "ingredId": 109},
      {"recipeId": 46, "ingredId": 43, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 47, "ingredId": 4, "unit": "g", "amount": 150.00},
      {"recipeId": 47, "ingredId": 157, "unit": "tbsp", "amount": 0.30},
      {"recipeId": 47, "ingredId": 27, "unit": "tbsp", "amount": 0.30},
      {"recipeId": 47, "ingredId": 33, "unit": "tbsp", "amount": 0.30},
      {"recipeId": 47, "ingredId": 227, "amount": 2.00},
      {"recipeId": 47, "ingredId": 89, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 48, "ingredId": 153, "amount": 1.00},
      {"recipeId": 48, "ingredId": 2, "unit": "g", "amount": 50.00},
      {"recipeId": 48, "ingredId": 1, "amount": 1.00},
      {"recipeId": 48, "ingredId": 27, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 48, "ingredId": 52, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 48, "ingredId": 217, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 48, "ingredId": 33},
      {"recipeId": 48, "ingredId": 196},
      {"recipeId": 48, "ingredId": 111, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 49, "ingredId": 149, "amount": 20.00},
      {"recipeId": 49, "ingredId": 2, "unit": "g", "amount": 300.00},
      {"recipeId": 49, "ingredId": 146, "amount": 5.00},
      {"recipeId": 49, "ingredId": 27, "amount": 1.00},
      {"recipeId": 49, "ingredId": 27, "amount": 1.00},
      {"recipeId": 49, "ingredId": 56, "amount": 2.00},
      {"recipeId": 49, "ingredId": 57, "unit": "tbsp", "amount": 0.50},
      {"recipeId": 49, "ingredId": 30, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 49, "ingredId": 29, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 49, "ingredId": 109, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 49, "ingredId": 35, "amount": 1.00},
      {"recipeId": 49, "ingredId": 40, "amount": 1.00},
      {"recipeId": 49, "ingredId": 38, "unit": "cup", "amount": 0.50},
      {"recipeId": 50, "ingredId": 113, "unit": "cup", "amount": 0.50},
      {"recipeId": 50, "ingredId": 189, "unit": "tbsp", "amount": 2.00},
      {"recipeId": 50, "ingredId": 30, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 50, "ingredId": 42, "unit": "cup", "amount": 2.00},
      {"recipeId": 50, "ingredId": 26, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 50, "ingredId": 76, "unit": "tbsp", "amount": 1.00},
      {"recipeId": 50, "ingredId": 17, "unit": "g", "amount": 300.00}
    ];
    try {
      ingred.forEachIndexed((index, element) {
        ReIngredModel reIngredModel = ReIngredModel(
          recipeId: element['recipeId'].toString(),
          ingredientId: element['ingredId'] as int,
        );
        if (element['amount'] != null) {
          reIngredModel.amount = element['amount'] as double;
        }
        if (element['unit'] != null) {
          reIngredModel.unit = element['unit'].toString();
        }
        insertDataToSQLite(reIngredModel);
      });
    } catch (e) {
      print('e insertReIngredDataData ==>> ${e.toString()}');
    }
  }

  Future<List<ReIngredModel>> readlDataFromSQLite() async {
    //Database database = await connectedDatabase();
    List<ReIngredModel> reIngredModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      ReIngredModel reIngredModel = ReIngredModel.fromJson(map);
      reIngredModels.add(reIngredModel);
    }
    return reIngredModels;
  }

  Future<List<ReIngredModel>> readDataFromSQLiteWhereRecipe(
      String recipeId) async {
    //Database database = await connectedDatabase();
    List<ReIngredModel> reIngredModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase,
        where: '$recipeIdColumn = ?', whereArgs: [recipeId]);
    for (var map in maps) {
      ReIngredModel reIngredModel = ReIngredModel.fromJson(map);
      reIngredModels.add(reIngredModel);
    }
    return reIngredModels;
  }

  Future<int> update(ReIngredModel reIngredModel) async {
    //Database database = await connectedDatabase();
    var results = HewaAPI().update(tableDatabase, reIngredModel.toJson(),
        where: '${recipeIdColumn} = ? AND ${ingredientIdColumn} = ?',
        whereArgs: [reIngredModel.recipeId, reIngredModel.ingredientId]);
    return results;
  }

  Future<Null> updateDataToSQLite(ReIngredModel reIngredModel) async {
    // Database database = await connectedDatabase();
    try {
      HewaAPI().update(tableDatabase, reIngredModel.toJson(),
          where: '${recipeIdColumn} = ? AND ${ingredientIdColumn} = ?',
          whereArgs: [reIngredModel.recipeId, reIngredModel.ingredientId]);
    } catch (e) {
      print('e updataData ==>> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhere(String recipeId, String kitchenware) async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase,
          where: '$recipeIdColumn = ? AND $ingredientIdColumn = ?',
          whereArgs: [recipeId, kitchenware]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhereUser(String uid) async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI().rawQuery(
          'DELETE FROM $tableDatabase WHERE $recipeIdColumn = ?',
          values: [uid]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
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

  Future<Null> deleteAlldata() async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase);
    } catch (e) {
      print('e delete All ==>> ${e.toString()}');
    }
  }
}
