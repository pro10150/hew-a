import 'dart:convert';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hewa/models/menu_model.dart';
import 'package:hewa/utilities/menu.helper.dart';
import 'dart:core';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hewa/utilities/user_helper.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/utilities/method_helper.dart';
import 'package:hewa/models/method_model.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/utilities/menuRecipe_helper.dart';
import 'package:hewa/models/follow_model.dart';
import 'package:hewa/utilities/follow_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hewa/config/palette.dart';
import 'menu_detail/menu_detail.dart';
import 'profile/otherPeople.dart';

class Search extends StatefulWidget {
  static const routeName = '/';

  const Search({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<Search> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController teSeach = TextEditingController();
  var allUser = [];
  var items = [];

  bool _isChecked = false;

  // void initState() {
  //   super.initState();
  //   menuHelper = MenuHelper();
  //   menuHelper.allMenu().then((tableDatabase){
  //     setState(() {
  //       allMenu = tableDatabase;
  //       items = allMenu;
  //     });
  //   });
  // }

  List<MenuRecipeModel> menu = [];
  List<MenuRecipeModel> filter = [];
  List<UserModel> user = [];
  List<UserModel> filtersearch = [];
  List<MethodModel> method_list = [];

  void readSQLite() {
    MenuRecipeHelper().readDataFromSQLite().then((menus) {
      for (var model in menus) {
        setState(() {
          menu.add(model);
          filter.add(model);
        });
      }
    });
    UserHelper().readlDataFromSQLite().then((users) {
      for (var model in users) {
        setState(() {
          user.add(model);
          filtersearch.add(model);
        });
      }
    });
    MethodHelper().readDataFromSQLite().then((methods) {
      MethodModel methodModel = MethodModel(nameMethod: "All");
      method_list.add(methodModel);
      for (var model in methods) {
        setState(() {
          method_list.add(model);
        });
      }
    });
  }

  getUserFollowers(UserModel userModel) {
    var objects = FollowHelper().getFollower(userModel.uid!);
    return objects;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userHelper = UserHelper();
    userHelper.readlDataFromSQLite().then((tableDatabase) {
      setState(() {
        allUser = tableDatabase;
        items = allUser;
      });
    });
    // MenuHelper().deleteAlldata();
    // MenuHelper().initInsertToSQLite();
    readSQLite();
  }

  Widget buildPictureBtn(int index) {
    print(filter[index].nameMenu);
    print(filter[index].menuImage);
    final ref = FirebaseStorage.instance
        .ref()
        .child('menus')
        .child(filter[index].menuImage!);
    var url = ref.getDownloadURL();

    return FutureBuilder<String>(
      future: url,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Stack(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.height * 0.15,
                child: GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(70), // Image radius
                      child: Image.network(snapshot.data!, fit: BoxFit.cover),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MenuDetail(filter[index]);
                    }));
                  },
                ),
              ),
            ]),
            Text(
              filter[index].nameMenu!,
              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 15),
              overflow: TextOverflow.ellipsis,
            ),
            filter[index].recipeName != null
                ? Text(
                    filter[index].recipeName!,
                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  )
                : Container()
          ];
        } else {
          children = <Widget>[CircularProgressIndicator()];
        }
        return Column(children: children);
      },
    );
  }

  Widget buildapplyBtn() {
    return RaisedButton(
      // onPressed: () {},
      onPressed: () {
        // var rount = new MaterialPageRoute(
        //     builder: (BuildContext context) => new Search());
        // Navigator.of(context).push(rount);
        Navigator.pop(context);
      },
      textColor: Colors.white,
      color: Colors.green,
      disabledColor: Colors.black,
      child: Text("APPLY"),
      // onPressed: () {},
      padding: EdgeInsets.all(15),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }

  Widget builduserBtn(int index) {
    // final ref = FirebaseStorage.instance
    //     .ref()
    //     .child('menus')
    //     .child(filter[index].image! + '.jpeg');
    // var url = ref.getDownloadURL();

    return FutureBuilder<String>(
      // future: url,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            // Stack(children: <Widget>[
            //   GestureDetector(
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20), // Image border
            //       child: SizedBox.fromSize(
            //         size: Size.fromRadius(55), // Image radius
            //         child: Image.network(snapshot.data!, fit: BoxFit.cover),
            //       ),
            //     ),
            //     onTap: () {
            //     },
            //   ),
            // ]),
            Text(
              filtersearch[index].username!,
              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 15),
              overflow: TextOverflow.ellipsis,
            )
          ];
        } else {
          children = <Widget>[CircularProgressIndicator()];
        }
        return Column(children: children);
      },
    );
  }

  void filterSeach(String query) async {
    var dummySearchList = allUser;
    if (query.isNotEmpty) {
      var dummyListData = [];
      dummySearchList.forEach((item) {
        // var user = UserModel.fromJson(item);
        if (item.username!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items = [];
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items = [];
        items = allUser;
      });
    }
  }

  MethodHelper methodHelper = MethodHelper();
  UserHelper userHelper = UserHelper();
  MenuHelper menuHelper = MenuHelper();
  String? keyword;
  static const color = const Color(0xffffab91);
  // bool boil = false;
  // bool bake = false;
  // bool fry = false;
  // bool sav = false;
  // bool des = false;
  // bool kit = false;
  // bool alg = false;

  int? _value = 0;

  // List of items in our dropdown menu

  @override
  filterMethod(MethodModel methodModel) {
    if (methodModel.nameMethod != "All") {
      setState(() {
        filter = [];
        for (var object in menu) {
          if (object.method == methodModel.nameMethod) {
            filter.add(object);
          }
        }
      });
    } else {
      setState(() {
        filter = [];
        for (var object in menu) {
          filter.add(object);
        }
      });
    }
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.account_circle),
              ),
              Tab(
                icon: Icon(Icons.fastfood_rounded),
              ),
            ],
          ),
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: TextField(
                controller: teSeach,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    border: InputBorder.none),
                onChanged: (value) {
                  setState(() {
                    filterSeach(value);
                    filter.clear();
                    filter.addAll(menu);
                    filter.retainWhere((element) {
                      return element.nameMenu!.contains(value);
                    });
                    filtersearch.clear();
                    filtersearch.addAll(user);
                    filtersearch.retainWhere((element) {
                      return element.username!.contains(value);
                    });
                  });
                },
              ),
            ),
          ),
        ),
        body: TabBarView(children: <Widget>[
          Center(
            child: items.isNotEmpty
                ? ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      var url;
                      if (items[i].image != null) {
                        final ref = FirebaseStorage.instance
                            .ref()
                            .child('upload')
                            .child(items[i].image!);
                        url = ref.getDownloadURL();
                      }
                      var followers = getUserFollowers(items[i]);
                      return url != null
                          ? FutureBuilder<String>(
                              future: url,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return OtherProfile(
                                              snapshot.data!, items[i].uid);
                                        }));
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        margin: EdgeInsets.all(3),
                                        child: ListTile(
                                            leading: Image.network(
                                                snapshot.data!,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                fit: BoxFit.fill),
                                            title: Text('${items[i].username}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            subtitle: FutureBuilder<
                                                    List<FollowModel>>(
                                                future: followers,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                        'Follow : ${snapshot.data!.length}');
                                                  } else {
                                                    return Text('Follow : 0');
                                                  }
                                                })

                                            // trailing: IconButton(
                                            //   onPressed: () {},
                                            //   icon: Icon(Icons.more_vert),
                                            // ),
                                            ),
                                      ));
                                } else {
                                  return CircularProgressIndicator();
                                }
                              })
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return OtherProfile(
                                      "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg",
                                      items[i].uid);
                                }));
                              },
                              child: Card(
                                color: Colors.white,
                                margin: EdgeInsets.all(3),
                                child: ListTile(
                                    leading: Image.network(
                                        "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg",
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        fit: BoxFit.fill),
                                    title: Text('${items[i].username}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    subtitle: FutureBuilder<List<FollowModel>>(
                                        future: followers,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                                'Follow : ${snapshot.data!.length}');
                                          } else {
                                            return Text('Follow : 0');
                                          }
                                        })

                                    // trailing: IconButton(
                                    //   onPressed: () {},
                                    //   icon: Icon(Icons.more_vert),
                                    // ),
                                    ),
                              ));
                    })
                : Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      'No results found',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
          ),

          // Center(
          //   child: Expanded(
          //     child: ListView.builder(
          //         itemCount: method_list.length,
          //         itemBuilder: (context, index) {
          //           return Card(
          //             margin: EdgeInsets.all(8),
          //             child: ListTile(
          //               title: Text('${method_list[index].nameMethod}',
          //                   style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black)),
          //             ),
          //           );
          //         }),
          //   )
          // ),
          Center(
            child: Container(
              margin: EdgeInsets.all(5),
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(5)),
                      Expanded(
                        child: Container(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: method_list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () => setState(() {
                                  _value = index;
                                  filterMethod(method_list[index]);
                                }),
                                child: Container(
                                  width: 70,
                                  child: Card(
                                    shape: (_value == index)
                                        ? RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 7,
                                                color: Palette.roseBud))
                                        : null,
                                    elevation: 7,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          '${method_list[index].nameMethod}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: filter.isNotEmpty
                          ? MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300.0,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 20.0,
                                ),
                                padding: EdgeInsets.only(
                                    top: 5, left: 5, right: 5, bottom: 5),
                                primary: false,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: filter.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.transparent,
                                            width: 1),
                                      ),
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10),
                                          buildPictureBtn(index),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ))
                          : Padding(
                              padding: EdgeInsets.only(top: 210),
                              child: Text(
                                'No results found',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ))
                ],
              ),
            ),
          ),
          // child: filter.isNotEmpty
          //     ? MediaQuery.removePadding(
          //     context: context,
          //     removeTop: true,
          //     child: GridView.builder(
          //       gridDelegate:
          //       const SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2),
          //       padding:
          //       EdgeInsets.only(top: 5,left: 5,right: 5),
          //       primary: false,
          //       shrinkWrap: true,
          //       physics: ScrollPhysics(),
          //       itemCount: filter.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         return Container(
          //           child: Card(
          //             shape: RoundedRectangleBorder(
          //               side: BorderSide(color:Colors.transparent,width: 1),
          //               // borderRadius: BorderRadius.circular(15),
          //             ),
          //             color: Colors.white,
          //             child: Column(
          //               children: [
          //                 SizedBox(height: 8),
          //                 buildPictureBtn(index),
          //               ],
          //             ),
          //           ),
          //         );
          //       },
          //     ))
          //     : Text('No results found',
          //
        ]),
      ),
    );
  }
}

