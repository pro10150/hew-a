import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hewa/models/follow_model.dart';
import 'package:hewa/utilities/follow_helper.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import '../../models/like_model.dart';
import '../../utilities/like_helper.dart';
import 'recipe_content.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/utilities/user_helper.dart';

class Following extends StatefulWidget {
  Following(this.menuRecipeModels, this.userModel, this.recommendedUserModels);
  List<MenuRecipeModel> menuRecipeModels = [];
  UserModel userModel;
  List<UserModel> recommendedUserModels = [];
  @override
  _FollowingState createState() =>
      _FollowingState(menuRecipeModels, userModel, recommendedUserModels);
}

class _FollowingState extends State<Following> {
  _FollowingState(
      this.menuRecipeModels, this.userModel, this.recommendedUserModels);

  getLike(String id) async {
    return await LikeHelper().readDataFromSQLiteWhereRecipe(id);
  }

  getUrl() {
    Future.delayed(Duration(milliseconds: 50), () {});
    return Future.value(
        "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg");
  }

  follow(int index) {
    FollowModel followModel = FollowModel(
        uid: recommendedUserModels[index].uid,
        followedUserID: _auth.currentUser!.uid);
    FollowHelper().insertDataToSQLite(followModel);
  }

  unfollow(index) {
    FollowHelper().deleteDataWhereUidAndFollow(
        recommendedUserModels[index].uid!, _auth.currentUser!.uid);
  }

  getMenuUrl() async {
    for (var object in menuRecipeModels) {
      print(object);
      var ref = FirebaseStorage.instance
          .ref()
          .child('menus')
          .child(object.menuImage!);
      print(ref);
      setState(() {
        refs.add(ref.getDownloadURL());
      });
    }
    print("yeeeeeeeeeeeeeeeeeeeeeeeee");
    for (var object in recommendedUserModels) {
      if (object.image != null) {
        var ref =
            FirebaseStorage.instance.ref().child('upload').child(object.image!);
        recommendedUrls.add(ref.getDownloadURL());
      } else {
        recommendedUrls.add(getUrl());
      }
    }
  }

  List<List<LikeModel>> likes = [];
  List<dynamic> refs = [];
  List<MenuRecipeModel> menuRecipeModels = [];
  UserModel userModel;
  List<UserModel> recommendedUserModels = [];
  List<Future<String>> recommendedUrls = [];
  List<bool> isFollowed = [false, false, false, false, false, false];
  var _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("object");
    // getMenuUrl();
  }

  @override
  Widget build(BuildContext context) {
    print("following");
    print(recommendedUserModels.length);
    print(recommendedUrls.length);
    print(menuRecipeModels.length);
    print(refs.length);
    if (menuRecipeModels.length > 0) {
      getMenuUrl();
    }
    return menuRecipeModels.length > 0
        ? Expanded(
            // wrap in Expanded
            child: TikTokStyleFullPageScroller(
            contentSize: menuRecipeModels.length,
            swipePositionThreshold: 0.2,
            swipeVelocityThreshold: 1000,
            animationDuration: const Duration(milliseconds: 200),
            builder: (BuildContext context, int index) {
              return RecipeContent(
                  menuRecipeModels[index], refs[index], userModel);
            },
          ))
        : Column(children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "You haven't followed anyone yet. \nTry following these users.",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
                child: Container(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300.0,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                itemCount: recommendedUserModels.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      FutureBuilder<String>(
                          future: recommendedUrls[index],
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey,
                                child: ClipOval(
                                  child: SizedBox(
                                      height: 500,
                                      width: 500,
                                      child: Image.network(
                                        snapshot.data!,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                      recommendedUserModels[index].name != null
                          ? Text(recommendedUserModels[index].name!)
                          : Text(recommendedUserModels[index].username!),
                      isFollowed[index] != false
                          ? TextButton(
                              onPressed: () {
                                setState(() {
                                  isFollowed[index] = false;
                                });
                                unfollow(index);
                              },
                              child: Text(
                                "Unfollow",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                )),
                              ))
                          : TextButton(
                              onPressed: () {
                                setState(() {
                                  isFollowed[index] = true;
                                });
                                follow(index);
                              },
                              child: Text(
                                "Follow",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                )),
                              ))
                    ],
                  );
                },
              ),
            ))
          ]);
  }
}
