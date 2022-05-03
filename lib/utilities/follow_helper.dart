import 'dart:typed_data';

import 'package:hewa/utilities/query.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/follow_model.dart';

class FollowHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'followTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String uidColumn = 'uid';
  final String followedUserIDColumn = 'followedUserID';
  FollowHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY $uidColumn TEXT, $followedUserIDColumn TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(FollowModel followModel) async {
    print(join(await getDatabasesPath(), nameDatabase));
    //Database database = await connectedDatabase();
    try {
      HewaAPI().insert(tableDatabase, followModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<Null> updateDataToSQLite(FollowModel followModel) async {
    // Database database = await connectedDatabase();
    try {
      HewaAPI().update(tableDatabase, followModel.toJson(),
          where: '${uidColumn} = ?', whereArgs: [followModel.uid]);
    } catch (e) {
      print('e updateData ==>> ${e.toString()}');
    }
  }

  Future<List<FollowModel>> readlDataFromSQLite() async {
    //Database database = await connectedDatabase();
    List<FollowModel> followModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      FollowModel followModel = FollowModel.fromJson(map);
      followModels.add(followModel);
    }
    return followModels;
  }

  Future<List<FollowModel>> getFollower(String id) async {
    //Database database = await connectedDatabase();
    List<FollowModel> followModels = [];
    List<dynamic> maps = await HewaAPI()
        .query(tableDatabase, where: '$uidColumn = ?', whereArgs: [id]);
    for (var map in maps) {
      FollowModel followModel = FollowModel.fromJson(map);
      followModels.add(followModel);
    }
    return followModels;
  }

  Future<List<FollowModel>> getFollowing(String id) async {
    //Database database = await connectedDatabase();
    List<FollowModel> followModels = [];
    List<dynamic> maps = await HewaAPI().query(tableDatabase,
        where: '$followedUserIDColumn = ?', whereArgs: [id]);
    for (var map in maps) {
      FollowModel followModel = FollowModel.fromJson(map);
      followModels.add(followModel);
    }
    return followModels;
  }

  Future<Null> deleteDataWhereId(String id) async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase, where: '$uidColumn = $id');
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhereUidAndFollow(
      String uid, String followedUid) async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase,
          where: '$uidColumn = ? AND $followedUserIDColumn = ?',
          whereArgs: [uid, followedUid]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteAlldata() async {
    // Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase);
    } catch (e) {
      print('e delete All ==>> ${e.toString()}');
    }
  }
}
