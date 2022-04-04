import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hewa/screen/profile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hewa/screen/profile/otherPeople.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share/share.dart';
import 'package:hewa/screen/comment.dart';
import 'package:like_button/like_button.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/utilities/menuRecipe_helper.dart';
import 'package:hewa/models/like_model.dart';
import 'package:hewa/utilities/like_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hewa/config/palette.dart';
import 'package:hewa/models/comment_model.dart';
import 'package:hewa/utilities/comment_helper.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/utilities/user_helper.dart';

class ActionsToolbar extends StatelessWidget {
  ActionsToolbar(this.menuRecipeModel);
  MenuRecipeModel menuRecipeModel;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLiked = false;
  late Future<List<LikeModel>> likes;
  late Future<List<CommentModel>> comments;
  Future<List<UserModel>>? userModel;
  Future<String>? url;
  getLike() {
    var objects = LikeHelper()
        .readDataFromSQLiteWhereRecipe(menuRecipeModel.id.toString());
    likes = objects;
  }

  getComment() {
    var objects = CommentHelper()
        .readDataFromSQLiteWhereRecipe(menuRecipeModel.id.toString());
    comments = objects;
  }

  getUserProfile() {
    var user =
        UserHelper().readDataFromSQLiteWhereId(menuRecipeModel.recipeUid!);
    userModel = user;
  }

  like() {
    if (isLiked == false) {
      LikeModel likeModel =
          LikeModel(recipeId: menuRecipeModel.id, uid: menuRecipeModel.uid);
      LikeHelper().insertDataToSQLite(likeModel);
      isLiked = true;
    } else {
      LikeHelper().deleteDataWhere(
          _auth.currentUser!.uid, menuRecipeModel.id.toString());
      isLiked = false;
    }
    print(isLiked);
  }

  getIsLike(List<LikeModel> likes) {
    String uid = _auth.currentUser!.uid;
    for (var like in likes) {
      if (uid == like.uid) {
        isLiked = true;
        break;
      }
    }
  }

