import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/recipe_model.dart';

class RecipeHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'recipeTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String uidColumn = 'uid';
  final String nameMenuColumn = 'nameMenu';
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
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $uidColumn TEXT, $nameMenuColumn TEXT, $recipeNameColumn TEXT, $descriptionColumn TEXT, $timeHourColumn INTEGER, $timeMinuteColumn INTEGER, $methodColumn TEXT, $typeColumn TEXT, $caloriesColumn INTEGER, $proteinColumn INTEGER, $carbColumn INTEGER, $fatColumn INTEGER)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(RecipeModel recipeModel) async {
    print(join(await getDatabasesPath(), nameDatabase));
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, recipeModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<Null> updateDataToSQLite(RecipeModel recipeModel) async {
    Database database = await connectedDatabase();
    try {
      database.update(tableDatabase, recipeModel.toJson(),
          where: '${uidColumn} = ? AND ${recipeNameColumn} = ?',
          whereArgs: [recipeModel.uid, recipeModel.recipeName]);
    } catch (e) {
      print('e updateData ==>> ${e.toString()}');
    }
  }

  Future<List<RecipeModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<RecipeModel> recipeModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      RecipeModel recipeModel = RecipeModel.fromJson(map);
      recipeModels.add(recipeModel);
    }
    return recipeModels;
  }

  Future<List<RecipeModel>> getAllUserRecipe(String id) async {
    Database database = await connectedDatabase();
    List<RecipeModel> recipeModels = [];
    List<Map<String, dynamic>> maps = await database
        .query(tableDatabase, where: '$uidColumn = ?', whereArgs: [id]);
    for (var map in maps) {
      RecipeModel recipeModel = RecipeModel.fromJson(map);
      recipeModels.add(recipeModel);
    }
    return recipeModels;
  }

  Future<List<RecipeModel>> getUserRecipe(String id, String recipeName) async {
    Database database = await connectedDatabase();
    List<RecipeModel> recipeModels = [];
    List<Map<String, dynamic>> maps = await database.query(tableDatabase,
        where: '$uidColumn = ? AND $recipeNameColumn = ?',
        whereArgs: [id, recipeName]);
    for (var map in maps) {
      RecipeModel recipeModel = RecipeModel.fromJson(map);
      recipeModels.add(recipeModel);
    }
    return recipeModels;
  }

  Future<Null> deleteDataWhereId(String id) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase, where: '$uidColumn = $id');
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
