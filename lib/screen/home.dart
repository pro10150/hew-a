import 'package:flutter/material.dart';
import 'home/recipe_content.dart';
import 'home/daily_pick.dart';
import 'home/discover.dart';
import 'home/trending.dart';
import 'package:hewa/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  bool dsc = false;
  bool dp = true;
  bool trd = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(_auth.currentUser);
  }

  @override
  Widget get topSection => Container(
        height: 100,
        padding: EdgeInsets.only(bottom: 15),
        alignment: Alignment(0.0, 1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  dsc = true;
                  dp = false;
                  trd = false;
                });
              },
              child: Text(
                'Discover',
                style: dsc
                    ? TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)
                    : TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    dsc = false;
                    dp = true;
                    trd = false;
                  });
                },
                child: Text(
                  'Daily Pick',
                  style: dp
                      ? TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)
                      : TextStyle(color: Colors.black, fontSize: 16),
                )),
            TextButton(
              onPressed: () {
                setState(() {
                  dsc = false;
                  dp = false;
                  trd = true;
                });
              },
              child: Text(
                'Trending',
                style: trd
                    ? TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)
                    : TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      );

  Widget get middleSection => Container(
      child: dsc
          ? discover()
          : dp
              ? dailyPick()
              : trending());

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            child: Container(
                width: double.infinity, height: 400, color: Palette.roseBud),
          ),
          Column(
            children: <Widget>[topSection, middleSection],
          )
        ],
      ),
    );
  }
}
