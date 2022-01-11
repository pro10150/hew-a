import 'package:hewa/models/kitch_model.dart';
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
  Future<Null> insertDataToSQLite(KitchenwareModel kitchenwareModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, kitchenwareModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<KitchenwareModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<KitchenwareModel> kitchenwareModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      KitchenwareModel kitchenwareModel = KitchenwareModel.fromJson(map);
      kitchenwareModels.add(kitchenwareModel);
    }
    return kitchenwareModels;
  }

  Future<Null> initialInsert() async {
    Database database = await connectedDatabase();
    database
        .execute('INSERT INTO $tableDatabase($nameColumn) VALUES (\'Pan\')');
    database.execute(
        'INSERT INTO $tableDatabase($nameColumn) VALUES (\'Microwave\')');
    database
        .execute('INSERT INTO $tableDatabase($nameColumn) VALUES (\'Over\')');
    database
        .execute('INSERT INTO $tableDatabase($nameColumn) VALUES (\'Pot\')');
    database
        .execute('INSERT INTO $tableDatabase($nameColumn) VALUES (\'Fryer\')');
    database.execute(
        'INSERT INTO $tableDatabase($nameColumn) VALUES (\'Cheese grater\')');
  }

  Future<Null> deleteDataWhereId(int id) async {
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
