import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'actions_toolbar.dart';
import 'recipe_description.dart';
import '../menu_detail/menu_detail.dart';
import 'package:hewa/models/menuRecipe_model.dart';

// ignore: must_be_immutable
class RecipeContent extends StatelessWidget {
  RecipeContent(this.menuRecipeModel) {
    ref = FirebaseStorage.instance
        .ref()
        .child('menus')
        .child(menuRecipeModel.menuImage! + '.jpeg');
    url = ref.getDownloadURL();
    print(ref);
  }
  var ref;
  var url;
  MenuRecipeModel menuRecipeModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: MenuDetail(),
                        type: PageTransitionType.leftToRight));
              },
              child: FutureBuilder<String>(
                  future: url,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    List<Widget> children = [];
                    if (snapshot.hasData) {
                      children = <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              snapshot.data!,
                              fit: BoxFit.cover,
                              height: 430,
                              width: 350,
                            ),
                            // decoration:
                            //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
                          ),
                        )
                      ];
                    } else {
                      children = <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator())
                              // decoration:
                              //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
                              ),
                        )
                      ];
                    }
                    return Column(children: children);
                  })),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              RecipeDescription(menuRecipeModel),
              actionsToolbar()
            ],
          )
        ],
      ),
    );
  }
}
