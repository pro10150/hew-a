import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  static const routeName = '/';

  const Add({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddState();
  }
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add'),
        ),
        //backgroundColor: Color(0xffffab91),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Add Screen'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 2.0,
          child: Container(
            width: 60,
            height: 60,
            child: Icon(
              IconData(0xe16a, fontFamily: 'MaterialIcons'),
              size: 40,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Color(0xFFEC7063), Color(0xFFFFAB91)])),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}
