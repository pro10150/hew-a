import 'package:flutter/material.dart';
import 'recipe_content.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:hewa/models/menuRecipe_model.dart';

class Trending extends StatelessWidget {
  Trending(this.menuRecipeModels);
  List<MenuRecipeModel> menuRecipeModels;
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
            : CircularProgressIndicator());
  }
}
