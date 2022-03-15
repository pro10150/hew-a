import 'package:comment_box/comment/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hewa/config/palette.dart';
import 'package:hewa/models/comment_model.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/utilities/user_helper.dart';

class commentPage extends StatefulWidget {
  commentPage(this.comments);
  List<CommentModel> comments;
  @override
  _commentPage createState() => _commentPage(comments);
}

class _commentPage extends State<commentPage> {
  _commentPage(this.comments);
  List<CommentModel> comments;
  List<UserModel> users = [];
  UserModel? currentUser;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {
      'name': 'Adeleye Ayodeji',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
  ];
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
                          child: commentChild(filedata),
                          labelText: 'Write a comment...',
                          withBorder: false,
                          errorText: 'Comment cannot be blank',
                          sendButtonMethod: () {
                            if (formKey.currentState!.validate()) {
                              print(commentController.text);
                              setState(() {
                                var value = {
                                  'name': 'New User',
                                  'pic':
                                      'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                                  'message': commentController.text
                                };
                                filedata.insert(0, value);
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
                        "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
                    child: commentChild(filedata),
                    labelText: 'Write a comment...',
                    withBorder: false,
                    errorText: 'Comment cannot be blank',
                    sendButtonMethod: () {
                      if (formKey.currentState!.validate()) {
                        print(commentController.text);
                        setState(() {
                          var value = {
                            'name': 'New User',
                            'pic':
                                'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                            'message': commentController.text
                          };
                          filedata.insert(0, value);
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
