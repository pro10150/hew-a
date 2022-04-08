import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hewa/config/palette.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/models/reportImage_model.dart';
import 'package:hewa/models/report_model.dart';
import 'package:hewa/utilities/reportImage_helper.dart';
import 'package:hewa/utilities/report_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:intl/intl.dart';

import '../launcher.dart';

class ReportRecipe extends StatefulWidget {
  ReportRecipe(this.menuRecipeModel);
  MenuRecipeModel menuRecipeModel;
  @override
  _ReportRecipeState createState() => _ReportRecipeState(menuRecipeModel);
}

class _ReportRecipeState extends State<ReportRecipe> {
  _ReportRecipeState(this.menuRecipeModel);
  MenuRecipeModel menuRecipeModel;
  var _auth = FirebaseAuth.instance;
  final textController = TextEditingController();
  int? _selectedAbout;
  List<String> titles = [
    "คัดลอกสูตรอาหารคนอื่น",
    "ใช้คำไม่สุภาพ",
    "คอนเทนต์ไม่เหมาะสม",
    "อื่นๆ"
  ];

  List<IconData> icons = [
    Icons.copy,
    Icons.mood_bad,
    Icons.thumb_down,
    Icons.more_horiz
  ];

  List<MaterialColor> colors = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];

  List<File> _image = [];
  List<String> imagePath = [""];
  int type = 2;
  final picker = ImagePicker();

  Future getImage(int index) async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        print(pickedFile);
        _image.add(File(pickedFile.path));
        imagePath[index] = basename(pickedFile.path);
        imagePath.add("");
      } else {
        print('No image selected.');
      }
    });
  }

  aboutButton(String title, IconData iconData, MaterialColor color, int index) {
    return Column(children: [
      MaterialButton(
        onPressed: () {
          setState(() {
            if (color == Colors.grey) {
              for (var i = 0; i < colors.length; i++) {
                colors[i] = Colors.grey;
              }
              colors[index] = Palette.roseBud;
              _selectedAbout = index;
            } else {
              colors[index] = Colors.grey;
              _selectedAbout = null;
            }
          });
        },
        color: color,
        textColor: Colors.white,
        child: Icon(
          iconData,
          size: 30,
        ),
        padding: EdgeInsets.all(20),
        shape: CircleBorder(),
      ),
      Text(title)
    ]);
  }

  Future uploadImageToFirebase(
      BuildContext context, String imagePath, File image) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('reports')
        .child('/$imagePath');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': imagePath});
    firebase_storage.UploadTask uploadTask;
    //late StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    uploadTask = ref.putFile(io.File(image.path), metadata);

    firebase_storage.UploadTask task = await Future.value(uploadTask);
    Future.value(uploadTask)
        .then((value) => {print("Upload file path ${value.ref.fullPath}")})
        .onError((error, stackTrace) =>
            {print("Upload file path error ${error.toString()} ")});
  }

  uploadReport(BuildContext context) async {
    if (_selectedAbout != null) {
      ReportModel? reportModel;
      var _nowDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      if (_selectedAbout != null) {
        if (textController.text != "") {
          reportModel = ReportModel(
              uid: _auth.currentUser!.uid,
              type: type,
              date: _nowDate,
              about: _selectedAbout! + 1,
              reportedUid: menuRecipeModel.uid,
              text: textController.text);
        } else {
          reportModel = ReportModel(
            uid: _auth.currentUser!.uid,
            type: type,
            date: _nowDate,
            about: _selectedAbout! + 1,
            reportedUid: menuRecipeModel.uid,
          );
        }
      }
      ReportHelper().insertDataToSQLite(reportModel!);
      Future.delayed(Duration(milliseconds: 500), () async {
        var object = await ReportHelper()
            .readDataFromSQLiteWhereDateReportedUid(
                _auth.currentUser!.uid, _nowDate);
        for (var i = 0; i < imagePath.length - 1; i++) {
          ReportImageModel reportImageModel =
              ReportImageModel(reportId: object.id, imagePath: imagePath[i]);
          ReportImageHelper().insertDataToSQLite(reportImageModel);
          uploadImageToFirebase(context, imagePath[i], _image[i]);
        }
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You didn't select any report categories")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
          title: menuRecipeModel.recipeName != null
              ? Text(menuRecipeModel.recipeName!)
              : Text(menuRecipeModel.nameMenu!),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                width: double.infinity,
                child: Text(
                  "Report About:",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 20),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300.0,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return aboutButton(
                      titles[index], icons[index], colors[index], index);
                }),
            Container(
              margin: EdgeInsets.all(12),
              height: 5 * 24.0,
              child: TextField(
                controller: textController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Detail",
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('รูปภาพเพิ่มเติม'),
              ),
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 20),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300.0,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                itemCount: _image.length + 1,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      getImage(index);
                    },
                    child: imagePath[index] != ""
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              margin: EdgeInsets.all(30),
                              width: 120,
                              height: 120,
                              color: Colors.white,
                              child: Image.file(
                                _image[index],
                                fit: BoxFit.cover,
                              ),
                            ))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              margin: EdgeInsets.all(30),
                              width: 120,
                              height: 120,
                              color: Colors.white,
                              child: Icon(Icons.add),
                            )),
                  );
                }),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                  margin: EdgeInsets.only(right: 20, bottom: 20),
                  child: TextButton(
                      onPressed: () {
                        uploadReport(context);
                      },
                      child: Text(
                        "Submit Report",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Palette.roseBud),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )))))
            ])
          ]),
        ));
  }
}
