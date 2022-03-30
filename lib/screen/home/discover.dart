import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import '../../models/like_model.dart';
import '../../utilities/like_helper.dart';
import 'recipe_content.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/models/user_model.dart';

class Following extends StatelessWidget {
  Following(this.menuRecipeModels, this.userModel) {
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
                  return RecipeContent(
                      menuRecipeModels[index], refs[index], userModel);
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
