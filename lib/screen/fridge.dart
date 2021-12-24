import 'package:flutter/material.dart';

class Fridge extends StatefulWidget {
  static const routeName = '/';

  const Fridge({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FridgeState();
  }
}

class _FridgeState extends State<Fridge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fridge'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Fridge Screen'),
        ],
      )),
    );
  }
}
