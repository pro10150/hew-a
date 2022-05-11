import 'package:flutter/material.dart';
import 'package:hewa/models/menu_model.dart';
import 'package:hewa/utilities/menu.helper.dart';
import 'package:page_transition/page_transition.dart';
import 'recipe_step_1.dart';
import 'new_menu.dart';
import 'package:searchfield/searchfield.dart';

class ExistingMenu extends StatefulWidget {
  @override
  _ExistingMenuState createState() => _ExistingMenuState();
}

class _ExistingMenuState extends State<ExistingMenu> {
  late TextEditingController _controller;
  List<MenuModel> menuModels = [];
  List<String> menus = [];
  MenuModel? selectedMenuModel;
  String? selectedMenu;

  getMenu() async {
    var objects = await MenuHelper().readlDataFromSQLite();
    setState(() {
      menuModels = objects;
      for (var object in objects) {
        menus.add(object.nameMenu!);
      }
    });
  }

  void initState() {
    super.initState();
    _controller = TextEditingController();
    getMenu();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffab91),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(
                top: 50,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      BackButton(),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Select Existing menu',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.all(20),
                      child: Form(
                          child: Column(
                        children: [
                          Form(
                              child: SearchField(
                            suggestions: menus
                                .map((e) => SearchFieldListItem(e))
                                .toList(),
                            suggestionState: Suggestion.expand,
                            textInputAction: TextInputAction.next,
                            hint: 'Enter menu',
                            hasOverlay: false,
                            searchStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.8),
                            ),
                            validator: (x) {
                              if (!menus.contains(x) || x!.isEmpty) {
                                print("yee");
                                return 'Please Enter a valid State';
                              }
                              print("looool");
                              return null;
                            },
                            searchInputDecoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            maxSuggestionsInViewPort: 6,
                            itemHeight: 50,
                            onSuggestionTap: (x) {
                              var menuModel = menuModels
                                  .where((element) =>
                                      element.nameMenu == x.searchKey)
                                  .first;
                              setState(() {
                                selectedMenuModel = menuModel;
                              });
                            },
                            onSubmit: (x) {
                              var menuModel = menuModels
                                  .where((element) => element.nameMenu == x)
                                  .first;
                              setState(() {
                                selectedMenuModel = menuModel;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RecipeStep1(menuModel)));
                              // Navigator.push(
                              //     context,
                              //     PageTransition(
                              //         child: RecipeStep1(menuModel),
                              //         type: PageTransitionType.rightToLeft));
                            },
                          )),
                          TextButton(
                              onPressed: () {
                                if (selectedMenuModel != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecipeStep1(selectedMenuModel!)));
                                }
                                // Navigator.push(
                                //     context,
                                //     PageTransition(
                                //         child: RecipeStep1(selectedMenuModel!),
                                //         type: PageTransitionType.rightToLeft));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Colors.black)))),
                              child: Text(
                                "Next",
                                style: TextStyle(color: Colors.black),
                              )),
                          Text("Or"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: NewMenu(),
                                        type: PageTransitionType.rightToLeft));
                              },
                              child: Text(
                                "Create new menu",
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      )))
                ],
              )),
        ));
  }
}
