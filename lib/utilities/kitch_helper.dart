import 'package:hewa/models/kitch_model.dart';
import 'package:hewa/utilities/query.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/ingred_model.dart';

class KitchHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'kitchenwareTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String nameColumn = 'nameKitc';

  KitchHelper() {
    // initDatabase();
  }

  // Future<Null> initDatabase() async {
  //   await openDatabase(join(await getDatabasesPath(), nameDatabase),
  //       onCreate: (db, version) => db.execute(
  //           'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT)'),
  //       version: version);
  // }

  // Future<Database> connectedDatabase() async {
  //   return openDatabase(join(await getDatabasesPath(), nameDatabase));
  // }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(KitchenwareModel kitchenwareModel) async {
    //Database database = await connectedDatabase();
    try {
      HewaAPI().insert(tableDatabase, kitchenwareModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<KitchenwareModel>> readlDataFromSQLite() async {
    //Database database = await connectedDatabase();
    List<KitchenwareModel> kitchenwareModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      KitchenwareModel kitchenwareModel = KitchenwareModel.fromJson(map);
      kitchenwareModels.add(kitchenwareModel);
    }
    return kitchenwareModels;
  }

  Future<Null> initialInsert() async {
    // Database database = await connectedDatabase();
    List<String> kitchenwares = [
      'Rice cooker',
      'Pan',
      'Pot',
      'Air fryer',
      'Microwave',
      'Food processor',
      'Cutting board',
      'Knife',
      'Induction cooker',
      'Oven',
      'Spatula',
      'Mortar',
      'Whisker',
      'Pressure cooker',
      'Grinder',
      'Sifter',
      'Electric kettle',
      'Kettle',
      'Steamer',
      'Toaster',
      'Halogen oven',
      'Pastry blender',
      'Thermoemeter',
      'Cheese gater',
      'Stove',
      'Ladle',
      'Bowl',
      'Cooking Grill',
      'Pestle',
      'Masher',
      'Plate',
      'Plastic wrap',
      'Deep-fried pot',
      'Fork',
      'Cup',
      'Spoon',
      'Ladle',
      'Chopsticks',
      'Meat Tenderizer',
      'Spatula',
      'Tong'
    ];
    for (var kitchenware in kitchenwares) {
      // database.execute(
      //     'INSERT INTO $tableDatabase($nameColumn) VALUES (\'$kitchenware\')');
    }
  }

  Future<Null> deleteDataWhereId(int id) async {
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
