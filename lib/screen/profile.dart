import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hewa/models/reKitchenware_model.dart';
import 'package:hewa/models/reStep_model.dart';
import 'package:hewa/models/recipe_model.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/screen/add/new_menu.dart';
// import 'package:hewa/screen/add/recipe_step_1.dart';
import 'package:hewa/screen/add/Edit_recipe.dart';
import 'package:hewa/screen/profile/EditProfile.dart';
import 'package:hewa/utilities/commentLike_helper.dart';
import 'package:hewa/utilities/like_helper.dart';
import 'package:hewa/utilities/menu.helper.dart';
import 'package:hewa/utilities/reImageStep_helper.dart';
import 'package:hewa/utilities/reIngred_helper.dart';
import 'package:hewa/utilities/reKitchenware_helper.dart';
import 'package:hewa/utilities/reStep_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'login/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hewa/utilities/user_helper.dart';
import 'package:hewa/utilities/follow_helper.dart';
import 'package:hewa/utilities/recipe_helper.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/utilities/menuRecipe_helper.dart';
import 'package:hewa/models/menu_model.dart';
import 'menu_detail/menu_detail.dart';

class Profile extends StatefulWidget {
  static const routeName = '/';
  static const IconData logout = IconData(0xe3b3, fontFamily: 'MaterialIcons');

