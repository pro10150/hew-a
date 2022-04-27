import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import '../menu_detail/menu_detail.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/models/reIngredIngred_model.dart';
import 'package:hewa/models/userIngred_model.dart';
import 'package:hewa/utilities/reIngredIngred_helper.dart';
import 'package:hewa/utilities/userIngred_helper.dart';
import 'package:hewa/config/ingredients_icon.dart';
import 'package:hewa/config/my_flutter_app_icons.dart';
import 'package:hewa/config/adaptive_text_size.dart';

class RecipeDescription extends StatelessWidget {
  RecipeDescription(this.menuRecipeModel, this.userModel) {
    reIngredIngredModels = ReIngredIngredHelper()
        .readDataFromSQLiteWhereRecipeId(menuRecipeModel.id.toString());
    userIngredModels =
        UserIngredHelper().readDataFromSQLiteWhereUser(_auth.currentUser!.uid);
  }
  var _auth = FirebaseAuth.instance;
  MenuRecipeModel menuRecipeModel;
  UserModel userModel;
  Future<List<ReIngredIngredModel>>? reIngredIngredModels;
  Future<List<UserIngredModel>>? userIngredModels;
  int isHave = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: MenuDetail(menuRecipeModel),
                type: PageTransitionType.rightToLeft));
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  left: 10, top: MediaQuery.of(context).size.height * 0.5),
              // child: FutureBuilder<List<ReIngredIngredModel>>(
              //     future: reIngredIngredModels,
              //     builder: (context, snapshot) {
              //       return FutureBuilder<List<UserIngredModel>>(
              //           future: userIngredModels,
              //           builder: (context, userSnapshot) {
              //             if (snapshot.hasData) {
              //               for (var target in snapshot.data!) {
              //                 for (var object in userSnapshot.data!) {
              //                   if (target.id == object.ingredientId) {
              //                     isHave++;
              //                     break;
              //                   }
              //                 }
              //               }
              //               return isHave < snapshot.data!.length
              //                   ? Text(
              //                       'คุณต้องซื้อวัตถุดิบเพิ่มเติม',
              //                       style: TextStyle(
              //                           fontSize: AdaptiveTextSize()
              //                               .getadaptiveTextSize(
              //                                   context, 14)),
              //                     )
              //                   : Container();
              //             } else {
              //               return Container();
              //             }
              //           });
              //     })
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                menuRecipeModel.nameMenu!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:
                        AdaptiveTextSize().getadaptiveTextSize(context, 36)),
              ),
            ),
            menuRecipeModel.recipeName != null
                ? Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      menuRecipeModel.recipeName!,
                      style: TextStyle(
                          fontSize: AdaptiveTextSize()
                              .getadaptiveTextSize(context, 20)),
                    ),
                  )
                : Container(),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(MdiIcons.clockOutline, size: 25),
                  menuRecipeModel.timeMinute != null
                      ? Text(menuRecipeModel.timeMinute.toString() + ' min')
                      : Text('N/A'),
                  Icon(
                    IngredientsIcon.ingredients,
                    size: 40,
                  ),
                  Text(menuRecipeModel.name.toString())
                ],
              ),
            ),
          ]),
    ));
  }
}
