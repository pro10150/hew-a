import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  static const routeName = '/';

  const Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Profile Screen'),
        ],
      )),
    );
  }
}
