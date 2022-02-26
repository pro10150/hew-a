import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'actions_toolbar.dart';
import 'recipe_description.dart';
import '../menu_detail/menu_detail.dart';

class recipeContent extends StatelessWidget {
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
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    image: AssetImage('lib/assets/home/food.png'),
                    fit: BoxFit.cover,
                    height: 430,
                    width: 350,
                  ),
                  // decoration:
                  //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
                ),
              )),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[recipeDescription(), actionsToolbar()],
          )
        ],
      ),
    );
  }
}
