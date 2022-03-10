import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'recipe_content.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:hewa/models/like_model.dart';
import 'package:hewa/utilities/like_helper.dart';

class DailyPick extends StatelessWidget {
  DailyPick(this.menuRecipeModels) {
    for (var object in menuRecipeModels) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('menus')
          .child(object.menuImage! + '.jpeg');
      refs.add(ref.getDownloadURL());
    }
  }

  getLike(String id) async {
    print(LikeHelper().readDataFromSQLiteWhereRecipe(id).runtimeType);
    return await LikeHelper().readDataFromSQLiteWhereRecipe(id);
  }

  List<List<LikeModel>> likes = [];
  List<dynamic> refs = [];
  List<MenuRecipeModel> menuRecipeModels = [];
  @override
  Widget build(BuildContext context) {
    for (var object in likes) {
      print(object.runtimeType);
    }
    return Expanded(
        // wrap in Expanded
        child: menuRecipeModels.length > 0
            ? TikTokStyleFullPageScroller(
                contentSize: menuRecipeModels.length,
                swipePositionThreshold: 0.2,
                swipeVelocityThreshold: 1000,
                animationDuration: const Duration(milliseconds: 300),
                builder: (BuildContext context, int index) {
                  return RecipeContent(menuRecipeModels[index], refs[index]);
                },
              )
            : CircularProgressIndicator());
  }
}
