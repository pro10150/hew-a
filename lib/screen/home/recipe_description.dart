import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import '../menu_detail/menu_detail.dart';
import 'package:hewa/models/menuRecipe_model.dart';

class RecipeDescription extends StatelessWidget {
  RecipeDescription(this.menuRecipeModel);
  MenuRecipeModel menuRecipeModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: MenuDetail(), type: PageTransitionType.rightToLeft));
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, top: 450),
              child: (Text(
                'คุณต้องซื้อวัตถุดิบเพิ่มเติม',
                style: TextStyle(fontSize: 14),
              )),
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
                  menuRecipeModel.timeMinute != null
                      ? Icon(MdiIcons.clockOutline, size: 25)
                      : Container(),
                  menuRecipeModel.timeMinute != null
                      ? Text(menuRecipeModel.timeMinute.toString() + 'min')
                      : Container(),
                  Icon(MdiIcons.pigVariantOutline),
                  Text(menuRecipeModel.name.toString())
                ],
              ),
            ),
          ]),
    ));
  }
}
