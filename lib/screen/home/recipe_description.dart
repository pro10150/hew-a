import 'package:flutter/material.dart';
import 'package:hewa/models/Recipe_model.dart';
import 'package:hewa/models/ingred_model.dart';
import 'package:hewa/utilities/recipe_helper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import '../menu_detail/menu_detail.dart';
import 'package:hewa/utilities/menu.helper.dart';
import 'package:hewa/models/menu_model.dart';
import 'package:hewa/utilities/ingred_helper.dart';

class recipeDescription extends StatefulWidget {
  @override
  recipeDescriptionPageState createState() => recipeDescriptionPageState();
}

// Future<Future<List<MenuModel>>> getMenu() async {
//   var _MenuHelp = MenuHelper();
//   Future<List<MenuModel>> Menus = _MenuHelp.readlDataFromSQLite();
//   return Menus;
// }

class recipeDescriptionPageState extends State<recipeDescription> {
  List<MenuModel> menu = [];
  Future<String?> getMenu() async {
    MenuHelper().readlDataFromSQLite().then((value) {
      menu = value;
      setState(() {});
    });
  }

  List<RecipeModel> recipee = [];
  Future<String?> getRecipe() async {
    RecipeHelper().readlDataFromSQLite().then((time) => {setState(() {})});
  }

  @override
  void initState() {
    super.initState();
    getMenu();
    getRecipe();
  }

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
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                menu.isNotEmpty == true
                    ? menu[0].nameMenu != null
                        ? '${menu[0].nameMenu}'
                        : '${menu[0].nameMenu}'
                    : 'nameMenu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Icon(MdiIcons.clockOutline, size: 25),
                  Text(recipee.isNotEmpty == true
                      ? recipee[0].timeMinute != null
                          ? '${recipee[0].timeMinute}'
                          : '${recipee[0].timeMinute}'
                      : 'N/A'),
                  Icon(MdiIcons.pigVariantOutline),
                  Text(menu.isNotEmpty == true
                      ? menu[0].mainIngredient != null
                          ? '${menu[0].mainIngredient}'
                          : '${menu[0].mainIngredient}'
                      : 'N/A')
                ],
              ),
            ),
          ]),
    ));
  }
}
