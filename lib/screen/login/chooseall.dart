import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hewa/config/palette.dart';
import 'package:hewa/screen/fridge/ingredients.dart';
import 'package:hewa/screen/login/allergies.dart';
// import 'regsrceen.dart';
// import 'allergies.dart';
import 'choosekit.dart';
import 'package:hewa/utilities/ingred_helper.dart';
import 'package:hewa/models/ingred_model.dart';
import 'package:hewa/models/reAllergy_model.dart';
import 'package:hewa/utilities/reAllergy_helper.dart';
import 'package:filter_list/filter_list.dart';

class Chooseallergies extends StatefulWidget {
  @override
  ChooseallergiesState createState() => ChooseallergiesState();
}

class ChooseallergiesState extends State<Chooseallergies> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Widget buildallergiesBtn(int index) {
  //   return FilterListWidget<Ingredients>(
  //     listData: ingredients,
  //     validateSelectedItem: validateSelectedItem,
  //     choiceChipLabel: choiceChipLabel,
  //     onItemSearch: onItemSearch
  //     );

  //   Container(
  //       padding: EdgeInsets.all(10),
  //       child: TextButton(
  //         onPressed: () {
  //           setState(() {
  //             _selected[index] = !_selected[index];
  //           });
  //         },
  //         child: Text(
  //           ingredients[index].name!,
  //           textAlign: TextAlign.center,
  //         ),
  //         style: ButtonStyle(
  //             foregroundColor: _selected[index] == false
  //                 ? MaterialStateProperty.all<Color>(Colors.black)
  //                 : MaterialStateProperty.all<Color>(Colors.white),
  //             backgroundColor: _selected[index] == false
  //                 ? MaterialStateProperty.all<Color>(Colors.white)
  //                 : MaterialStateProperty.all<Color>(Colors.red),
  //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                 RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(18.0),
  //                     side: BorderSide(color: Colors.red)))),
  //       ));
  // }

  // Widget buildnextBtn() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 20),
  //     child: RaisedButton(
  //       elevation: 5,
  //       onPressed: () {
  //         for (var i = 0; i < _selected.length; i++) {
  //           if (_selected[i] == true) {
  //             ReAllergyHelper().insertDataToSQLite(ReAllergyModel(
  //                 allID: ingredients[i].id, userID: _auth.currentUser!.uid));
  //           }
  //         }
  //         var rount = new MaterialPageRoute(
  //             builder: (BuildContext context) => new Choosekitchenware());
  //         Navigator.of(context).push(rount);
  //       },
  //       padding: EdgeInsets.all(15),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  //       color: Colors.black,
  //       child: Text(
  //         'Next',
  //         style: TextStyle(
  //             color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //   );
  // }

  List<IngredModel> ingredients = [];
  List<IngredModel> _selected = [];
  void readSQLite() {
    IngredHelper().readlDataFromSQLite().then((value) {
      for (var model in value) {
        ingredients.add(model);
      }
      setState(() {});
    });
  }

  void deleteData() {
    ReAllergyHelper().deleteDataWhereUser(_auth.currentUser!.uid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deleteData();
    readSQLite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Allergies'),
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
        body: FilterListWidget<IngredModel>(
            themeData: FilterListThemeData(context,
                choiceChipTheme: ChoiceChipThemeData(
                    selectedBackgroundColor: Palette.roseBud),
                controlButtonBarTheme: ControlButtonBarThemeData(
                    controlButtonTheme: ControlButtonThemeData(
                        primaryButtonBackgroundColor: Palette.roseBud,
                        textStyle: (TextStyle(color: Palette.roseBud))))),
            listData: ingredients,
            selectedListData: _selected,
            onApplyButtonClick: (list) {
              list!.forEach((element) {
                ReAllergyHelper().insertDataToSQLite(ReAllergyModel(
                    allID: element.id, userID: _auth.currentUser!.uid));
                var rount = new MaterialPageRoute(
                    builder: (BuildContext context) => new Choosekitchenware());
                Navigator.of(context).push(rount);
              });
            },
            validateSelectedItem: (list, val) {
              return list!.contains(val);
            },
            choiceChipLabel: (item) {
              return item!.name;
            },
            onItemSearch: (list, query) {
              return list.name!.toLowerCase().contains(query.toLowerCase());
            }));
  }
}
