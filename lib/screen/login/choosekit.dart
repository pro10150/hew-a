import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hewa/models/kitch_model.dart';
import 'package:hewa/screen/add/recipe_step_1.dart';
// import 'regsrceen.dart';
// import 'allergies.dart';
import 'package:hewa/screen/home.dart';
import 'package:hewa/models/kitch_model.dart';
import 'package:hewa/models/userKitch_model.dart';
import 'package:hewa/utilities/kitch_helper.dart';
import 'package:hewa/utilities/userKitch_helper.dart';
import 'package:hewa/screen/launcher.dart';
import 'package:filter_list/filter_list.dart';
import 'package:hewa/config/palette.dart';

class Choosekitchenware extends StatefulWidget {
  @override
  ChoosekitchenwareState createState() => ChoosekitchenwareState();
}

class ChoosekitchenwareState extends State<Choosekitchenware> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<KitchenwareModel> kitchenwares = [];
  List<KitchenwareModel> _selected = [];

  void readSQLite() {
    KitchHelper().readlDataFromSQLite().then((value) {
      for (var kitchenware in value) {
        kitchenwares.add(kitchenware);
      }
      setState(() {});
    });
  }

  void deleteData() {
    UserKitchHelper().deleteDataWhereUser(_auth.currentUser!.uid);
  }

  // Widget builddoneBtn() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 20),
  //     child: RaisedButton(
  //       elevation: 5,
  //       onPressed: () {
  //         for (var i = 0; i < _selected.length; i++) {
  //           if (_selected[i] == true) {
  //             UserKitchHelper().insertDataToSQLite(UserKitchenwareModel(
  //                 uid: _auth.currentUser!.uid,
  //                 kitchenware: kitchenwares[i].nameKitc!));
  //           }
  //         }

  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => Launcher()));
  //       },
  //       padding: EdgeInsets.all(15),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  //       color: Colors.black,
  //       child: Text(
  //         'Done',
  //         style: TextStyle(
  //             color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSQLite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Kitchenware'),
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: RadialGradient(
            colors: [
              Color(0xffffffff),
              Color(0xffff8a65),
              Color(0xffe69a83),
            ],
            center: Alignment.topRight,
            radius: 3,
          ))),
        ),
        body: FilterListWidget<KitchenwareModel>(
            themeData: FilterListThemeData(context,
                choiceChipTheme: ChoiceChipThemeData(
                    selectedBackgroundColor: Palette.roseBud),
                controlButtonBarTheme: ControlButtonBarThemeData(
                    controlButtonTheme: ControlButtonThemeData(
                        primaryButtonBackgroundColor: Palette.roseBud,
                        textStyle: (TextStyle(color: Palette.roseBud))))),
            listData: kitchenwares,
            selectedListData: _selected,
            onApplyButtonClick: (list) {
              list!.forEach((element) {
                UserKitchHelper().insertDataToSQLite(UserKitchenwareModel(
                    uid: _auth.currentUser!.uid,
                    kitchenware: element.nameKitc));
              });
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Launcher()));
            },
            validateSelectedItem: (list, val) {
              return list!.contains(val);
            },
            choiceChipLabel: (item) {
              return item!.nameKitc;
            },
            onItemSearch: (list, query) {
              return list.nameKitc!.toLowerCase().contains(query.toLowerCase());
            }));
  }
}
