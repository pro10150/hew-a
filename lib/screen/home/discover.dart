import 'package:flutter/material.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'recipe_content.dart';
import 'package:hewa/models/menuRecipe_model.dart';

class Discover extends StatelessWidget {
  Discover(this.menuRecipeModels);
  List<MenuRecipeModel> menuRecipeModels;

  void _handleCallbackEvent(ScrollEventType type, {required int currentIndex}) {
    print(
        "Scroll callback received with data: {type: $type, and index: $currentIndex}");
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        // wrap in Expanded
        child: menuRecipeModels.length > 0
            ? TikTokStyleFullPageScroller(
                contentSize: menuRecipeModels.length,
                swipePositionThreshold: 0.2,
                swipeVelocityThreshold: 1000,
                animationDuration: const Duration(milliseconds: 300),
                builder: (BuildContext context, int index) {
                  return RecipeContent(menuRecipeModels[index]);
                },
              )
            : Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('You haven\' followed anyone yet.'),
                    Text('Why don\'t you started by following someone.')
                  ],
                )));
  }
}
