import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/ingred_model.dart';

class IngredHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'ingredientTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String nameColumn = 'name';
  final String typeColumn = 'type';
  final String pictureColumn = 'picture';

  IngredHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(IngredModel ingredModel) async {
    print(join(await getDatabasesPath(), nameDatabase));
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, ingredModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<Null> initInsertToSQLite() async {
    print(join(await getDatabasesPath(), nameDatabase));
    Database database = await connectedDatabase();
    List<int> id = Iterable<int>.generate(68).toList();
    List<String> ingredient = [
      'Egg',
      'Minced pork',
      'Chicken',
      'Chicken breast',
      'Cos lettuce',
      'Onion',
      'Shiitake',
      'Sirloin',
      'Sliced beef',
      'Bacon',
      'Tofu',
      'Shrimp',
      'Spinach',
      'Tomato',
      'Pork ribs',
      'Duck',
      'Salmon',
      'Crispy pork',
      'Chicken wing',
      'Parmesan cheese',
      'Unsalted butter',
      'Snakehead',
      'Sweet pepper',
      'Salted butter',
      'Carrot',
      'Seaweed',
      'Garlic',
      'Fish sauce',
      'Sugar',
      'Salt',
      'Black soy sauce',
      'Chilli',
      'Pepper',
      'Vegetable oil',
      'Spring onion',
      'Vermicelli',
      'Oyster oil',
      'Clean water',
      'Potato',
      'Coraiander',
      'Rice',
      'Japanese rice',
      'White soy sauce',
      'Lime leaf',
      'Lemon grass',
      'Coconut cream',
      'Galangal',
      'Ginger',
      'Lime',
      'Squid',
      'Corn flour',
      'Oyster sauce',
      'Pork',
      'Roasted rice',
      'Palm sugar',
      'Shallot',
      'Shrimp paste',
      'Raw papaya',
      'Pickled fish',
      'Peanut',
      'Cayenne pepper',
      'Celery',
      'Cabbage',
      'Papaya',
      'Mushroom',
      'Tenderloin',
      'Fish',
      'Saba'
    ];

    for (var i in id) {
      Map<String, dynamic> row = {
        idColumn: id[i] + 1,
        nameColumn: ingredient[i]
      };
      database.insert(tableDatabase, row);
    }
  }

  Future<Null> updateDataToSQLite(IngredModel ingredModel) async {
    Database database = await connectedDatabase();
    try {
      database.update(tableDatabase, ingredModel.toJson(),
          where: '${idColumn} = ?', whereArgs: [ingredModel.id]);
    } catch (e) {
      print('e updateData ==>> ${e.toString()}');
    }
  }

  Future<List<IngredModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<IngredModel> ingredModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      IngredModel ingredModel = IngredModel.fromJson(map);
      ingredModels.add(ingredModel);
    }
    return ingredModels;
  }

  Future<List<IngredModel>> readDataFromSQLiteWhereId(String id) async {
    Database database = await connectedDatabase();
    List<IngredModel> ingredModels = [];
    List<Map<String, dynamic>> maps = await database
        .query(tableDatabase, where: '$idColumn = ?', whereArgs: [id]);
    for (var map in maps) {
      IngredModel ingredModel = IngredModel.fromJson(map);
      ingredModels.add(ingredModel);
    }
    return ingredModels;
  }

  Future<Null> deleteDataWhereId(String id) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase, where: '$idColumn = $id');
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