  Widget _getSocialAction({required String title, required IconData icon}) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        width: 60,
        height: 60,
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
            ),
            Padding(
              padding: EdgeInsets.only(top: 2),
              child: Text(title, style: TextStyle(fontSize: 12)),
            )
          ],
        ));
  }

  Widget _getFollowAction(
      {required String pictureUrl, required BuildContext context}) {
    print(menuRecipeModel.recipeUid);
    print(_auth.currentUser!.uid);
    print(menuRecipeModel.userID == _auth.currentUser!.uid);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 60,
      height: 60,
      child: Stack(children: [
        _getProfilePicture(context, pictureUrl),
        menuRecipeModel.recipeUid != _auth.currentUser!.uid
            ? _getPlusIcon()
            : Container()
      ]),
    );
  }

  static const double ActionWidgetSize = 60;
  static const double ActionIconSize = 40;
  static const double ProfileImageSize = 50;
  static const double PlusIconSize = 20;

  Widget _getPlusIcon() {
    return Positioned(
      bottom: 0,
      left: ((ActionWidgetSize / 2) - (PlusIconSize / 2)),
      child: GestureDetector(
          onTap: () {
            print("eee");
          },
          child: Container(
            width: PlusIconSize,
            height: PlusIconSize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    colors: [Color(0xFFEC7063), Color(0xFFFFAB91)])),
            child: Icon(Icons.add, color: Colors.white, size: 20),
          )),
    );
  }

  Widget _getProfilePicture(BuildContext context, String url) {
    return Positioned(
        left: (ActionWidgetSize / 2) - (ProfileImageSize / 2),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return OtherProfile();
            }));
          },
          child: Container(
            padding: EdgeInsets.all(1.0),
            height: ProfileImageSize,
            width: ProfileImageSize,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ProfileImageSize / 2)),
            child: CachedNetworkImage(
              imageUrl: url,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) =>
                  new CircularProgressIndicator(color: Colors.blue),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
        ));
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    getLike();
    getComment();
    getUserProfile();
    return Container(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              FutureBuilder<List<UserModel>>(
                  future: userModel,
                  builder: (context, snapshot) {
                    List<Widget> children = [];
                    if (snapshot.hasData) {
                      if (snapshot.data![0].image != null) {
                        var ref = FirebaseStorage.instance
                            .ref()
                            .child('upload')
                            .child(snapshot.data![0].image!);
                        url = ref.getDownloadURL();
                        children = [
                          FutureBuilder<String>(
                              future: url,
                              builder: (context, snapshot) {
                                List<Widget> children = [];
                                if (snapshot.hasData) {
                                  children = [
                                    _getFollowAction(
                                        pictureUrl: snapshot.data!,
                                        context: context)
                                  ];
                                } else {
                                  children = [CircularProgressIndicator()];
                                }
                                return Column(
                                  children: children,
                                );
                              })
                        ];
                      }
                      children = [
                        _getFollowAction(
                            pictureUrl:
                                "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg",
                            context: context)
                      ];
                    } else {
                      children = [CircularProgressIndicator()];
                    }
                    return Column(
                      children: children,
                    );
                  }),
              FutureBuilder<List<LikeModel>>(
                  future: likes,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List<Widget> children = [];
                    if (snapshot.hasData) {
                      getIsLike(snapshot.data);
                      print(isLiked);
                      children = [
                        GestureDetector(
                            child: LikeButton(
                          onTap: (isLiked) {
                            return changedata(
                              isLiked,
                            );
                          },
                          countPostion: CountPostion.bottom,
                          size: 50,
                          circleColor: CircleColor(
                              start: Colors.black, end: Color(0xff0099cc)),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Color(0xff33b5e5),
                            dotSecondaryColor: Color(0xff0099cc),
                          ),
                          likeCount: snapshot.data.length,
                          likeCountAnimationType: LikeCountAnimationType.all,
                          likeBuilder: (bool isLike) {
                            isLike = isLiked;
                            print(isLike);
                            return Icon(
                              isLike ? MdiIcons.heart : MdiIcons.heartOutline,
                              color: isLike ? Palette.roseBud : Colors.black,
                              size: 50,
                            );
                          },
                          // countBuilder: (int count, bool isLiked, String text) {
                          //   var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                          //   Widget result;
                          //   if (count == 0) {
                          //     result = Text(
                          //       "love",
                          //       style: TextStyle(color: color),
                          //     );
                          //   } else
                          //     result = Text(
                          //       text,
                          //       style: TextStyle(color: color),
                          //     );
                          //   return result;
                          // },
                        ))
                      ];
                    } else {
                      children = [CircularProgressIndicator()];
                    }
                    return Column(children: children);
                  }),
              // RawMaterialButton(
              //   onPressed: () {},
              //   child: _getSocialAction(
              //     title: '15.2k',
              //     icon: MdiIcons.heartOutline,
              //   ),
              //   // onPressed: () async{
              //   //   if(menu.like.contains(user.uid))
              //   //     menu.like.remove(user.uid);
              //   //   else menu.like.add(user.uid);
              //   //   await DBServices().updatevehicule(menu);
              //   // },
              // ),
              FutureBuilder<List<CommentModel>>(
                  future: comments,
                  builder: (context, snapshot) {
                    List<Widget> children = <Widget>[];
                    if (snapshot.hasData) {
                      children = [
                        RawMaterialButton(
                          onPressed: () {
                            navigateTocommentPage(context, snapshot.data!);
                          },
                          child: _getSocialAction(
                              title: snapshot.data!.length.toString(),
                              icon: MdiIcons.messageOutline),
                        )
                      ];
                    } else {
                      children = [CircularProgressIndicator()];
                    }
                    return Column(children: children);
                  }),
              RawMaterialButton(
                  onPressed: _shareContent,
                  child: _getSocialAction(
                      title: 'Share', icon: MdiIcons.shareOutline)),
            ],
          ),
        ],
      ),
    );
  }
}

Future<bool> changedata(status) async {
  //your code
  print("eee");
  print(status);
  print(!status);
  // isLiked = !isLiked;
  return Future.value(!status);
}

navigateToProfilePage(BuildContext context) {}

void _shareContent() {
  Share.share('check out my website https://example.com',
      subject: 'Look what I made!');
}

void navigateTocommentPage(
    BuildContext context, List<CommentModel> comments) async {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: commentPage(comments)));
      });
  // Navigator.push(context, MaterialPageRoute(builder: (context) {
  //   return commentPage(comments);
  // }));
}
