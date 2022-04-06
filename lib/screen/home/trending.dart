import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hewa/models/user_model.dart';
import '../../models/like_model.dart';
import '../../utilities/like_helper.dart';
import 'recipe_content.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/models/user_model.dart';

class Trending extends StatelessWidget {
  Trending(this.menuRecipeModels, this.userModel) {
    for (var object in menuRecipeModels) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('menus')
          .child(object.menuImage!);
      refs.add(ref.getDownloadURL());
    }
  }

  getLike(String id) async {
    return await LikeHelper().readDataFromSQLiteWhereRecipe(id);
  }

  List<List<LikeModel>> likes = [];
  List<dynamic> refs = [];
  List<MenuRecipeModel> menuRecipeModels = [];
  UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        // wrap in Expanded
        child: menuRecipeModels.length > 0
            ? TikTokStyleFullPageScroller(
                contentSize: menuRecipeModels.length,
                builder: (BuildContext context, int index) {
                  return RecipeContent(
                      menuRecipeModels[index], refs[index], userModel);
                },
              )
            : CircularProgressIndicator());
  }
}
