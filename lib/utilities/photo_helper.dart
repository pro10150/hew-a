import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hewa/models/photo_model.dart';

class PhotoHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'photoTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String photoNameColumn = 'photoName';

  PhotoHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $photoNameColumn TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<Photo> save(Photo photo) async {
    Database database = await connectedDatabase();
    photo.id = await database.insert(tableDatabase, photo.toJson());
    return photo;
  }

  Future<List<Photo>> getPhotos() async {
    Database database = await connectedDatabase();

    List<Map<String, dynamic>> maps = await database
        .query(tableDatabase, columns: [idColumn, photoNameColumn]);
    List<Photo> photos = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        photos.add(Photo.fromJson(maps[i]));
      }
    }

    return photos;
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
