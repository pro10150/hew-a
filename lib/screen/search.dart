import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'search/searchmain.dart';

class Search extends StatefulWidget {
  static const routeName = '/';

  const Search({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<Search> {
  static const color = const Color(0xffffab91);
  bool boil = false;
  bool bake = false;
  bool fry = false;
  bool sav = false;
  bool des = false;

  bool kit = false;
  bool alg = false;

  int? _value = 1;

  @override
  // Widget build(BuildContext context) {
  //   var size = MediaQuery.of(context).size;
  //   const color = const Color(0xffffab91);
  //   return Scaffold(
  //     body: Stack(
  //       children: <Widget>[
  //         Container(
  //           height: 130,
  //           padding: EdgeInsets.only(top: 50, right: 25, left: 30, bottom: 10),
  //           decoration: BoxDecoration(color: color),
  //         ),
  //         SafeArea(
  //           child: Column(
  //             children: <Widget>[
  //               Container(
  //                 margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 40.0),
  //                 padding:
  //                     EdgeInsets.only(top: 5, right: 25, left: 5, bottom: 1),
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //                 child: TextField(
  //                   onSubmitted: (_) {
  //                     Navigator.push(
  //                         context,
  //                         PageTransition(
  //                             child: SearchContent(),
  //                             type: PageTransitionType.leftToRight));
  //                   },
  //                   decoration: InputDecoration(
  //                     prefixIcon: Icon(
  //                       Icons.search,
  //                       color: Colors.grey,
  //                     ),
  //                     border: InputBorder.none,
  //                     hintText: "SearchWidget Menu",
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 12,
  //               ),
  //               Expanded(
  //                 child: GridView.count(
  //                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
  //                   crossAxisCount: 2,
  //                   childAspectRatio: .85,
  //                   crossAxisSpacing: 20,
  //                   mainAxisSpacing: 20,
  //                   children: <Widget>[
  //                     CategoryCard(),
  //                     CategoryCard(),
  //                     CategoryCard(),
  //                     CategoryCard(),
  //                     CategoryCard(),
  //                     CategoryCard(),
  //                     CategoryCard(),
  //                     CategoryCard(),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //
  //     // appBar: AppBar(
  //     //   title: Text('SearchWidget'),
  //     // ),
  //     // body: Center(
  //     //     child: Column(
  //     //   mainAxisAlignment: MainAxisAlignment.center,
  //     //   children: <Widget>[
  //     //     Text('SearchWidget Screen'),
  //     //   ],
  //     // )),
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        toolbarHeight: 100,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: TextField(
              onSubmitted: (_) {
                Navigator.push(
                    context,
                    PageTransition(
                        child: SearchContent(),
                        type: PageTransitionType.leftToRight));
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  border: InputBorder.none),
            ),
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.filter_list, color: Colors.black),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25),
                    Text(
                      'Filters',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //อันที่ 1
                    SizedBox(height: 25),
                    Text(
                      'Method',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    CheckboxListTile(
                      value: boil,
                      activeColor: Colors.black,
                      title: Text(
                        'Boil',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onChanged: (val) {
                        setState(() {
                          boil = val!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      value: bake,
                      activeColor: Colors.black,
                      title: Text(
                        'Bake',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onChanged: (val) {
                        setState(() {
                          bake = val!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      value: fry,
                      activeColor: Colors.black,
                      title: Text(
                        'Fry',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onChanged: (val) {
                        setState(() {
                          fry = val!;
                        });
                      },
                    ),

                    //อันที่ 2
                    SizedBox(height: 50),
                    Text(
                      'Types of food',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    CheckboxListTile(
                      value: sav,
                      activeColor: Colors.black,
                      title: Text(
                        'Savory',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onChanged: (val) {
                        setState(() {
                          sav = val!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      value: des,
                      activeColor: Colors.black,
                      title: Text(
                        'Dessert',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onChanged: (val) {
                        setState(() {
                          des = val!;
                        });
                      },
                    ),

                    //อันที่ 3
                    SizedBox(height: 50),
                    Text(
                      'Filter',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SwitchListTile(
                        value: kit,
                        activeColor: Colors.black,
                        title: Text(
                          'Kitchenwares',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onChanged: (bool s) {
                          setState(() {
                            kit = s;
                            print(kit);
                          });
                        }),
                    SwitchListTile(
                        value: alg,
                        activeColor: Colors.black,
                        title: Text(
                          'Allergies',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onChanged: (bool s) {
                          setState(() {
                            alg = s;
                            print(alg);
                          });
                        }),

                    SizedBox(height: 50),
                    Text(
                      'Sort by',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 15),
                        Text(
                          'Relevant',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 98),
                        Radio(
                          value: 1,
                          groupValue: _value,
                          onChanged: (int? value) {
                            setState(() {
                              _value = value;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 15),
                        Text(
                          'Most liked',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 83),
                        Radio(
                          value: 2,
                          groupValue: _value,
                          onChanged: (int? value) {
                            setState(() {
                              _value = value;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: DefaultTabController(
                    length: 3, // length of tabs
                    initialIndex: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 120, vertical: 0)),
                        Container(
                          child: TabBar(
                            labelColor: Colors.redAccent,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(
                                text: "Top",
                              ),
                              Tab(
                                text: "Users",
                              ),
                              Tab(
                                text: "Recipes",
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: 509,
                            //height of TabBarView
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: TabBarView(children: <Widget>[
                              top,
                              Text("User"),
                              Text("Recipes")
                            ]))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
