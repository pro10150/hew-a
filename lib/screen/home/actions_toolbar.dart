import 'package:flutter/material.dart';
import 'package:hewa/screen/profile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hewa/screen/profile/otherPeople.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share/share.dart';
import 'package:hewa/screen/comment.dart';
import 'package:like_button/like_button.dart';


class actionsToolbar extends StatelessWidget {
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
      child: Stack(children: [_getProfilePicture(context), _getPlusIcon()]),
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
      child: Container(
        width: PlusIconSize,
        height: PlusIconSize,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient:
                LinearGradient(colors: [Color(0xFFEC7063), Color(0xFFFFAB91)])),
        child: Icon(Icons.add, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _getProfilePicture(BuildContext context) {
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
              imageUrl:
                  "https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7",
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
        ));
  }

  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end, 
        children: [
          Column(
            children: [
              _getFollowAction(
                  pictureUrl:
                      "https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7",
                  context: context),
              LikeButton(
              size: 50,
              circleColor:
                  CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Color(0xff33b5e5),
                dotSecondaryColor: Color(0xff0099cc),
              ),
              likeCount: 100,
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
          ),
          // RawMaterialButton(
          //   onPressed: () {},
          //   child: _getSocialAction(
          //     title: '15.2k' ,
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
              navigateTocommentPage(context);
            },
            child:
                _getSocialAction(title: '132', icon: MdiIcons.messageOutline),
          ),
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


// LikeButton(
//       onTap: onLikeButtonTapped,
//     ),
Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }

navigateToProfilePage(BuildContext context) {}

void _shareContent() {
  Share.share('check out my website https://example.com',
      subject: 'Look what I made!');
}

void navigateTocommentPage(BuildContext context) async {
  Future.delayed(const Duration(milliseconds: 500), () {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return commentPage();
    }));
  });
}
