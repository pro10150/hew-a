import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'regsrceen.dart';
// import 'allergies.dart';
import 'choosekit.dart';
import 'package:hewa/utilities/ingred_helper.dart';
import 'package:hewa/models/ingred_model.dart';
import 'package:hewa/models/reAllergy_model.dart';
import 'package:hewa/utilities/reAllergy_helper.dart';

class Chooseallergies extends StatefulWidget {
  @override
  ChooseallergiesState createState() => ChooseallergiesState();
}

class ChooseallergiesState extends State<Chooseallergies> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Widget buildallergiesBtn(int index) {
    return Container(
        padding: EdgeInsets.all(10),
        child: TextButton(
          onPressed: () {
            setState(() {
              _selected[index] = !_selected[index];
            });
          },
          child: Text(
            ingredients[index].name!,
            textAlign: TextAlign.center,
          ),
          style: ButtonStyle(
              foregroundColor: _selected[index] == false
                  ? MaterialStateProperty.all<Color>(Colors.black)
                  : MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: _selected[index] == false
                  ? MaterialStateProperty.all<Color>(Colors.white)
                  : MaterialStateProperty.all<Color>(Colors.red),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)))),
        ));
  }

  Widget buildnextBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: 320,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          for (var i = 0; i < _selected.length; i++) {
            if (_selected[i] == true) {
              ReAllergyHelper().insertDataToSQLite(ReAllergyModel(
                  allID: ingredients[i].id, userID: _auth.currentUser!.uid));
            }
          }
          var rount = new MaterialPageRoute(
              builder: (BuildContext context) => new Choosekitchenware());
          Navigator.of(context).push(rount);
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: Colors.black,
        child: Text(
          'Next',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  List<IngredModel> ingredients = [];
  List<bool> _selected = [];
  void readSQLite() {
    IngredHelper().readlDataFromSQLite().then((value) {
      for (var model in value) {
        ingredients.add(model);
      }
      setState(() {
        _selected = List.generate(ingredients.length, (index) => false);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSQLite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color(0xffffffff),
                  Color(0xffff8a65),
                  Color(0xffe69a83),
                ],
                center: Alignment.topRight,
                radius: 3,
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.only(top: 50, right: 35.0, left: 33.0),
                  child: Text(
                    "Choose your Allergies",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GridView.builder(
                      padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                      primary: false,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: ingredients.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildallergiesBtn(index);
                      },
                    )),
                buildnextBtn(),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
