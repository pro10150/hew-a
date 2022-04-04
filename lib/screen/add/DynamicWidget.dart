import 'dart:async';
import 'dart:io';
import 'dart:core';
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hewa/models/step_model.dart';
import 'package:hewa/utilities/recipe_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hewa/utilities/reImageStep_helper.dart';
import 'package:hewa/models/reImageStep_model.dart';


import '../../models/Recipe_model.dart';
import '../../models/reStep_model.dart';
import '../../utilities/reStep_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as p;



class DynamicWidget extends StatefulWidget {
  method() => createState().addReStep();
  int count;
  RecipeModel recipeModel;

  DynamicWidget(this.count, this.recipeModel);

  @override
  _DynamicWidgetState createState() => _DynamicWidgetState(count, recipeModel);

}

class _DynamicWidgetState extends State<DynamicWidget> {

  _DynamicWidgetState(this.count, this.recipeModel);


  functionTest() {
    print('success');
  }


  final _formKey = new GlobalKey<FormState>();


  final descStepController = TextEditingController();
  final timeStepController = TextEditingController();


  ReImageStepHelper? reImageStepHelper;
  ReImageStepModel? reImageStepModel;

  StepModel? stepModel;

  ReStepModel? reStepModel;
  ReStepHelper? reStepHelper;

  RecipeModel? recipeModel;
  RecipeHelper? recipeHelper;


  File? _image;

  final picker = ImagePicker();


  int count;

  Future getImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        print(pickedFile);
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  List<Widget> getPickerItems(List<String> list) {
    List<Widget> items = [];
    for (var i in list) {
      items.add(Text(i));
    }
    return items;
  }



  addReStep() async {

    var object = await RecipeHelper().readDataFromSQLiteRecipe(recipeModel!);
    print(object.first.id);

    String descStep = descStepController.value.text;
    int? timeStep = int.tryParse(timeStepController.value.text);

      ReStepModel reStepModel = ReStepModel(
          recipeId: object.first.id.toString(),
          step: count,
          description: descStep,
          minute: timeStep);

      int result;
      result = await ReStepHelper().insert(reStepModel);


      if (result != 0) {
        print(descStep);
        print(timeStep);
        print('Success');
      } else {
        print('Failed');
      }

  }



  Future<Null> readSQLiteRecipe() async {
    var object = await RecipeHelper().readDataFromSQLiteRecipe(recipeModel!);
    print('object length ==> ${object.length}');
    setState(() {
      recipeModel = object.first;
      print(object.first.id);
    });
  }

  Future<Null> readSQLiteReStep() async {
    var object = await ReStepHelper().readDataFromSQLiteRestep(reStepModel!);
    print('object length ==> ${object.length}');
    setState(() {
      reStepModel = object.first;
    });
  }

  List<ReStepModel> step = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSQLiteReStep();
    readSQLiteRecipe();
  }

  // Future uploadImageToFirebase(BuildContext context) async {
  //   String fileName = p.basename(_image!.path);
  //   firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('steps')
  //       .child('/$fileName');
  //
  //   final metadata = firebase_storage.SettableMetadata(
  //       contentType: 'image/jpeg',
  //       customMetadata: {'picked-file-path': fileName});
  //   firebase_storage.UploadTask uploadTask;
  //   uploadTask = ref.putFile(io.File(_image!.path), metadata);
  //   var objects = await ReImageStepHelper().readlDataFromSQLite(step[0]);
  //   ReStepModel targetstep = objects.first;
  //   print(step[0]);
  //   targetstep.menuImage = fileName;
  //   print(menu[0].menuImage);
  //   MenuHelper().updateDataToSQLite(targetMenu);
  //
  //   firebase_storage.UploadTask task = await Future.value(uploadTask);
  //   Future.value(uploadTask)
  //       .then((value) => {print("Upload file path ${value.ref.fullPath}")})
  //       .onError((error, stackTrace) =>
  //   {print("Upload file path error ${error.toString()} ")});
  //
  //   print(fileName);
  // }


  // buildTimer(BuildContext context) {
  //   return TextButton(
  //       onPressed: () {
  //         showCupertinoModalPopup(
  //             context: context,
  //             builder: (context) {
  //               return Column(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: <Widget>[
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       color: Color(0xffffffff),
  //                       border: Border(
  //                         bottom: BorderSide(
  //                           color: Color(0xff999999),
  //                           width: 0.0,
  //                         ),
  //                       ),
  //                     ),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: <Widget>[
  //                         CupertinoButton(
  //                             child: Text('Cancel'),
  //                             onPressed: () {
  //                               Navigator.pop(context);
  //                             }),
  //                         CupertinoButton(
  //                           child: Text('Add'),
  //                           onPressed: () {
  //                             setState(() {
  //                               minute = _selectedMinute;
  //                               print(minute);
  //                             });
  //                             Navigator.pop(context);
  //                           },
  //                           padding: const EdgeInsets.symmetric(
  //                             horizontal: 16.0,
  //                             vertical: 5.0,
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     height: 320,
  //                     color: Colors.white,
  //                     child: Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Expanded(
  //                           child: CupertinoPicker(
  //                             itemExtent: 32,
  //                             backgroundColor: Colors.white,
  //                             onSelectedItemChanged: (value) {
  //                               setState(() {
  //                                 _selectedMinute = value;
  //                               });
  //                             },
  //                             children:
  //                             new List<Widget>.generate(500, (int index) {
  //                               var amount;
  //                               if (index > 0) {
  //                                 amount = index;
  //                               } else {
  //                                 amount = '-';
  //                               }
  //                               return new Center(
  //                                 child: new Text('${amount}'),
  //                               );
  //                             }),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               );
  //             });
  //       },
  //       child: minute != 0 ? Text('${minute}') : Text('-'));
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Step $count',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
          SizedBox(height: 10),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          SizedBox(height: 20),
          TextField(
              key: _formKey,
              controller: descStepController,
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  hintText: 'Description',
                  fillColor: Colors.white)),
          SizedBox(height: 40),
          InkWell(
            onTap: () {
              getImage();
            },
            child: _image != null
                ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 120,
                  height: 120,
                  color: Colors.white,
                  child: Image.file(_image!),
                ))
                : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 120,
                  height: 120,
                  color: Colors.white,
                  child: Icon(Icons.add),
                )),
          ),
          SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Time',
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(width: 20),
              Container(
                width: 100,
                child: TextField(
                  controller: timeStepController,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '-',
                  ),
                ),
              ),
              SizedBox(width: 20),
              Text('Minute',
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),

          SizedBox(height: 60),
          // Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Text('Timer',
          //           style:
          //               TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          //       buildTimer(context),
          //       Text('minute',
          //           style:
          //               TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          //       SizedBox(height: 150),
          //     ]),
        ],
      ),
    );
  }
}