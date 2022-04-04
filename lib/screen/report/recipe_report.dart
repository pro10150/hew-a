

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hewa/screen/login/loginscreen.dart';


class recipeReport extends StatefulWidget {
  const recipeReport({Key? key}) : super(key: key);

  @override
  _recipeReportState createState() => _recipeReportState();
}

class _recipeReportState extends State<recipeReport> {
  var _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Recipe Report",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () => signOut(context),
                icon: Icon(Icons.logout)),
          ],
        ),
        backgroundColor: Color(0xffffab91),
        elevation: 4.0,
      ),
      body: Center(
        child: Text('Recipe Report'),
      ),
      //ข้างล่าง
    );
  }
}
