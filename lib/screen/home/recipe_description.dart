import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import '../menu_detail/menu_detail.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/config/ingredients_icon.dart';
import 'package:hewa/config/my_flutter_app_icons.dart';

class RecipeDescription extends StatelessWidget {
  RecipeDescription(this.menuRecipeModel, this.userModel);
  MenuRecipeModel menuRecipeModel;
  UserModel userModel;
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
              margin: EdgeInsets.only(left: 10, top: 450),
              child: (userModel.ingredients == 1
                  ? Text(
                      'คุณต้องซื้อวัตถุดิบเพิ่มเติม',
                      style: TextStyle(fontSize: 14),
                    )
                  : Container()),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                menuRecipeModel.nameMenu!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
            ),
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
