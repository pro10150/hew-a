import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hewa/config/palette.dart';
import 'package:intl/intl.dart';
import 'package:hewa/screen/add/recipe_step_1.dart';
import 'package:hewa/screen/home.dart';
import 'package:hewa/screen/search.dart';
import 'package:hewa/utilities/user_helper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:page_transition/page_transition.dart';
import '../../utilities/reImageStep_helper.dart';
import '../../utilities/reIngred_helper.dart';
import '../../utilities/reStep_helper.dart';
import '../../utilities/recipe_helper.dart';
import 'detailed_recipe.dart';
import 'package:hewa/config/palette.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/utilities/reKitchenware_helper.dart';
import 'package:hewa/models/reKitchenware_model.dart';
import 'package:hewa/models/kitch_model.dart';
import 'package:hewa/utilities/kitch_helper.dart';
import 'package:hewa/models/reImage_model.dart';
import 'package:hewa/utilities/reImage_helper.dart';
import 'package:hewa/models/userKitch_model.dart';
import 'package:hewa/utilities/userKitch_helper.dart';
import 'package:hewa/models/view_model.dart';
import 'package:hewa/utilities/view_helper.dart';
import 'package:hewa/screen/add/Edit_recipe.dart';
import 'package:hewa/models/like_model.dart';
import 'package:hewa/utilities/like_helper.dart';

class MenuDetail extends StatefulWidget {
  MenuDetail(this.object) {
    menuRecipeModel = object;
  }
  MenuRecipeModel object;
  static const routeName = '/';
  @override
  _MenuDetailState createState() => _MenuDetailState(object);
}

var _auth = FirebaseAuth.instance;
UserModel? userModel;
List<String> urls = [];
List<KitchenwareModel> kitchenwareModels = [];
List<UserKitchenwareModel> userKitchenwareModels = [];
List<LikeModel> likeModels = [];
bool isLiked = false;

