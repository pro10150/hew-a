import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  static const routeName = '/';

  const Search({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Search Screen'),
        ],
      )),
    );
  }
}
