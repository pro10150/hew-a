import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:io' as io;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hewa/config/palette.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/models/menu_model.dart';
import 'package:hewa/utilities/menu.helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import '../../models/menuRecipe_model.dart';
import 'package:path/path.dart' as p;
import 'recipe_step_1.dart';
import 'package:hewa/utilities/ingred_helper.dart';
import 'package:hewa/models/ingred_model.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/utilities/menuRecipe_helper.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class NewMenu extends StatefulWidget {
  @override
  _NewMenuState createState() => _NewMenuState();
}

List<String> ingredients = [];
List<IngredModel> ingredModel = [];

class _NewMenuState extends State<NewMenu> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // TextEditingController menuController = TextEditingController();
  // TextEditingController descController = TextEditingController();

  // _NewMenuState(MenuModel? menuModel);

  // MenuRecipeHelper? menuRecipeHelper;
  // MenuRecipeModel? menuRecipeModel;
  // MenuHelper? menuHelper;
  // MenuModel? menuModel;
  // IngredModel? ingredModel;

  // menuController.text = menuRecipeModel?.nameMenu!;
  // descController.text = menuRecipeModel?.description;

  File? _image = null;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  // Future getImage() async {
  //   XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       print(pickedFile);
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  String _confirmedIngredient = 'Select Ingredient';
  String _selectedIngredient = '';
  List<MenuModel> menu = [];

  List<Widget> getPickerItems() {
    List<Widget> items = [];
    for (var ingredients in ingredients) {
      items.add(Text(ingredients));
    }
    return items;
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = p.basename(_image!.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('menus')
        .child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileName});
    firebase_storage.UploadTask uploadTask;
    uploadTask = ref.putFile(io.File(_image!.path), metadata);
    var objects = await MenuHelper().readDataFromSQLiteMenu(menu[0]);
    MenuModel targetMenu = objects.first;
    print(menu[0]);
    print(targetMenu.mainIngredient.runtimeType);
    targetMenu.menuImage = fileName;
    print(menu[0].menuImage);
    MenuHelper().updateDataToSQLite(targetMenu);

    firebase_storage.UploadTask task = await Future.value(uploadTask);
    Future.value(uploadTask)
        .then((value) => {print("Upload file path ${value.ref.fullPath}")})
        .onError((error, stackTrace) =>
            {print("Upload file path error ${error.toString()} ")});

    print(fileName);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RecipeStep1(menu[0])));
  }

  void _showPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              width: double.infinity,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 30,
                children: getPickerItems(),
                onSelectedItemChanged: (value) {
                  setState(() {
                    _selectedIngredient = ingredients[value];
                  });
                },
              ),
            ));
  }

  Future<Null> readSQLite() async {
    var object = await IngredHelper().readlDataFromSQLite();
    print('object length ==> ${object.length}');
    ingredients.clear();
    for (var model in object) {
      print(model);
      ingredModel.add(model);
      ingredients.add(model.name!);
    }
  }

  final _formKey = new GlobalKey<FormState>();

  final menuController = TextEditingController();
  final descController = TextEditingController();
  final mainIngreController = TextEditingController();

  createMenus() async {
    String namemenu = menuController.text;
    String descmenu = descController.text;

    MenuModel menuModel = MenuModel(
        nameMenu: namemenu,
        mainIngredient: ingredModel
            .where((element) => element.name == _selectedIngredient)
            .first
            .id,
        descMenu: descmenu);
    MenuHelper().insert(menuModel);
    setState(() {
      menu.add(menuModel);
    });
    uploadImageToFirebase(context);
  }

  Widget buildnextBtn() {
    return RaisedButton(
      // onPressed: () {},
      onPressed: () {
        createMenus();
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => RecipeStep1(menuModel)));
      },
      textColor: Colors.white,
      color: Colors.black,
      disabledColor: Colors.black,
      child: Text("NEXT"),
      // onPressed: () {},
      padding: EdgeInsets.all(10),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSQLite();
    // menuUserHelper = MenuUserHelper();
  }

  @override
  Widget build(BuildContext context) {
    print(_image);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 22),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[BackButton()],
              ),
              SingleChildScrollView(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  child: Container(
                    width: double.infinity,
                    color: Palette.roseBud,
                    child: Column(children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        'Create new menu',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            child: Container(
                              color: Color(0xffF4F6F6),
                              width: double.infinity,
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: 30, left: 25, right: 25, bottom: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Menu',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                      SizedBox(height: 10),
                                      TextField(
                                          key: _formKey,
                                          controller: menuController,
                                          maxLength: 25,
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              filled: true,
                                              hintText: 'Menu',
                                              fillColor: Colors.white)),
                                      SizedBox(height: 15),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('Description',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      SizedBox(height: 10),
                                      TextField(
                                          controller: descController,
                                          keyboardType: TextInputType.name,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              filled: true,
                                              hintText: 'Description',
                                              fillColor: Colors.white)),
                                      SizedBox(height: 15),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('Add Image',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Column(children: <Widget>[
                                        SizedBox(height: 10),
                                        Row(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                pickImage();
                                              },
                                              child: _image != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        width: 120,
                                                        height: 120,
                                                        color: Colors.white,
                                                        child:
                                                            Image.file(_image!),
                                                      ))
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        width: 120,
                                                        height: 120,
                                                        color: Colors.white,
                                                        child: Icon(Icons.add),
                                                      )),
                                            ),
                                            //     SizedBox(width: 10),
                                            //     ClipRRect(
                                            //         borderRadius:
                                            //             BorderRadius.circular(10),
                                            //         child: Container(
                                            //           width: 120,
                                            //           height: 120,
                                            //           color: Colors.blue,
                                            //         )),
                                            //   ],
                                            // ),
                                            // SizedBox(height: 20),
                                            // Row(
                                            //   children: <Widget>[
                                            //     ClipRRect(
                                            //         borderRadius:
                                            //             BorderRadius.circular(10),
                                            //         child: Container(
                                            //           width: 120,
                                            //           height: 120,
                                            //           color: Colors.blue,
                                            //         )),
                                            //     SizedBox(width: 10),
                                            //     ClipRRect(
                                            //         borderRadius:
                                            //             BorderRadius.circular(10),
                                            //         child: Container(
                                            //           width: 120,
                                            //           height: 120,
                                            //           color: Colors.blue,
                                            //         )),
                                          ],
                                        )
                                      ]),
                                      SizedBox(height: 15),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('Main ingredient',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      SizedBox(height: 10),
                                      CupertinoButton(
                                        child: Text(
                                          '$_confirmedIngredient',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _selectedIngredient =
                                                ingredients[0];
                                          });
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (context) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffffffff),
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            color: Color(
                                                                0xff999999),
                                                            width: 0.0,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          CupertinoButton(
                                                              child: Text(
                                                                  'Cancel',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                          CupertinoButton(
                                                            child: Text(
                                                                'confirm',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            onPressed: () {
                                                              setState(() {
                                                                _confirmedIngredient =
                                                                    _selectedIngredient;
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 16.0,
                                                              vertical: 5.0,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 320,
                                                      color: Colors.white,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Expanded(
                                                              child:
                                                                  CupertinoPicker(
                                                            itemExtent: 32,
                                                            backgroundColor:
                                                                Colors.white,
                                                            onSelectedItemChanged:
                                                                (value) {
                                                              setState(() {
                                                                _selectedIngredient =
                                                                    ingredients[
                                                                        value];
                                                                print(
                                                                    _selectedIngredient);
                                                              });
                                                            },
                                                            children:
                                                                getPickerItems(),
                                                          )),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                );
                                              });
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      // Align(
                                      //     alignment: Alignment.centerLeft,
                                      //     child: Text('ข้อมูลโภชนาการ')),
                                      // SizedBox(height: 10),
                                      // TextField(
                                      //     decoration: InputDecoration(
                                      //         border: OutlineInputBorder(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     20)),
                                      //         filled: true,
                                      //         hintText: 'แคลอรี',
                                      //         fillColor: Colors.white)),
                                      // SizedBox(height: 10),
                                      // TextField(
                                      //     decoration: InputDecoration(
                                      //         border: OutlineInputBorder(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     20)),
                                      //         filled: true,
                                      //         hintText: 'โปรตีน',
                                      //         fillColor: Colors.white)),
                                      // SizedBox(height: 10),
                                      // TextField(
                                      //     decoration: InputDecoration(
                                      //         border: OutlineInputBorder(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     20)),
                                      //         filled: true,
                                      //         hintText: 'คาร์โบไฮเดรต',
                                      //         fillColor: Colors.white)),
                                      // SizedBox(height: 10),
                                      // TextField(
                                      //     decoration: InputDecoration(
                                      //         border: OutlineInputBorder(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     20)),
                                      //         filled: true,
                                      //         hintText: 'ไขมัน',
                                      //         fillColor: Colors.white)),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            // TextButton(
                                            //     child: Row(
                                            //       children: <Widget>[
                                            //         Text('Next'),
                                            //         Icon(
                                            //             Icons.arrow_forward_ios)
                                            //       ],
                                            //     ),
                                            //     onPressed: () {
                                            //       Navigator.push(
                                            //           context,
                                            //           PageTransition(
                                            //               child: RecipeStep1(),
                                            //               type:
                                            //                   PageTransitionType
                                            //                       .rightToLeft));
                                            //     })
                                            buildnextBtn(),
                                          ])
                                    ],
                                  )),
                            ),
                          ))
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