  const Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text('Profile Screen'),
//         ],
//       )),
//     );
//   }
// }

class UpperClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 60);

    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 60);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController controller;
  late var _scrollViewController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? _imageFile;

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        ModalRoute.withName('/'));
  }

  List<MenuRecipeModel> likeRecipes = [];
  List<MenuRecipeModel> menuRecipes = [];
  List<RecipeModel> userRecipes = [];
  List<UserModel> user = [];
  late var follower = 0;
  late var following = 0;
  late var recipe = 0;
  var userProfileRef;
  var userProfileUrl;
  MenuRecipeHelper? menuRecipeHelper;
  MenuModel? menuModel;

  Future<void> getUsername() async {
    UserHelper()
        .readDataFromSQLiteWhereId(_auth.currentUser!.uid)
        .then((value) {
      setState(() {
        user = value;
        if (user[0].image != null) {
          userProfileRef = FirebaseStorage.instance
              .ref()
              .child('upload')
              .child(user[0].image!);
          userProfileUrl = userProfileRef.getDownloadURL();
        }
      });
    });
  }

  Future<void> getFollow() async {
    var followerObject =
        await FollowHelper().getFollower(_auth.currentUser!.uid);
    var followingObject =
        await FollowHelper().getFollowing(_auth.currentUser!.uid);
    setState(() {
      follower = followerObject.length;
      following = followingObject.length;
    });
  }

  Future<void> getRecipe() async {
    setState(() {
      menuRecipes.clear();
      likeRecipes.clear();
    });
    var object = await RecipeHelper().getAllUserRecipe(_auth.currentUser!.uid);
    var mr = await MenuRecipeHelper().getAllUserRecipe(_auth.currentUser!.uid);
    var lr = await MenuRecipeHelper().getLikedRecipe(_auth.currentUser!.uid);
    setState(() {
      recipe = object.length;
      for (var obj in mr) {
        menuRecipes.add(obj);
      }
      for (var obj in lr) {
        likeRecipes.add(obj);
      }
    });
  }

  static const color = const Color(0xffffab91);

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    controller = TabController(length: 2, vsync: this);
    // signOut(context);
    getUsername();
    getFollow();
    getRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: NestedScrollView(
              //controller: _scrollViewController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: false,
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Column(
                        children: <Widget>[
                          ClipPath(
                            clipper: UpperClipper(),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1.0, vertical: 5.0),
                                  height: 370,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFEC7063),
                                        Color(0xFFFFAB91)
                                      ],
                                    ),
                                  ),
                                  child: Container(
                                    child: Center(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 40, bottom: 10),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Spacer(),
                                                Text(
                                                  user.isNotEmpty == true
                                                      ? user[0].name != null
                                                          ? '${user[0].name}'
                                                          : '${user[0].username}'
                                                      : 'name',
                                                  style: TextStyle(
                                                      fontSize: 24.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                    child: TextButton(
                                                  onPressed: () {
                                                    signOut(context);
                                                  },
                                                  child: Icon(Icons.logout,
                                                      color: Colors.black),
                                                )),
                                                // child: Text(
                                                //   'Log out',
                                                //   style: TextStyle(
                                                //       fontWeight:
                                                //           FontWeight
                                                //               .bold,
                                                //       fontSize: 18,
                                                //       color:
                                                //           Colors.white),
                                                // )))
                                              ]),
                                        ),
                                        CircleAvatar(
                                          radius: 60,
                                          backgroundColor: Colors.grey,
                                          child: ClipOval(
                                            child: SizedBox(
                                                height: 500,
                                                width: 500,
                                                child: user.isNotEmpty == true
                                                    ? (user[0].image != null)
                                                        ? FutureBuilder<String>(
                                                            future:
                                                                userProfileUrl,
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot<
                                                                        String>
                                                                    snapshot) {
                                                              List<Widget>
                                                                  children = [];
                                                              if (snapshot
                                                                  .hasData) {
                                                                children =
                                                                    <Widget>[
                                                                  CircleAvatar(
                                                                      radius:
                                                                          60,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey,
                                                                      child: ClipOval(
                                                                          child: SizedBox(
                                                                              height: 500,
                                                                              width: 500,
                                                                              child: Image.network(snapshot.data!, fit: BoxFit.fill))))
                                                                ];
                                                              } else {
                                                                children =
                                                                    <Widget>[
                                                                  CircularProgressIndicator()
                                                                ];
                                                              }
                                                              return Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children:
                                                                      children);
                                                            })
                                                        : CircleAvatar(
                                                            radius: 60,
                                                            backgroundColor:
                                                                Colors.grey,
                                                            child: ClipOval(
                                                                child: SizedBox(
                                                                    height: 500,
                                                                    width: 500,
                                                                    child:
                                                                        Image
                                                                            .network(
                                                                      "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg",
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ))))
                                                    : CircleAvatar(
                                                        radius: 60,
                                                        backgroundColor:
                                                            Colors.grey,
                                                        child: ClipOval(
                                                            child: SizedBox(
                                                                height: 500,
                                                                width: 500,
                                                                child: Image
                                                                    .network(
                                                                  "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg",
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ))))),
                                          ),
                                        ),
                                        Text(
                                          user.isNotEmpty == true
                                              ? "@${user[0].username}"
                                              : 'username',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Card(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 5.0),
                                          clipBehavior: Clip.antiAlias,
                                          color: Colors.transparent,
                                          elevation: 0.0,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0, vertical: 5.0),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        '$following',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      // SizedBox(
                                                      //   height: 5.0,
                                                      // ),
                                                      Text(
                                                        "Following",
                                                        style: TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        "$follower",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      // SizedBox(
                                                      //   height: 5.0,
                                                      // ),
                                                      Text(
                                                        "Followers",
                                                        style: TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        "$recipe",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      // SizedBox(
                                                      //   height: 5.0,
                                                      // ),
                                                      Text(
                                                        "Recipes",
                                                        style: TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              color: Colors.black,
                                              textColor: Colors.white,
                                              padding: EdgeInsets.only(
                                                  bottom: 0,
                                                  top: 0,
                                                  right: 42,
                                                  left: 42),
                                              onPressed: () =>
                                                  {navigateToEditPage(context)},
                                              child: Text(
                                                "Edit Profile",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                      ],
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    expandedHeight: 400,
                    bottom: TabBar(
                      labelColor: Colors.redAccent,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          icon: Icon(Icons.menu_book),
                          text: "My recipe",
                        ),
                        Tab(
                          icon: Icon(Icons.favorite),
                          text: "Favorite",
                        ),
                      ],
                      controller: controller,
                    ),
                  )
                ];
              },
              body: TabBarView(
                controller: controller,
                children: [
                  menuRecipes.length > 0
                      ? GridView.builder(
                          // primary: false,
                          // shrinkWrap: true,
                          // physics: ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300.0,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 20.0,
                          ),
                          // const SliverGridDelegateWithFixedCrossAxisCount(
                          //     crossAxisCount: 2),
                          itemCount: menuRecipes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return recipes(menuRecipes[index]);
                          })
                      : Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05),
                          alignment: Alignment.topCenter,
                          child: Text(
                            'You haven\'t create any recipes yet',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                  likeRecipes.length > 0
                      ? GridView.builder(
                          // primary: false,
                          // shrinkWrap: true,
                          // physics: ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300.0,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 20.0,
                          ),
                          itemCount: likeRecipes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return recipeslike(likeRecipes[index]);
                          })
                      : Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05),
                          alignment: Alignment.topCenter,
                          child: Text(
                            'You haven\'t liked anything yet',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                ],
              )

              // Container(
              //   child: Center(
              //     child: Text('Display Tab 2',
              //         style: TextStyle(
              //             fontSize: 22,
              //             fontWeight: FontWeight.bold)),
              //   ),
              // ),
              )),
    );
  }

  void navigateToEditPage(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 500), () async {
      final reloadPage =
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return EditProfile();
      }));
      if (reloadPage) {
        getUsername();
      }
    });
  }

  var ref;
  var url;

  Future<Null> readSQLite() async {
    var object = await MenuRecipeHelper().readDataFromSQLite();
    print('object length ==> ${object.length}');
    for (var model in object) {
      print(model);
    }
  }

  _doneFromDialog(context, MenuRecipeModel menuRecipeModel) {
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

  Widget recipes(MenuRecipeModel menuRecipeModel) {
    ref = FirebaseStorage.instance
        .ref()
        .child('menus')
        .child(menuRecipeModel.menuImage!);
    url = ref.getDownloadURL();
    menuModel = MenuModel(
        nameMenu: menuRecipeModel.nameMenu,
        mainIngredient: menuRecipeModel.mainIngredient,
        id: menuRecipeModel.id);
    return FutureBuilder<String>(
        future: url,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              InkWell(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          backgroundColor: Colors.white.withOpacity(0.93),
                          title: Text(
                            menuRecipeModel.recipeName!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                          children: [
                            SizedBox(
                              height: 1,
                              child: Container(
                                color: Colors.black45,
                              ),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditRecipe(menuRecipeModel)))
                                    .then((value) => getRecipe());
                                readSQLite();
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Edit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Icon(Icons.edit),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1,
                              child: Container(
                                color: Colors.black12,
                              ),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                _doneFromDialog(context, menuRecipeModel);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.red),
                                  ),
                                  Icon(Icons.remove_circle_outline_rounded,
                                      color: Colors.red),
                                ],
                              ),
                            ),
                          ],
                          elevation: 1,
                          //backgroundColor: Colors.green,
                        );
                      },
                    ).then((value) => getRecipe());
                  },
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MenuDetail(menuRecipeModel);
                    })).then((value) => getRecipe());
                  },
                  child: Container(
                    padding: EdgeInsets.all(0),
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.height * 0.17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(snapshot.data!))),
                  )

                  // child: Column(
                  //   children: <Widget>[
                  //     Image.network(
                  //         "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")
                  //   ],
                  // ),
                  ),
              menuRecipeModel.recipeName != null
                  ? Text(
                      menuRecipeModel.recipeName!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  : Container(),
              Text(menuRecipeModel.nameMenu!),
            ];
          } else {
            children = <Widget>[CircularProgressIndicator()];
          }
          return Column(children: children);
        });
  }

  _doneFromDialogLike(context, MenuRecipeModel menuRecipeModel) {
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
                    await LikeHelper()
                        .deleteDataWhere(_auth.currentUser!.uid,
                            menuRecipeModel.id.toString())
                        .then((value) {
                      print('Delete Success Like');
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

  Widget recipeslike(MenuRecipeModel menuRecipeModel) {
    ref = FirebaseStorage.instance
        .ref()
        .child('menus')
        .child(menuRecipeModel.menuImage!);
    url = ref.getDownloadURL();
    menuModel = MenuModel(
        nameMenu: menuRecipeModel.nameMenu,
        mainIngredient: menuRecipeModel.mainIngredient,
        id: menuRecipeModel.id);
    return FutureBuilder<String>(
        future: url,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              InkWell(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          backgroundColor: Colors.white.withOpacity(0.93),
                          title: Text(
                            menuRecipeModel.recipeName!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                          children: [
                            SizedBox(
                              height: 1,
                              child: Container(
                                color: Colors.black45,
                              ),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                _doneFromDialogLike(context, menuRecipeModel);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.red),
                                  ),
                                  Icon(Icons.remove_circle_outline_rounded,
                                      color: Colors.red),
                                ],
                              ),
                            ),
                          ],
                          elevation: 1,
                          //backgroundColor: Colors.green,
                        );
                      },
                    ).then((value) => getRecipe());
                  },
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MenuDetail(menuRecipeModel);
                    })).then((value) => getRecipe());
                  },
                  child: Container(
                    padding: EdgeInsets.all(0),
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.height * 0.17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(snapshot.data!))),
                  )

                  // child: Column(
                  //   children: <Widget>[
                  //     Image.network(
                  //         "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")
                  //   ],
                  // ),
                  ),
              menuRecipeModel.recipeName != null
                  ? Text(
                      menuRecipeModel.recipeName!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  : Container(),
              Text(menuRecipeModel.nameMenu!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ];
          } else {
            children = <Widget>[CircularProgressIndicator()];
          }
          return Column(children: children);
        });
  }
}
