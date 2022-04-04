import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:hewa/models/user_model.dart';
=======
>>>>>>> Stashed changes
import '../../models/like_model.dart';
import '../../utilities/like_helper.dart';
import 'recipe_content.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:hewa/models/menuRecipe_model.dart';
<<<<<<< Updated upstream
import 'package:hewa/models/user_model.dart';

class Trending extends StatelessWidget {
  Trending(this.menuRecipeModels, this.userModel) {
=======

class Trending extends StatelessWidget {
  Trending(this.menuRecipeModels) {
>>>>>>> Stashed changes
    for (var object in menuRecipeModels) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('menus')
          .child(object.menuImage! + '.jpeg');
      refs.add(ref.getDownloadURL());
    }
  }

  getLike(String id) async {
    return await LikeHelper().readDataFromSQLiteWhereRecipe(id);
  }

  List<List<LikeModel>> likes = [];
  List<dynamic> refs = [];
  List<MenuRecipeModel> menuRecipeModels = [];
<<<<<<< Updated upstream
  UserModel userModel;
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                  return RecipeContent(
                      menuRecipeModels[index], refs[index], userModel);
=======
                  return RecipeContent(menuRecipeModels[index], refs[index]);
>>>>>>> Stashed changes
                },
              )
            : CircularProgressIndicator());
  }
}
