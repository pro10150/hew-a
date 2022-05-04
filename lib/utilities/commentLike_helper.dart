import 'dart:io';

import 'package:hewa/utilities/query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/commentLike_model.dart';

class CommentLikeHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'commentLikeTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String commentIdColumn = 'commentId';
  final String uidColumn = 'uid';

  CommentLikeHelper() {
    // initDatabase();
  }

  // Future<Null> initDatabase() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   await openDatabase(join(appDocDir.path, nameDatabase),
  //       onCreate: (db, version) => db.execute(
  //           'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $uidColumn TEXT, $commentIdColumn TEXT)'),
  //       version: version);
  // }

  // Future<Database> connectedDatabase() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   return openDatabase(join(appDocDir.path, nameDatabase));
  // }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(CommentLikeModel commentLikeModel) async {
    // Database database = await connectedDatabase();
    try {
      HewaAPI().insert(tableDatabase, commentLikeModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<CommentLikeModel>> readlDataFromSQLite() async {
    // Database database = await connectedDatabase();
    List<CommentLikeModel> commentLikeModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      CommentLikeModel commentLikeModel = CommentLikeModel.fromJson(map);
      commentLikeModels.add(commentLikeModel);
    }
    return commentLikeModels;
  }

  Future<List<CommentLikeModel>> readDataFromSQLiteWhereUser(String uid) async {
    //Database database = await connectedDatabase();
    List<CommentLikeModel> commentLikeModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      CommentLikeModel commentLikeModel = CommentLikeModel.fromJson(map);
      commentLikeModels.add(commentLikeModel);
    }
    return commentLikeModels;
  }

  Future<Null> deleteDataWhere(String id) async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI()
          .delete(tableDatabase, where: '$idColumn = ?', whereArgs: [id]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhereComment(String commentId) async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase,
          where: '$commentIdColumn = ?', whereArgs: [commentId]);
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
