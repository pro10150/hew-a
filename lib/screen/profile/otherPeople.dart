import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hewa/screen/profile/EditProfile.dart';
import 'package:hewa/screen/menu_detail/menu_detail.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/models/follow_model.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/utilities/user_helper.dart';
import 'package:hewa/utilities/follow_helper.dart';
import 'package:hewa/utilities/menuRecipe_helper.dart';

class OtherProfile extends StatefulWidget {
  final String url;
  final String uid;
  static const routeName = '/';

  const OtherProfile(this.url, this.uid, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OtherProfileState(url, uid);
  }
}

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

class _OtherProfileState extends State<OtherProfile>
    with SingleTickerProviderStateMixin {
  _OtherProfileState(this.url, this.uid);
  String url;
  String uid;
  bool isFollowed = false;
  UserModel? user;
  var _auth = FirebaseAuth.instance;
  List<FollowModel> followings = [];
  List<FollowModel> followers = [];
  List<MenuRecipeModel> menuRecipeModels = [];
  late TabController controller;
  late var _scrollViewController;

  getUser() async {
    var objects = await UserHelper().readDataFromSQLiteWhereId(uid);
    setState(() {
      user = objects.first;
    });
  }

  getFollows() async {
    var objects = await FollowHelper().getFollower(uid);
    for (var object in objects) {
      setState(() {
        followers.add(object);
      });
      if (object.followedUserID == _auth.currentUser!.uid) {
        setState(() {
          isFollowed = true;
        });
      }
    }
    objects = await FollowHelper().getFollowing(uid);
    for (var object in objects) {
      setState(() {
        followings.add(object);
      });
    }
  }

  getRecipes() async {
    var objects = await MenuRecipeHelper().getAllUserRecipe(uid);
    for (var object in objects) {
      setState(() {
        menuRecipeModels.add(object);
      });
    }
  }

  follow() {
    FollowModel followModel =
        FollowModel(uid: uid, followedUserID: _auth.currentUser!.uid);
    if (isFollowed == false) {
      FollowHelper().insertDataToSQLite(followModel);
      setState(() {
        followers.add(followModel);
        isFollowed = true;
      });
    } else {
      FollowHelper().deleteDataWhereUidAndFollow(uid, _auth.currentUser!.uid);
      setState(() {
        followers.removeAt(followers.length - 1);
        isFollowed = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getFollows();
    getRecipes();
    _scrollViewController = ScrollController();
    controller = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: NestedScrollView(
              //controller: _scrollViewController,
              // physics: NeverScrollableScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
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
                                        Spacer(),
                                        user!.name != null
                                            ? Text(
                                                user!.name!,
                                                style: TextStyle(
                                                    fontSize: 24.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                user!.username!,
                                                style: TextStyle(
                                                    fontSize: 24.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            url,
                                          ),
                                          radius: 60.0,
                                        ),
                                        Text(" "),
                                        Text(
                                          "@" + user!.username!,
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
                                                        followings.length
                                                            .toString(),
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
                                                        followers.length
                                                            .toString(),
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
                                                        menuRecipeModels.length
                                                            .toString(),
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
                                            _auth.currentUser!.uid != uid
                                                ? isFollowed == false
                                                    ? RaisedButton(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        color: Colors.black,
                                                        textColor: Colors.white,
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 0,
                                                                top: 0,
                                                                right: 42,
                                                                left: 42),
                                                        onPressed: () {
                                                          follow();
                                                        },
                                                        child: Text(
                                                          "follow",
                                                          style: TextStyle(
                                                            fontSize: 18.0,
                                                          ),
                                                        ),
                                                      )
                                                    : RaisedButton(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        color: Colors.black,
                                                        textColor: Colors.white,
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 0,
                                                                top: 0,
                                                                right: 42,
                                                                left: 42),
                                                        onPressed: () {
                                                          follow();
                                                        },
                                                        child: Text(
                                                          "unfollow",
                                                          style: TextStyle(
                                                            fontSize: 18.0,
                                                          ),
                                                        ),
                                                      )
                                                : Container(),
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
                          text: "recipes",
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
                  menuRecipeModels.length > 0
                      ? GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300.0,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 20.0,
                          ),
                          itemCount: menuRecipeModels.length,
                          itemBuilder: (BuildContext context, int index) {
                            return recipes(menuRecipeModels[index]);
                          })
                      : Container(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'You haven\'t create any recipes yet',
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
}

class recipes extends StatelessWidget {
  recipes(this.menuRecipeModel) {
    ref = FirebaseStorage.instance
        .ref()
        .child('menus')
        .child(menuRecipeModel.menuImage!);
    url = ref.getDownloadURL();
  }
  MenuRecipeModel menuRecipeModel;
  var ref;
  var url;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: url,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MenuDetail(menuRecipeModel);
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.all(0),
                    width: 150,
                    height: 150,
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
              Text(menuRecipeModel.nameMenu!)
            ];
          } else {
            children = <Widget>[CircularProgressIndicator()];
          }
          return Column(children: children);
        });
  }
}

navigateToEditPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return EditProfile();
  }));
}
