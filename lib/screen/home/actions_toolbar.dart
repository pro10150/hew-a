import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hewa/screen/menu_detail/menu_detail.dart';
import 'package:hewa/screen/profile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hewa/screen/profile/otherPeople.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hewa/screen/comment.dart';
import 'report.dart';
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
import 'package:hewa/models/user_model.dart';
import 'package:hewa/models/follow_model.dart';
import 'package:hewa/utilities/follow_helper.dart';

class ActionsToolbar extends StatefulWidget {
  ActionsToolbar(this.menuRecipeModel, this.userModel);
  MenuRecipeModel menuRecipeModel;
  UserModel userModel;
  @override
  _ActionsToolbarState createState() =>
      _ActionsToolbarState(menuRecipeModel, userModel);
}

class _ActionsToolbarState extends State<ActionsToolbar> {
  _ActionsToolbarState(this.menuRecipeModel, this.userModel);
  MenuRecipeModel menuRecipeModel;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLiked = false;
  bool isFollowed = false;
  List<LikeModel> likes = [];
  List<CommentModel> commentModels = [];
  Future<List<UserModel>>? userModels;
  List<FollowModel> followModels = [];
  UserModel userModel;
  Future<String>? url;

  getFollow() async {
    var objects = await FollowHelper().getFollower(menuRecipeModel.recipeUid!);
    for (var object in objects) {
      setState(() {
        followModels.add(object);
        if (object.followedUserID == _auth.currentUser!.uid) {
          isFollowed = true;
        }
      });
    }
  }

  getLike() async {
    var objects = await LikeHelper()
        .readDataFromSQLiteWhereRecipe(menuRecipeModel.id.toString());
    setState(() {
      likes = objects;
    });
    getIsLike(likes);
  }

  getComment() async {
    var objects = await CommentHelper()
        .readDataFromSQLiteWhereRecipe(menuRecipeModel.id.toString());
    commentModels = objects;
  }

  getUserProfile() {
    var user =
        UserHelper().readDataFromSQLiteWhereId(menuRecipeModel.recipeUid!);
    userModels = user;
  }

  like() {
    LikeModel likeModel = LikeModel(
        recipeId: menuRecipeModel.id,
        uid: _auth.currentUser!.uid,
        datetime: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
    if (isLiked == false) {
      LikeHelper().insertDataToSQLite(likeModel);
      isLiked = true;
      setState(() {
        likes.add(likeModel);
      });
    } else {
      LikeHelper().deleteDataWhere(
          _auth.currentUser!.uid, menuRecipeModel.id.toString());
      isLiked = false;
      setState(() {
        likes.removeAt(likes.length - 1);
      });
    }
    print(isLiked);
  }

  getIsLike(List<LikeModel> likes) {
    String uid = _auth.currentUser!.uid;
    for (var like in likes) {
      if (uid == like.uid) {
        setState(() {
          isLiked = true;
        });
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 60,
      height: 60,
      child: Stack(children: [
        _getProfilePicture(context, pictureUrl),
        menuRecipeModel.recipeUid != _auth.currentUser!.uid
            ? isFollowed
                ? Container()
                : _getPlusIcon()
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
            FollowModel followModel = FollowModel(
                uid: menuRecipeModel.recipeUid,
                followedUserID: _auth.currentUser!.uid);
            FollowHelper().insertDataToSQLite(followModel);
            setState(() {
              print("followed");
              followModels.add(followModel);
              isFollowed = true;
            });
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
              return OtherProfile(url, menuRecipeModel.recipeUid!);
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getLike();
    getComment();
    getFollow();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              FutureBuilder<List<UserModel>>(
                  future: userModels,
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
                              builder: (context, urlSnapshot) {
                                List<Widget> children = [];
                                if (urlSnapshot.hasData) {
                                  children = [
                                    _getFollowAction(
                                        pictureUrl: urlSnapshot.data!,
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
                      } else {
                        children = [
                          _getFollowAction(
                              pictureUrl:
                                  "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg",
                              context: context)
                        ];
                      }
                    } else {
                      children = [CircularProgressIndicator()];
                    }
                    return Column(
                      children: children,
                    );
                  }),
              GestureDetector(
                  onTap: () {
                    like();
                  },
                  child: Column(children: [
                    Icon(
                      isLiked ? MdiIcons.heart : MdiIcons.heartOutline,
                      color: isLiked ? Palette.roseBud : Colors.black,
                      size: 50,
                    ),
                    Text(likes.length.toString())
                  ])),
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
              RawMaterialButton(
                onPressed: () {
                  navigateTocommentPage(context, commentModels);
                },
                child: _getSocialAction(
                    title: commentModels.length.toString(),
                    icon: MdiIcons.messageOutline),
              ),
              RawMaterialButton(
                  onPressed: () {
                    _shareContent(context, userModel, menuRecipeModel);
                  },
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

void _shareContent(BuildContext context, UserModel userModel,
    MenuRecipeModel menuRecipeModel) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setModalState /*You can rename this!*/) {
          return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text("Menu",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Container(
                margin: EdgeInsets.only(top: 30, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.facebook,
                          size: 50,
                        ),
                        label: Container()),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          FontAwesomeIcons.instagram,
                          size: 50,
                        ),
                        label: Container()),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          FontAwesomeIcons.twitter,
                          size: 50,
                        ),
                        label: Container()),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(FontAwesomeIcons.twitch, size: 50),
                        label: Container()),
                  ],
                )),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(children: [
                  MaterialButton(
                    onPressed: () {
                      print(userModel.username);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ReportPage(userModel, menuRecipeModel)),
                      );
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Icon(
                      Icons.flag,
                      size: 24,
                    ),
                    padding: EdgeInsets.all(16),
                    shape: CircleBorder(),
                  ),
                  Text("Report")
                ]),
                Column(children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.pink,
                    textColor: Colors.white,
                    child: Icon(
                      FontAwesomeIcons.heartBroken,
                      size: 24,
                    ),
                    padding: EdgeInsets.all(16),
                    shape: CircleBorder(),
                  ),
                  Text("Not Interested")
                ])
              ]),
            ),
          ]);
        });
      });
  // Share.share('check out my website https://example.com',
  //     subject: 'Look what I made!');
}

void navigateTocommentPage(
    BuildContext context, List<CommentModel> commentModels) async {
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
              child: commentPage(commentModels)));
    },
  );

  // Navigator.push(context, MaterialPageRoute(builder: (context) {
  //   return commentPage(commentModels);
  // }));
}
