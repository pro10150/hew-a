import 'package:flutter/material.dart';
import 'home/recipe_content.dart';
import 'home/daily_pick.dart';
import 'home/discover.dart';
import 'home/trending.dart';

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
      body: Column(
        children: <Widget>[topSection, middleSection],
      ),
    );
  }
}