class _MenuDetailState extends State<MenuDetail> {
  _MenuDetailState(this.menuRecipeModel);
  MenuRecipeModel menuRecipeModel;
  Widget _getRecipePicture({required String pictureUrl}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image(
        image: NetworkImage(pictureUrl),
        fit: BoxFit.cover,
        height: 300,
        width: 300,
      ),
    );
  }

  getLike() async {
    setState(() {
      isLiked = false;
    });
    var objects = await LikeHelper()
        .readDataFromSQLiteWhereRecipe(menuRecipeModel.id.toString());

    setState(() {
      likeModels.clear();
      likeModels = objects;
      print(likeModels.length);
      for (var object in objects) {
        if (object.uid == _auth.currentUser!.uid) {
          setState(() {
            isLiked = true;
          });
        }
      }
    });
  }

  getUserKitchenware() async {
    var objects = await UserKitchHelper()
        .readDataFromSQLiteWhereUser(_auth.currentUser!.uid);
    setState(() {
      for (var object in objects) {
        print(object.kitchenware);
        userKitchenwareModels.add(object);
      }
    });
  }

  getImageURL() async {
    setState(() {
      urls = [];
    });
    getMenuUrl();
    var objects = await ReImageHelper()
        .readDataFromSQLiteWhereRecipe(menuRecipeModel.id!);
    for (var object in objects) {
      var ref =
          FirebaseStorage.instance.ref().child('recipes').child(object.name!);
      var url = await ref.getDownloadURL();
      setState(() {
        urls.add(url);
      });
    }
  }

  List<Widget> getImageWidget() {
    List<Widget> children = [];
    for (var url in urls) {
      children.add(_getRecipePicture(pictureUrl: url));
    }
    return children;
  }

  Widget _getKitchenware({required String kitchenware}) {
    bool isOwn = false;
    if (userModel!.kitchenwares == 1) {
      for (var userKitchenwareModel in userKitchenwareModels) {
        if (userKitchenwareModel.kitchenware == kitchenware)
          setState(() {
            isOwn = true;
          });
      }
    }

    return isOwn != true
        ? Chip(label: Text(kitchenware))
        : Chip(
            label: Text(
              kitchenware,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Palette.roseBud,
          );
  }

  getUserRecipe() async {
    var objects = await UserHelper()
        .readDataFromSQLiteWhereId(menuRecipeModel.recipeUid!);
    setState(() {
      userModel = objects.first;
    });
  }

  getMenuUrl() async {
    var ref = FirebaseStorage.instance
        .ref()
        .child('menus')
        .child(menuRecipeModel.menuImage!);
    var url = await ref.getDownloadURL();
    setState(() {
      urls.add(url);
    });
  }

  getReKitchenware() async {
    setState(() {
      kitchenwareModels = [];
    });
    var objects = await ReKitchenwareHelper()
        .readDataFromSQLiteWhereRecipe(menuRecipeModel.id.toString());
    var kitchenwares = await KitchHelper().readlDataFromSQLite();
    for (var object in objects) {
      for (var kitchenware in kitchenwares) {
        if (kitchenware.id == object.kitchenwareId) {
          setState(() {
            kitchenwareModels.add(kitchenware);
          });
        }
      }
    }
  }

  List<Widget> getKitchenwareWidget() {
    List<Widget> children = [SizedBox(width: 20)];
    List<Widget> kitchenwares = [];

    children.add(Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (var object in kitchenwareModels)
          _getKitchenware(kitchenware: object.nameKitc!)
      ],
    ));
    return children;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLike();
    getUserRecipe();
    getImageURL();
    getReKitchenware();
    getUserKitchenware();
  }

  static const color = const Color(0xffffab91);

  _doneFromDialog(context) {
    return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              FlatButton(
                  textColor: Colors.black,
                  color: color,
                  disabledColor: Colors.black,
                  onPressed: () async {
                    // await MenuHelper().deleteDataWhereId(menuRecipeModel.id.toString()).then((value) {
                    //   print('Delete Success Menu');
                    // });

                    await RecipeHelper()
                        .deleteDataWhereId(menuRecipeModel.id.toString())
                        .then((value) {
                      print('Delete Success Recipe');
                    });

                    await ReKitchenwareHelper()
                        .deleteDataWhereUser(menuRecipeModel.id.toString())
                        .then((value) {
                      print('Delete Success ReKit');
                    });

                    await ReStepHelper()
                        .deleteDataWhereRecipe(menuRecipeModel.id.toString())
                        .then((value) {
                      print('Delete Success ReStep');
                    });

                    await ReIngredHelper()
                        .deleteDataWhereUser(menuRecipeModel.id.toString())
                        .then((value) {
                      print('Delete Success ReIngre');
                    });

                    await ReImageStepHelper()
                        .deleteDataWhereRecipeimage(
                            menuRecipeModel.id.toString())
                        .then((value) {
                      print('Delete Success ReImStep');
                    });

                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('Done',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold))),
            ],
            title: Text(
              'Are you sure to delete ${menuRecipeModel.recipeName!}?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userModel!.username!),
        actions: [
          menuRecipeModel.recipeUid == _auth.currentUser!.uid
              ? PopupMenuButton(
                  onSelected: (result) {
                    if (result == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditRecipe(menuRecipeModel)),
                      );
                    }
                    if (result == 1) {
                      _doneFromDialog(context);
                    }
                  },
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("Edit"),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text("Delete"),
                          value: 1,
                        ),
                      ])
              : GestureDetector(
                  onTap: () {
                    LikeModel likeModel = LikeModel(
                        recipeId: menuRecipeModel.id,
                        uid: _auth.currentUser!.uid,
                        datetime: DateFormat('yyyy-MM-dd HH:mm:ss')
                            .format(DateTime.now()));
                    if (isLiked == false) {
                      LikeHelper().insertDataToSQLite(likeModel);
                      setState(() {
                        isLiked = true;
                        getLike();
                      });
                    } else {
                      LikeHelper().deleteDataWhere(_auth.currentUser!.uid,
                          menuRecipeModel.id.toString());
                      setState(() {
                        isLiked = false;
                        getLike();
                      });
                    }
                  },
                  child: Column(children: [
                    Icon(isLiked ? MdiIcons.heart : MdiIcons.heartOutline,
                        size: MediaQuery.of(context).size.height * 0.06),
                  ])),

          // IconButton(
          //   icon: const Icon(Icons.format_list_bulleted),
          //   tooltip: 'Show Snackbar',
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('This is a snackbar')));
          //   },
          // ),
        ],
      ),
      backgroundColor: Palette.roseBud,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(children: <Widget>[
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Wrap(
                    spacing: 30,
                    children: getImageWidget(),
                  ),
                )),
            Container(
              height: 10,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 40,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                            ),
                            Icon(MdiIcons.clockOutline),
                            Container(
                              width: 5,
                            ),
                            Text(
                                menuRecipeModel.timeMinute != null
                                    ? menuRecipeModel.timeMinute.toString() +
                                        " min"
                                    : 'N/A',
                                style: TextStyle(fontSize: 18)),
                            Container(
                              width: 20,
                            ),
                            Icon(MdiIcons.heartOutline),
                            Container(
                              width: 5,
                            ),
                            Text(likeModels.length.toString())
                          ],
                        ),
                        Container(height: 10),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                            ),
                            Text(
                              menuRecipeModel.nameMenu!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            )
                          ],
                        ),
                        menuRecipeModel.recipeName != null
                            ? Row(
                                children: <Widget>[
                                  Container(
                                    width: 20,
                                  ),
                                  Text(
                                    menuRecipeModel.recipeName!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                ],
                              )
                            : Container(),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                            ),
                            Flexible(
                              child: RichText(
                                overflow: TextOverflow.visible,
                                text: TextSpan(
                                  text: menuRecipeModel.description == null ||
                                          menuRecipeModel.description == ""
                                      ? 'This recipe doesn\'t have any description'
                                      : menuRecipeModel.description,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                strutStyle: StrutStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(height: 10),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                            ),
                            Text(
                              'Kitchenware',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            )
                          ],
                        ),
                        Wrap(
                          children: getKitchenwareWidget(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GFButton(
                              onPressed: () {
                                ViewModel viewModel = ViewModel(
                                    uid: _auth.currentUser!.uid,
                                    recipeId: menuRecipeModel.id!,
                                    isView: 1);
                                ViewHelper().insertDataToSQLite(viewModel);
                                showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    context: context,
                                    builder: (BuildContext conext) {
                                      return DetailedRecipe(menuRecipeModel);
                                    });
                              },
                              text: 'View Step',
                              textColor: Colors.black,
                              shape: GFButtonShape.pills,
                              type: GFButtonType.outline2x,
                              color: Colors.black,
                            ),
                            Container(
                              width: 20,
                            )
                          ],
                        )
                      ]),
                ))
          ]),
        ),
      ),
    );
  }
}
