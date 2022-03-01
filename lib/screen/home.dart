import 'package:flutter/material.dart';
import 'home/recipe_content.dart';
import 'home/daily_pick.dart';
import 'home/Discover.dart';
import 'home/trending.dart';
import 'package:hewa/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hewa/utilities/db_helper.dart';
import 'package:hewa/utilities/recipe_helper.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/utilities/menuRecipe_helper.dart';

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
  String greetings = '';
  List<dynamic> recommendations = [];
  List<MenuRecipeModel> menuRecipeModels = [];
  List<MenuRecipeModel> trendingModels = [];
  List<MenuRecipeModel> followingModels = [];
  List<MenuRecipeModel> dailyPickModels = [];
  var auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    getAllData();
    getTrending();
    getFollowing();
    getDailyPcik();
    super.initState();
  }

  getPreference() async {
    final dbPath = base64.encode(utf8.encode(await DBHelper().getDbPath()));
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:5000/recommendation?uid=' +
            FirebaseAuth.instance.currentUser!.uid +
            "&databaseLocation=" +
            dbPath));

    final decoded = json.decode(response.body) as Map<String, dynamic>;

    setState(() {
      greetings = decoded['uid'];
      recommendations = decoded['recommendation'];
      print(recommendations);
    });
  }

  getAllData() async {
    var objects = await MenuRecipeHelper().readDataFromSQLite();
    for (var object in objects) {
      print(object);
      setState(() {
        menuRecipeModels.add(object);
      });
    }
  }

  getTrending() async {
    var objects = await MenuRecipeHelper().getTrending();
    for (var object in objects) {
      setState(() {
        trendingModels.add(object);
      });
    }
  }

  getFollowing() async {
    var objects = await MenuRecipeHelper().getFollowing(auth.currentUser!.uid);
    for (var object in objects) {
      setState(() {
        followingModels.add(object);
      });
    }
  }

  getDailyPcik() async {
    var objects = await MenuRecipeHelper().getDailyPick();
    for (var object in objects) {
      setState(() {
        dailyPickModels.add(object);
      });
    }
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
                'Following',
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
          ? Discover(followingModels)
          : dp
              ? DailyPick(menuRecipeModels)
              : Trending(trendingModels));

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
