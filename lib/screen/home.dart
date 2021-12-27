import 'package:flutter/material.dart';
import 'home/actions_toolbar.dart';
import 'home/recipe_description.dart';
import 'home/recipe_content.dart';

class Home extends StatefulWidget {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget get topSection => Container(
        height: 100,
        padding: EdgeInsets.only(bottom: 15),
        alignment: Alignment(0.0, 1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Discover'),
            Container(width: 15),
            Text(
              'Daily Pick',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Container(
              width: 15,
            ),
            Text('Trending')
          ],
        ),
      );

  Widget get middleSection => Expanded(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  image: AssetImage('assets/home/food.png'),
                  fit: BoxFit.cover,
                  height: 430,
                  width: 350,
                ),
                // decoration:
                //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[recipeDescription(), actionsToolbar()],
            )
          ],
        ),
      );

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[topSection, middleSection],
      ),
    );
  }
}
