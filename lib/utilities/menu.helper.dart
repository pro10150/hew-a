import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hewa/models/menu_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class MenuHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'menuTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String nameMenuColumn = 'nameMenu';
  final String mainIngredientColumn = 'mainIngredient';
  final String methodidColumn = 'methodid';
  final String userIDColumn = 'userID';
  final String imageColumn = 'menuImage';

  MenuHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $nameMenuColumn TEXT, $mainIngredientColumn TEXT, $userIDColumn TEXT, $imageColumn TEXt), $methodidColumn INTEGER'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(MenuModel menuModel) async {
    print(join(await getDatabasesPath(), nameDatabase));
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, menuModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<Null> initInsertToSQLite() async {
    Database database = await connectedDatabase();
    List<String> menus = [
      'ข้าวมันไก่',
      'ข้าวผัดหมู',
      'ผัดกะเพราหมูสับ',
      'แกงเขียวหวานไก่',
      'ต้มยำกุ้ง',
      'ไข่พะโล้',
      'กุ้งอบวุ้นเส้น',
      'พะแนงไก่',
      'ข้าวหน้าเป็ด',
      'ไข่เจียวหมูสับ',
      'ส้มตำ',
      'ไข่ดองน้ำปลา',
      'หมูหวาน',
      'ต้มข่าไก่',
      'ข้าวผัดกระเทียมเบคอนกรอบ',
      'ผักโขมอบชีส',
      'มันบด',
      'ซุปครีมเห็ด',
      'ซี่โครงหมูบาร์บีคิว',
      'ซีซาร์สลัด',
      'สปาเก็ตตี้คาโบนาร่า',
      'Beef wellington',
      'หมูทอดราดซอสเปรี้ยวหวาน',
      'ปอเปี๊ยะ',
      'เกี๊ยวน้ำ',
      'ผัดโป๊ยเซียน',
      'ขนมจีบหมู',
      'เป็ดพะโล้',
      'แกงจืดเต้าหู้หมูสับ',
      'ยำแซลมอน',
      'คะน้าหมูกรอบ',
      'หมูทอดกระเทียม',
      'ผัดซีอิ๊ว',
      'ห่อหมกปลาช่อน',
      'ฉู่ฉี่ปลาทอด',
      'หนำเลี๊ยบหมูสับ',
      'สุกี้แห้ง',
      'พะแนงหมู',
      'ไข่หวาน',
      'ข้าวหน้าเนื้อ',
      'ยากิโซบะ',
      'ทงคัตสึ',
      'ปลาซาบะย่างซอสเทอริยากิ',
      'เกี๊ยวซ่าหมู',
      'ข้าวห่อไข่',
      'ปีกไก่ทอดน้ำปลา',
      'แซนวิชอกไก่',
      'มาม่าผัด',
      'น้ำพริกอ่อง',
      'ข้าวหน้าแซลมอน'
    ];
    List<int> mainIngredient = [
      3,
      53,
      2,
      3,
      12,
      1,
      12,
      3,
      16,
      2,
      64,
      1,
      53,
      3,
      10,
      13,
      39,
      65,
      15,
      5,
      10,
      66,
      53,
      53,
      53,
      12,
      53,
      16,
      2,
      17,
      18,
      53,
      53,
      22,
      67,
      2,
      53,
      53,
      1,
      9,
      3,
      53,
      68,
      53,
      1,
      19,
      4,
      53,
      53,
      17
    ];
    menus.asMap().forEach((key, value) async {
      // final ref = FirebaseStorage.instance.ref().child('menu/'+value);
      // var url = ref.getDownloadURL();
      // var imagePath = '/lib/assets/รูปเมนู/' + value + '.jpeg';
      // File file = File(imagePath);
      // Uint8List bytes = file.readAsBytesSync();
      Map<String, dynamic> row = {
        nameMenuColumn: value,
        mainIngredientColumn: mainIngredient[key],
        imageColumn: value
      };
      database.insert(tableDatabase, row);
    });
  }

  Future<Null> updateDataToSQLite(MenuModel menuModel) async {
    Database database = await connectedDatabase();
    try {
      database.update(tableDatabase, menuModel.toJson(),
          where: '${idColumn} = ?', whereArgs: [menuModel.id]);
    } catch (e) {
      print('e updateData ==>> ${e.toString()}');
    }
  }

  Future<List<MenuModel>> readlDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<MenuModel> menuModels = [];

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      MenuModel menuModel = MenuModel.fromJson(map);
      menuModels.add(menuModel);
    }
    return menuModels;
  }

  Future<List<MenuModel>> readDataFromSQLiteWhereId(String id) async {
    Database database = await connectedDatabase();
    List<MenuModel> menuModels = [];
    List<Map<String, dynamic>> maps = await database
        .query(tableDatabase, where: '$idColumn = ?', whereArgs: [id]);
    for (var map in maps) {
      MenuModel menuModel = MenuModel.fromJson(map);
      menuModels.add(menuModel);
    }
    return menuModels;
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
