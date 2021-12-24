import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Ingredients extends StatefulWidget {
  static const routeName = '/';

  const Ingredients({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IngredientsState();
  }
}

class _IngredientsState extends State<Ingredients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('Ingredients')],
        ),
      ),
    );
  }
}
