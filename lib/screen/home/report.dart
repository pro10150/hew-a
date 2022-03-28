import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'report_user.dart';
import 'report_Recipe.dart';

class ReportPage extends StatefulWidget {
  ReportPage(this.userModel, this.menuRecipeModel);
  UserModel userModel;
  MenuRecipeModel menuRecipeModel;
  @override
  _ReportPageState createState() =>
      _ReportPageState(userModel, menuRecipeModel);
}

class _ReportPageState extends State<ReportPage> {
  _ReportPageState(this.userModel, this.menuRecipeModel);
  UserModel userModel;
  MenuRecipeModel menuRecipeModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Report")),
      body: Column(children: [
        Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 30),
            child: TextButton(
                child: Row(children: [
                  Text(
                    "User",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded)
                ]),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportUser(userModel)));
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(300, 45)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)))))),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: TextButton(
              child: Row(children: [
                Text(
                  "Recipe",
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded)
              ]),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportRecipe(menuRecipeModel)));
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(300, 45)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                  ))),
        )
      ]),
    );
  }
}
