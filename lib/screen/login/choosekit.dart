import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hewa/models/kitch_model.dart';
// import 'regsrceen.dart';
// import 'allergies.dart';
import 'package:hewa/screen/home.dart';
import 'package:hewa/models/kitch_model.dart';
import 'package:hewa/models/userKitch_model.dart';
import 'package:hewa/utilities/kitch_helper.dart';
import 'package:hewa/utilities/userKitch_helper.dart';
import 'package:hewa/screen/launcher.dart';

class Choosekitchenware extends StatefulWidget {
  @override
  ChoosekitchenwareState createState() => ChoosekitchenwareState();
}

class ChoosekitchenwareState extends State<Choosekitchenware> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Widget buildkitchenwareBtn(int index) {
    return Container(
        padding: EdgeInsets.all(10),
        child: TextButton(
          onPressed: () {
            setState(() {
              _selected[index] = !_selected[index];
            });
          },
          child: Text(
            kitchenwares[index].nameKitc!,
            textAlign: TextAlign.center,
          ),
          style: ButtonStyle(
              foregroundColor: _selected[index] == false
                  ? MaterialStateProperty.all<Color>(Colors.black)
                  : MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: _selected[index] == false
                  ? MaterialStateProperty.all<Color>(Colors.white)
                  : MaterialStateProperty.all<Color>(Colors.green),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)))),
        ));
  }

  Widget builddoneBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          for (var i = 0; i < _selected.length; i++) {
            if (_selected[i] == true) {
              UserKitchHelper().insertDataToSQLite(UserKitchenwareModel(
                  uid: _auth.currentUser!.uid,
                  kitchenware: kitchenwares[i].nameKitc!));
            }
          }

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Launcher()));
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: Colors.black,
        child: Text(
          'Done',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  List<KitchenwareModel> kitchenwares = [];
  List<bool> _selected = [];

  void readSQLite() {
    KitchHelper().readlDataFromSQLite().then((value) {
      for (var kitchenware in value) {
        kitchenwares.add(kitchenware);
      }
      print(kitchenwares);
      setState(() {
        _selected = List.generate(kitchenwares.length, (index) => false);
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
      floatingActionButton: builddoneBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                  margin: EdgeInsets.only(top: 50, right: 20.0, left: 24.0),
                  child: Text(
                    "Choose your kitchenware",
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
                      itemCount: kitchenwares.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildkitchenwareBtn(index);
                      },
                    )),
                builddoneBtn(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
