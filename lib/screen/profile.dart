import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hewa/screen/profile/EditProfile.dart';
import 'package:page_transition/page_transition.dart';
import 'login/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  static const routeName = '/';

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
  void signOut(BuildContext context) {
    _auth.signOut();
    Future.delayed(Duration.zero, () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          ModalRoute.withName('/'));
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    controller = TabController(length: 2, vsync: this);
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
                                                  "Johannieieie",
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
                                                        child: Text(
                                                          'Log out',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white),
                                                        )))
                                              ]),
                                        ),
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                                          ),
                                          radius: 60.0,
                                        ),
                                        Text(
                                          "@iamJohannie",
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
                                                        "520",
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
                                                        "following",
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
                                                        "116",
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
                                                        "6",
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
                                                        "Recripes",
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
                    expandedHeight: 380,
                    bottom: TabBar(
                      labelColor: Colors.redAccent,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          icon: Icon(Icons.menu_book),
                        ),
                        Tab(
                          icon: Icon(Icons.favorite),
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
                  Expanded(
                      child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: <Widget>[
                      recipes(),
                      recipes(),
                      recipes(),
                      recipes(),
                      recipes(),
                      recipes(),
                      recipes(),
                      recipes(),
                      recipes(),
                      recipes(),
                      recipes()
                    ],
                  )),
                  Expanded(
                      child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: <Widget>[
                      recipes(),
                      recipes(),
                      recipes(),
                      recipes(),
                      recipes(),
                      recipes(),
                    ],
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
  const recipes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print('Tap');
        },
        child: Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                  image: NetworkImage(
                      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg"))),
        )

        // child: Column(
        //   children: <Widget>[
        //     Image.network(
        //         "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")
        //   ],
        // ),
        );
  }
}

navigateToEditPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return EditProfile();
  }));
}

var rep = new Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.start,
  children: <Widget>[
    Expanded(
      child: Image.network(
        "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
        width: 1000,
        height: 2000,
      ),
    ),
  ],
);
