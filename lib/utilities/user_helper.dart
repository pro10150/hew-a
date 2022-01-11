import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/user_model.dart';

class UserHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'userTABLE';
  int version = 1;

  final String userIDColumn = 'userID';
  final String nameColumn = 'name';
  final String emailColumn = 'email';
  final String usernameColumn = 'username';
  final String passwordColumn = 'password';
  final String imageColumn = 'image';
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
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($userIDColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $usernameColumn TEXT, $passwordColumn TEXT, $imageColumn TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(UserModel userModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, userModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<UserModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<UserModel> userModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      UserModel userModel = UserModel.fromJson(map);
      userModels.add(userModel);
    }
    return userModels;
  }

  Future<Null> deleteDataWhereId(int id) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase, where: '$userIDColumn = $id');
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