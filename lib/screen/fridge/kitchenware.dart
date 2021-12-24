import 'package:flutter/material.dart';

class Kitchenware extends StatefulWidget {
  static const routeName = '/';

  const Kitchenware({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _KitchenwareState();
  }
}

class _KitchenwareState extends State<Kitchenware> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('Kitchenwares')],
        ),
      ),
    );
  }
}
