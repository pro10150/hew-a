import 'package:comment_box/comment/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hewa/config/palette.dart';
import 'package:hewa/models/comment_model.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/utilities/comment_helper.dart';
import 'package:hewa/utilities/user_helper.dart';
import 'package:intl/intl.dart';

class commentPage extends StatefulWidget {
  commentPage(this.objects, this.menuRecipeModel);
  MenuRecipeModel menuRecipeModel;
  List<CommentModel> objects;
  @override
  _commentPage createState() => _commentPage(objects, menuRecipeModel);
}

class _commentPage extends State<commentPage> {
  _commentPage(this.comments, this.menuRecipeModel);
  MenuRecipeModel menuRecipeModel;
  List<CommentModel> comments;
  List<UserModel> users = [];
  UserModel? currentUser;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  var _auth = FirebaseAuth.instance;
  getUser() async {
    for (var comment in comments) {
      var object = await UserHelper().readDataFromSQLiteWhereId(comment.uid!);
      setState(() {
        users.add(object[0]);
      });
    }
    var object =
        await UserHelper().readDataFromSQLiteWhereId(_auth.currentUser!.uid);
    setState(() {
      currentUser = object.first;
    });
  }

  Widget commentChild(data) {
    List<Widget> children = [];
    return ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          var url;
          if (users[index].image != null) {
            var ref = FirebaseStorage.instance
                .ref()
                .child('upload')
                .child(users[index].image!);
            url = ref.getDownloadURL();
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: url != null
                      ? FutureBuilder<String>(
                          future: url,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage(snapshot.data!));
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg")),
                ),
              ),
              title: Text(
                users[index].name != null || users[index].name == ""
                    ? users[index].name!
                    : users[index].username!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(comments[index].text!),
            ),
          );
        });
    // for (var index = 0; index < comments.length; index++) {
    //   var url;
    //   if (users[index].image != null) {
    //     var ref = FirebaseStorage.instance
    //         .ref()
    //         .child('upload')
    //         .child(users[index].image!);
    //     url = ref.getDownloadURL();
    //   }
    //   children.add(Padding(
    //     padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
    //     child: ListTile(
    //       leading: GestureDetector(
    //         onTap: () async {
    //           // Display the image in large form.
    //           print("Comment Clicked");
    //         },
    //         child: Container(
    //           height: 50.0,
    //           width: 50.0,
    //           decoration: new BoxDecoration(
    //               borderRadius: new BorderRadius.all(Radius.circular(50))),
    //           child: url != null
    //               ? FutureBuilder<String>(
    //                   future: url,
    //                   builder: (context, snapshot) {
    //                     if (snapshot.hasData) {
    //                       return CircleAvatar(
    //                           radius: 50,
    //                           backgroundImage: NetworkImage(snapshot.data!));
    //                     } else {
    //                       return CircularProgressIndicator();
    //                     }
    //                   },
    //                 )
    //               : CircleAvatar(
    //                   radius: 50,
    //                   backgroundImage: NetworkImage(
    //                       "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg")),
    //         ),
    //       ),
    //       title: Text(
    //         users[index].name != null || users[index].name == ""
    //             ? users[index].name!
    //             : users[index].username!,
    //         style: TextStyle(fontWeight: FontWeight.bold),
    //       ),
    //       subtitle: Text(comments[index].text!),
    //     ),
    //   ));
    // }
    // return ListView(children: children);
    // return ListView.builder(
    //     itemCount: data.length,
    //     itemBuilder: (context, index) {
    //       var url;
    //       if (users[index].image != null) {
    //         var ref = FirebaseStorage.instance
    //             .ref()
    //             .child('upload')
    //             .child(users[index].image!);
    //         url = ref.getDownloadURL();
    //       }

    //       return Padding(
    //         padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
    //         child: ListTile(
    //           leading: GestureDetector(
    //             onTap: () async {
    //               // Display the image in large form.
    //               print("Comment Clicked");
    //             },
    //             child: Container(
    //               height: 50.0,
    //               width: 50.0,
    //               decoration: new BoxDecoration(
    //                   borderRadius: new BorderRadius.all(Radius.circular(50))),
    //               child: url != null
    //                   ? FutureBuilder<String>(
    //                       future: url,
    //                       builder: (context, snapshot) {
    //                         if (snapshot.hasData) {
    //                           return CircleAvatar(
    //                               radius: 50,
    //                               backgroundImage:
    //                                   NetworkImage(snapshot.data!));
    //                         } else {
    //                           return CircularProgressIndicator();
    //                         }
    //                       },
    //                     )
    //                   : CircleAvatar(
    //                       radius: 50,
    //                       backgroundImage: NetworkImage(
    //                           "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg")),
    //             ),
    //           ),
    //           title: Text(
    //             users[index].name != null || users[index].name == ""
    //                 ? users[index].name!
    //                 : users[index].username!,
    //             style: TextStyle(fontWeight: FontWeight.bold),
    //           ),
    //           subtitle: Text(comments[index].text!),
    //         ),
    //       );
    //     });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var currentUserUrl;
    print(menuRecipeModel.id);
    if (currentUser!.image != null) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('upload')
          .child(currentUser!.image!);
      currentUserUrl = ref.getDownloadURL();
    }
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Comment"),
            backgroundColor: Color(
              0xFFFFAB91,
            ),
            automaticallyImplyLeading: false,
          ),
          body: Container(
            child: currentUserUrl != null
                ? FutureBuilder<String>(
                    future: currentUserUrl,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CommentBox(
                          userImage: snapshot.data,
                          child: commentChild(comments),
                          labelText: 'Write a comment...',
                          withBorder: false,
                          errorText: 'Comment cannot be blank',
                          sendButtonMethod: () {
                            if (formKey.currentState!.validate()) {
                              print(commentController.text);
                              setState(() {
                                var value = CommentModel(
                                    text: commentController.text,
                                    uid: _auth.currentUser!.uid,
                                    recipeId: menuRecipeModel.id,
                                    date: DateFormat('yyyy-MM-dd HH:mm:ss')
                                        .format(DateTime.now()));
                                CommentHelper().insertDataToSQLite(value);
                                comments.add(value);
                                users.add(currentUser!);
                              });
                              commentController.clear();
                              FocusScope.of(context).unfocus();
                            } else {
                              print("Not validated");
                            }
                          },
                          formKey: formKey,
                          commentController: commentController,
                          backgroundColor: Colors.grey[200],
                          textColor: Colors.black,
                          sendWidget: Icon(Icons.send_sharp,
                              size: 30, color: Palette.roseBud),
                        );
                      } else {
                        return Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        );
                      }
                    })
                : CommentBox(
                    userImage:
                        "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg",
                    child: commentChild(comments),
                    labelText: 'Write a comment...',
                    withBorder: false,
                    errorText: 'Comment cannot be blank',
                    sendButtonMethod: () {
                      if (formKey.currentState!.validate()) {
                        print(commentController.text);
                        setState(() {
                          var value = CommentModel(
                              text: commentController.text,
                              uid: _auth.currentUser!.uid,
                              recipeId: menuRecipeModel.id,
                              date: DateFormat('yyyy-MM-dd HH:mm:ss')
                                  .format(DateTime.now()));
                          CommentHelper().insertDataToSQLite(value);
                          users.add(currentUser!);
                          comments.add(value);
                        });
                        commentController.clear();
                        FocusScope.of(context).unfocus();
                      } else {
                        print("Not validated");
                      }
                    },
                    formKey: formKey,
                    commentController: commentController,
                    backgroundColor: Colors.grey[200],
                    textColor: Colors.black,
                    sendWidget: Icon(Icons.send_sharp,
                        size: 30, color: Palette.roseBud),
                  ),
          ),
        ));
  }
}
