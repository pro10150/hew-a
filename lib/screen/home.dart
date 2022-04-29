import 'package:flutter/material.dart';
import 'home/discover.dart';
import 'home/recipe_content.dart';
import 'home/daily_pick.dart';
import 'home/trending.dart';
import 'package:hewa/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:hewa/utilities/db_helper.dart';
import 'package:hewa/utilities/recipe_helper.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/models/view_model.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/models/userKitch_model.dart';
import 'package:hewa/utilities/view_helper.dart';
import 'package:hewa/utilities/menuRecipe_helper.dart';
import 'package:hewa/utilities/user_helper.dart';
import 'package:hewa/utilities/userKitch_helper.dart';
import 'login/loginscreen.dart';

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
  var _auth = FirebaseAuth.instance;
  String greetings = '';
  List<dynamic> recommendations = [];
  List<MenuRecipeModel> menuRecipeModels = [];
  List<MenuRecipeModel> trendingModels = [];
  List<MenuRecipeModel> followingModels = [];
  List<MenuRecipeModel> dailyPickModels = [];
  List<UserKitchenwareModel> userKitchenwareModels = [];
  List<UserModel> recommendedUserModels = [];
  UserModel? userModel;
  var auth = FirebaseAuth.instance;
  void _onLoading() async {
    getAllData();
    getTrending();
    getFollowing();
    getDailyPick();
    getUser();
    getRecommendedUserModel();
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllData();
    getTrending();
    getFollowing();
    getDailyPick();
    getUser();
    getRecommendedUserModel();
    checkBan();
    super.initState();
  }

  getUser() async {
    var objects =
        await UserHelper().readDataFromSQLiteWhereId(_auth.currentUser!.uid);
    setState(() {
      userModel = objects.first;
      print(userModel!.uid);
    });
  }

  getUserKitchenware() async {
    var objects = await UserKitchHelper()
        .readDataFromSQLiteWhereUser(_auth.currentUser!.uid);
    for (var object in objects) {
      setState(() {
        userKitchenwareModels.add(object);
      });
    }
  }

  getPreference() async {
    final dbPath = base64.encode(utf8.encode(await DBHelper().getDbPath()));
    final response = await http.get(Uri.parse(
        'http://192.168.1.108:5000/recommendation?uid=' +
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

  getRecommendedUserModel() async {
    var objects = await UserHelper().getUserTop5(_auth.currentUser!.uid);
    recommendedUserModels = objects;
  }

  getAllData() async {
    setState(() {
      menuRecipeModels.clear();
    });
    var objects = await MenuRecipeHelper().readDataFromSQLite();
    for (var object in objects) {
      print(object);
      setState(() {
        menuRecipeModels.add(object);
      });
    }
  }

  getTrending() async {
    setState(() {
      trendingModels.clear();
    });
    var objects = await MenuRecipeHelper().getTrending();
    for (var object in objects) {
      setState(() {
        trendingModels.add(object);
      });
    }
  }

  getFollowing() async {
    setState(() {
      followingModels.clear();
    });
    var objects = await MenuRecipeHelper().getFollowing(auth.currentUser!.uid);
    for (var object in objects) {
      setState(() {
        followingModels.add(object);
      });
    }
  }

  getDailyPick() async {
    setState(() {
      dailyPickModels.clear();
    });
    var objects = await MenuRecipeHelper().getDailyPick();
    for (var object in objects) {
      setState(() {
        dailyPickModels.add(object);
      });
    }
  }

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        ModalRoute.withName('/'));
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  showAlert() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Ban details"),
            content: Container(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You have been banned!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(userModel!.isPermanentlyBan == 1
                        ? "You will be banned permanently"
                        : "You will be banned until"),
                    userModel!.isPermanentlyBan == 1
                        ? Container()
                        : Text(userModel!.dateBanned!)
                  ]),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  "I understand",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }).then((value) => signOut(context));
  }

  checkBan() async {
    var objects =
        await UserHelper().readDataFromSQLiteWhereId(_auth.currentUser!.uid);
    var currentDate = DateTime.now();
    var period = daysBetween(
        DateFormat("yyyy-MM-dd hh:mm:ss").parse(objects.first.dateBanned!),
        currentDate);
    print("tttttttttttttttttt");
    print(period);
    if (period < 3 || userModel!.isPermanentlyBan == 1) {
      showAlert();
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
                _onLoading();
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
                  _onLoading();
                  setState(() {
                    dsc = false;
                    dp = true;
                    trd = false;
                  });
                },
                child: Text(
                  'Discover',
                  style: dp
                      ? TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)
                      : TextStyle(color: Colors.black, fontSize: 16),
                )),
            TextButton(
              onPressed: () {
                _onLoading();
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
      child: userModel != null
          ? dsc
              ? Following(followingModels, userModel!, recommendedUserModels)
              : dp
                  ? DailyPick(dailyPickModels, userModel!)
                  : Trending(trendingModels, userModel!)
          : Container());

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
