import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'recipe_step_1.dart';

class ExistingMenu extends StatefulWidget {
  @override
  _ExistingMenuState createState() => _ExistingMenuState();
}

class _ExistingMenuState extends State<ExistingMenu> {
  late TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffab91),
      body: Container(
          margin: EdgeInsets.only(
            top: 50,
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  BackButton(),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Select Existing menu',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                      onSubmitted: (_) {
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         child: RecipeStep1(),
                        //         type: PageTransitionType.rightToLeft));
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          filled: true,
                          hintText: 'menu',
                          fillColor: Colors.white)))
            ],
          )),
      // floatingActionButton: FloatingActionButton(
      //   elevation: 2.0,
      //   child: Container(
      //     width: 60,
      //     height: 60,
      //     child: Icon(
      //       IconData(0xe16a, fontFamily: 'MaterialIcons'),
      //       size: 40,
      //     ),
      //     decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         gradient: LinearGradient(
      //             colors: [Color(0xFFEC7063), Color(0xFFFFAB91)])),
      //   ),
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      // ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.centerDocked
    );
  }
}
