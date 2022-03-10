import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/comment_model.dart';
import 'package:intl/intl.dart';

class CommentHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'commentTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String uidColumn = 'uid';
  final String recipeIdColumn = 'recipeId';
  final String textColumn = 'text';
  final String dateColumn = 'date';

  CommentHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $uidColumn TEXT, $recipeIdColumn INTEGER, $textColumn TEXT, $dateColumn INTEGER)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(CommentModel commentModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, commentModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<Null> initInsert() async {
    Database database = await connectedDatabase();
    var uid = "k2YFM1LkbVaEf4zV4HnhTAmIdRD3";
    var recipeId = "1";
    var comments = ["1", "2", "3", "4"];
    try {
      comments.forEach((element) {
        Map<String, dynamic> row = {
          uidColumn: uid,
          recipeIdColumn: recipeId,
          textColumn: element,
          dateColumn: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        };
        database.insert(tableDatabase, row);
      });
    } catch (e) {
      print('e insert like data ==>> ${e.toString()}');
    }
  }

  Future<List<CommentModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<CommentModel> commentModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      CommentModel commentModel = CommentModel.fromJson(map);
      commentModels.add(commentModel);
    }
    return commentModels;
  }

  Future<List<CommentModel>> readDataFromSQLiteWhereRecipe(
      String recipeId) async {
    Database database = await connectedDatabase();
    List<CommentModel> commentModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase,
        where: '$recipeIdColumn = ?', whereArgs: [recipeId]);
    for (var map in maps) {
      CommentModel commentModel = CommentModel.fromJson(map);
      commentModels.add(commentModel);
    }
    return commentModels;
  }

  Future<Null> deleteDataWhere(String uid, String recipeId) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase,
          where: '$uidColumn = ? AND $recipeIdColumn = ?',
          whereArgs: [uid, recipeId]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhereUser(String uid) async {
    Database database = await connectedDatabase();
    try {
      await database
          .delete(tableDatabase, where: '$uidColumn = ?', whereArgs: [uid]);
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
