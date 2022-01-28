import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'regsrceen.dart';
import 'allergies.dart';
import 'package:hewa/utilities/menu.helper.dart';
import 'package:hewa/models/menu_model.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:hewa/utilities/userMenu_helper.dart';
import 'package:hewa/models/userMenu_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Mealpre extends StatefulWidget {
  @override
  MealpreState createState() => MealpreState();
}

class MealpreState extends State<Mealpre> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Widget buildnextBtn() {
    return Container(
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          for (var i = 0; i < _selected.length; i++) {
            if (_selected[i] == true) {
              UserMenuModel userMenuModel = UserMenuModel(
                  uid: _auth.currentUser!.uid, menuId: menu[i].id!);
              UserMenuHelper().insertDataToSQLite(userMenuModel);
            }
          }
          var rount = new MaterialPageRoute(
              builder: (BuildContext context) => new Allergies());
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

  List<MenuModel> menu = [];
  List<MenuModel> filter = [];
  void readSQLite() {
    MenuHelper().readlDataFromSQLite().then((menus) {
      for (var model in menus) {
        menu.add(model);
        filter.add(model);
      }
      setState(() {
        _selected = List.generate(menu.length, (index) => false);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // MenuHelper().deleteAlldata();
    // MenuHelper().initInsertToSQLite();
    readSQLite();
  }

  List<bool> _selected = [];
  Widget buildmealBtn(int index) {
    final ref = FirebaseStorage.instance
        .ref()
        .child('menus')
        .child(filter[index].image! + '.jpeg');
    var url = ref.getDownloadURL();

    return FutureBuilder<String>(
      future: url,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Stack(children: <Widget>[
              GestureDetector(
                child: _selected[index] == true
                    ? CircleAvatar(
                        minRadius: 50,
                        backgroundColor: Colors.green,
                        child: CircleAvatar(
                          minRadius: 45,
                          backgroundImage: NetworkImage(snapshot.data!),
                        ))
                    : CircleAvatar(
                        minRadius: 50,
                        backgroundImage: NetworkImage(snapshot.data!),
                      ),
                onTap: () {
                  setState(() {
                    _selected[index] = !_selected[index];
                  });
                  print(_selected[index]);
                },
              ),
            ]),
            Text(
              filter[index].nameMenu!,
              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            )
          ];
        } else {
          children = <Widget>[CircularProgressIndicator()];
        }
        return Column(children: children);
      },
    );

    // ElevatedButton(
    //   onPressed: () => setState(() => _flag = !_flag),
    //   child: Text("Meal"),
    //   style: ElevatedButton.styleFrom(
    //     onPrimary : Colors.teal, primary: _flag ? Colors.black,// This is what you need!
    //   ),
    // );

    //

    //   ElevatedButton(
    //   style: ButtonStyle(
    //     foregroundColor: getColor(Colors.white,Colors.black),
    //     backgroundColor: getColor(Colors.black,Colors.white),
    //   ),
    //     onPressed: () {},
    //     child: Text("Meal")
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: buildnextBtn(),
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
                        margin: EdgeInsets.only(right: 35.0, left: 33.0),
                        child: Column(children: <Widget>[
                          Text(
                            "Choose your preference",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Don\'t worry you can update this later')
                        ])),
                    SizedBox(height: 30),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              filter.clear();
                              filter.addAll(menu);
                              filter.retainWhere((element) {
                                return element.nameMenu!.contains(value);
                              });
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Search'),
                        )),
                    SizedBox(height: 30),
                    MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GridView.builder(
                          padding:
                              EdgeInsets.only(top: 30, left: 10, right: 10),
                          primary: false,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount: filter.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildmealBtn(index);
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
