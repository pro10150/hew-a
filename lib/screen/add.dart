import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:page_transition/page_transition.dart';
import 'add/existing_menu.dart';
import 'add/new_menu.dart';

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
        backgroundColor: Color(0xffffab91),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 200),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Add new recipe',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ),
            SizedBox(height: 100),
            GFButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: ExistingMenu(),
                        type: PageTransitionType.rightToLeft));
              },
              child: Container(
                width: 200,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Select existing menu'),
                      Icon(Icons.arrow_forward)
                    ]),
              ),
              shape: GFButtonShape.pills,
              buttonBoxShadow: true,
              size: 50,
              color: GFColors.WHITE,
              textStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 30),
            GFButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: NewMenu(),
                        type: PageTransitionType.rightToLeft));
              },
              child: Container(
                width: 200,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Create new menu'),
                      Icon(Icons.arrow_forward)
                    ]),
              ),
              shape: GFButtonShape.pills,
              buttonBoxShadow: true,
              size: 50,
              color: GFColors.WHITE,
              textStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            )
          ],
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
