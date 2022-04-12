import 'dart:typed_data';
import 'dart:io';

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
  final String imageColumn = 'image';

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
      'Salted butter',
      'Black soy sauce',
      'Chilli',
      'Pepper',
      'Vegetable oil',
      'Spring onion',
      'Vermicelli',
      'Oyster oil',
      'Clean water',
      'Potato',
      'Coriander',
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
      'Peanut ',
      'Cayenne pepper',
      'Celery',
      'Cabbage',
      'Papaya',
      'Mushroom',
      'Tenderloin',
      'Fish',
      'Saba ',
      'Coconut Milk',
      'River Shrimp',
      'Dried Shrimp',
      'Gravy',
      'Bread',
      'Sweetcorn',
      'Cooked Rice',
      'Shrimp Eggs',
      'Egg White',
      'Duck Egg',
      'Rule',
      'Kale',
      'Soysauce',
      'Cooking Cream',
      'Parmesan Cheese',
      'Shoyu',
      'Teriyaki Sauce',
      'BBQ Sauce',
      'Seasoning Sauce',
      'Chili Sauce',
      'Tomato Ketchup',
      'Red Wine Sauce',
      'Day Lily',
      'Bean Paste',
      'Cucumber',
      'Bean Sprout',
      'Long bean',
      'Peas',
      'Condensed Milk',
      'Fresh Milk',
      'Mild Fresh Milk',
      'Chicken Calf',
      'Ice',
      'Sooki Sauce',
      'Broth',
      'Pork Bone Soup',
      'Rock Sugar',
      'Coconut Sugar',
      'Chilli Jam',
      'Lemon Juice',
      'Oil',
      'Sesame Oil',
      'Olive Oil',
      'Rice Bran Oil',
      'Vinegar',
      'Butter',
      'Fresh Butter',
      'Basil',
      'Kui Yai Leaves',
      'Crispy Flour',
      'Pie Flour',
      'Tapioca Flour',
      'Wheat Flour',
      'Anise',
      'Dashi Powder',
      'Seasoning Powder',
      'Pork Stew Powder',
      'Baking Powder',
      'Coriander Seed Powder',
      'Cumin Seed Powder',
      'Garlic Powder',
      'Onion Powder',
      'Paprika Powder',
      'Cantonese Vegetables',
      'Lettuce',
      'White Cabbage',
      'Saw Leaf Coriandder',
      'Water Spinach',
      'Salad',
      'Bergamot Skin',
      'Dumpling sheet',
      'Roti sheet',
      'Green Curry Paste',
      'Red Curry',
      'Pepper',
      'Chili Pepper',
      'White Pepper',
      'Dried Chili',
      'Parsley',
      'Mossarella Cheese',
      'Cherry Tomatoes',
      'Thai Eggplant',
      'Eggplant',
      'Mustard',
      'Instant Noodle',
      'Mayonnaise',
      'Mirin',
      'Caraway',
      'Coriander Root',
      'Suture',
      'Fish Ball',
      'Coriander Seed',
      'Lemon',
      'Whipped Cream',
      'Worcester Sauce',
      'Chicken Hip',
      'Pig Hip',
      'Pork Neck',
      'Pork Sirloin',
      'Pork Tenderloin',
      'Pineapple',
      'Sake',
      'Food Coloring',
      'Chirati Line',
      'Yakisoba Pasta',
      'Spaghetti Pasta',
      'Hokkien Noodle',
      'Wide Rice Noodle',
      'Chinese Black Olive ',
      'Ground Pork',
      'Streaky Pork',
      'Onion',
      'Diluted Coconut Milk',
      'Straw Mushroom',
      'Champignon',
      'Chinese Liquor',
      'Cinnamon',
      'Origano',
      'Anchovy',
      'Ham',
      'Sugar',
      'Basil',
      'Pepper',
      'Others',
      'Chinda',
      'Parsley',
      'Sugar',
      'Sriracha Yellow Church Sauce',
      'White Eyebrance',
      'Pork Seasoning Powder',
      'Pork Stock',
      'Seafood Juice',
      'Sugar',
      'Chicken Soup Powder',
      'Wide Vegetables',
      'Pork',
      'Clean Water',
      'Black',
      'Precipitation',
      'Black Pepper',
      'Brown Sugar',
      'Black Pepper',
      'Parmesan Cheese Grated',
      'Milk',
      'Green Sweet Pepper',
      'Red Sweet Pepper',
      'Shrimp',
      'Black Mushroom',
      'White Soy Mushroom Shiitake',
      'Cold Water Or Ice',
      'Fried Garlic',
      'Dessert',
      'Jig Chow',
      'Sweet Soy Sauce',
      'Egg Tofu',
      'Knorr ',
      'Celery',
      'Hot Garden Chilli',
      'Whole Wheat Bread',
      'Snakehead Meat',
      'Scratched Fish',
      'Coconut Cream',
      'Red Curry',
      'Flour For Frying',
      'Beef',
      'Kikkoman Tasty Japan Tonkatsu Sauce',
      'Bread'
    ];

    ingredient.asMap().forEach((key, value) async {
      // var name = (key + 1).toString();
      // var imagePath =
      //     '/Users/skooter/Desktop/Class/ปี3/se/hew-a/lib/assets/fridge/รูปวัตถุดิบ/' +
      //         name +
      //         '.jpg';
      // File file = File(imagePath);
      // Uint8List bytes = file.readAsBytesSync();
      Map<String, dynamic> row = {
        nameColumn: value,
        imageColumn: (key + 1).toString()
      };
      database.insert(tableDatabase, row);
    });
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