var top = new Column(
  children: <Widget>[
    Expanded(
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  "User",
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 0.5),
                ),
                Text("See more >>"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            makeFeed(
                userName: 'egg boi',
                userImage: 'lib/assets/icon/Icon-App.png',
                follow: '615 Followers',
                Recipes: 'Recipes'),
            // SizedBox(height: 20,),
            // Container(
            //   height: 50,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: <Widget>[
            //       makeFood(
            //         foodImage: 'assets/icon/Icon-App.png',
            //         foodName: 'ไข่เจียว'
            //       ),
            //     ],),
            // )
          ],
        ),
      ),
    )),
  ],
);

class FoodCard extends StatelessWidget {
  const FoodCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        children: <Widget>[
          //ใส่รูปจ้า ทำยังไง
          Text(
            "ผัดกะเพรา",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

Widget makeFeed({userName, userImage, follow, Recipes}) {
  return Container(
    margin: EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(userImage), fit: BoxFit.cover)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userName,
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      follow,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          Recipes,
          style: TextStyle(
              color: Colors.grey[900],
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 0.5),
        ),
        SizedBox(
          height: 20,
        ),

        // Expanded(
        //   child: GridView.count(
        //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        //     crossAxisCount: 2,
        //     childAspectRatio: .85,
        //     crossAxisSpacing: 20,
        //     mainAxisSpacing: 20,
        //     children: <Widget>[
        //       FoodCard(),
        //       FoodCard(),
        //       FoodCard(),
        //       FoodCard(),
        //       FoodCard(),
        //       FoodCard(),
        //       FoodCard(),
        //       FoodCard(),
        //
        //
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        Container(
          color: Colors.transparent,
          height: 600,
          child: GridView.count(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            crossAxisCount: 2,
            childAspectRatio: .85,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: <Widget>[
              FoodCard(),
              FoodCard(),
              FoodCard(),
              FoodCard(),
              FoodCard(),
              FoodCard(),
              FoodCard(),
              FoodCard(),
              FoodCard(),
              FoodCard(),
              FoodCard(),
              FoodCard(),
              FoodCard(),
            ],
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
        // Container(
        //   height: 200,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       image: DecorationImage(
        //           image: AssetImage(userImage), fit: BoxFit.cover)),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // Container(
        //   height: 200,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       image: DecorationImage(
        //           image: AssetImage(userImage), fit: BoxFit.cover)),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // Container(
        //   height: 200,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       image: DecorationImage(
        //           image: AssetImage(userImage), fit: BoxFit.cover)),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // Container(
        //   height: 200,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       image: DecorationImage(
        //           image: AssetImage(userImage), fit: BoxFit.cover)),
        // ),
        // Expanded(
        //   child: GridView.count(
        //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        //     crossAxisCount: 2,
        //     childAspectRatio: .85,
        //     crossAxisSpacing: 20,
        //     mainAxisSpacing: 20,
        //     children: <Widget>[
        //       foodCard(),
        //       foodCard(),
        //       foodCard(),
        //       foodCard(),
        //       foodCard(),
        //       foodCard(),
        //       foodCard(),
        //       foodCard(),
        //     ],
        //   ),),
      ],
    ),
  );
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        children: <Widget>[
          //ใส่รูปจ้า ทำยังไง
          Text(
            "ผัดกะเพรา",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
