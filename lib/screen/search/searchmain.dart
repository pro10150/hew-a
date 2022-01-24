// import 'dart:html';
// import 'dart:js';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchContent extends StatefulWidget {
  static const routeName = '/';

  const SearchContent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchContentState();
  }
}

class _SearchContentState extends State<SearchContent> {
  static const color = const Color(0xffffab91);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 130,
            padding: EdgeInsets.only(top: 50, right: 0, left: 20, bottom: 1),
            decoration: BoxDecoration(color: color),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200]),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        hintText: "SearchContent Menu",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                //Icon ตัวกรอง
              ],
            ),
          ),
          DefaultTabController(
              length: 3, // length of tabs
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
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
                        height: 603, //height of TabBarView
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: TabBarView(children: <Widget>[
                          top,
                          Text("User"),
                          Text("Recipes")
                        ]))
                  ])),
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
        Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(userImage), fit: BoxFit.cover)),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(userImage), fit: BoxFit.cover)),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(userImage), fit: BoxFit.cover)),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(userImage), fit: BoxFit.cover)),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(userImage), fit: BoxFit.cover)),
        ),
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

// Widget makeFood({foodName, foodImage}){
//   return AspectRatio(
//     aspectRatio: 1.6 / 2,
//     child: Container(
//       margin: EdgeInsets.only(right: 10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         image:DecorationImage(
//           image: AssetImage(foodImage),
//           fit:BoxFit.cover
//           ),
//         ),
//       ),
//   );
// }

// class foodCard extends StatelessWidget {
//   const foodCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.orange[50],
//         borderRadius: BorderRadius.circular(13),
//       ),
//       child: Column(
//         children: <Widget>[
//           //ใส่รูปจ้า ทำยังไง
//           Text(
//             "ผัดกะเพรา",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//             fontSize: 24.0,
//             color: Colors.black,
//             fontWeight: FontWeight.bold),
//       ),
//         ],
//       ),
//     );
//   }
// }
