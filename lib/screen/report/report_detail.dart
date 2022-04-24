import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:hewa/models/report_join_model.dart';
import 'package:hewa/models/reportImage_model.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/models/report_model.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/utilities/recipe_helper.dart';
import 'package:hewa/utilities/report_helper.dart';
import 'package:hewa/utilities/report_join_helper.dart';
import 'package:hewa/utilities/reportImage_helper.dart';
import 'package:hewa/utilities/menuRecipe_helper.dart';
import 'package:hewa/utilities/user_helper.dart';
import 'package:hewa/utilities/comment_helper.dart';
import 'package:hewa/utilities/like_helper.dart';

class ReportDetail extends StatefulWidget {
  @override
  _ReportDetailState createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class reportDetail extends StatefulWidget {
  reportDetail(this.reportModel);

  ReportJoinModel reportModel;
  @override
  _reportDetailState createState() => _reportDetailState(reportModel);
}

class _reportDetailState extends State<reportDetail> {
  _reportDetailState(this.reportModel);

  ReportJoinModel reportModel;
  MenuRecipeModel? menuRecipeModel;
  UserModel? userModel;
  Future<String>? url;
  List<ReportImageModel> reportImageModels = [];
  List<String> urls = [];

  getImage() async {
    var objects =
        await ReportImageHelper().readWhereId(reportModel.id.toString());
    for (var object in objects) {
      var ref = FirebaseStorage.instance
          .ref()
          .child("reports")
          .child(object.imagePath!);
      var image = await ref.getDownloadURL();
      setState(() {
        reportImageModels.add(object);
        urls.add(image);
      });
    }
  }

  getRecipe() async {
    var objects = await MenuRecipeHelper()
        .readWhereId(reportModel.reportedRecipeId.toString());
    var ref = FirebaseStorage.instance
        .ref()
        .child('menus')
        .child(objects.first.menuImage!);
    var image = ref.getDownloadURL();
    setState(() {
      menuRecipeModel = objects.first;
      url = image;
    });
  }

  getUser() async {
    var objects = await UserHelper()
        .readDataFromSQLiteWhereId(reportModel.reportedUid.toString());
    var image;
    if (objects.first.image != null) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('upload')
          .child(objects.first.image!);
      image = ref.getDownloadURL();
      setState(() {
        url = image;
      });
    }
    setState(() {
      userModel = objects.first;
    });
  }

  getTitle() async {
    if (reportModel.type == 1) {
      getUser();
    } else {
      getRecipe();
    }
  }

  buildImage() {
    return Expanded(
        child: urls.length > 0
            ? GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300.0,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                itemCount: urls.length,
                itemBuilder: (context, index) {
                  return Image.network(urls[index]);
                })
            : Text("No images was given"));
  }

  onDismiss() {
    reportModel.isSolve = 1;
    ReportModel report = ReportModel(
        id: reportModel.id,
        uid: reportModel.uid,
        type: reportModel.type,
        reportedUid: reportModel.reportedUid,
        reportedRecipeId: reportModel.reportedRecipeId,
        about: reportModel.about,
        text: reportModel.text,
        date: reportModel.date,
        isSolve: reportModel.isSolve);
    ReportHelper().updateDataToSQLite(report);
    Navigator.pop(context);
  }

  onApprove() async {
    var banDate = DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(DateTime.now().add(Duration(days: 3)));
    if (reportModel.type == 1) {
      if (userModel!.banTime == null) {
        userModel!.dateBanned = banDate;
        userModel!.banTime = 1;
        UserHelper().updateDataToSQLite(userModel!);
        ReportModel report = ReportModel(
            id: reportModel.id,
            uid: reportModel.uid,
            type: reportModel.type,
            reportedUid: reportModel.reportedUid,
            reportedRecipeId: reportModel.reportedRecipeId,
            about: reportModel.about,
            text: reportModel.text,
            date: reportModel.date,
            isSolve: 1);
        var i = await ReportHelper().updateAllUserToSQLite(report);
        print(i);
        Navigator.pop(context);
        Navigator.pop(context);
      } else if (userModel!.banTime! < 3) {
        userModel!.dateBanned = banDate;
        userModel!.banTime = userModel!.banTime! + 1;
        UserHelper().updateDataToSQLite(userModel!);
        ReportModel report = ReportModel(
            id: reportModel.id,
            uid: reportModel.uid,
            type: reportModel.type,
            reportedUid: reportModel.reportedUid,
            reportedRecipeId: reportModel.reportedRecipeId,
            about: reportModel.about,
            text: reportModel.text,
            date: reportModel.date,
            isSolve: 1);
        ReportHelper().updateAllUserToSQLite(report);
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        userModel!.isPermanentlyBan = 1;
        UserHelper().updateDataToSQLite(userModel!);
        RecipeHelper().deleteDataWhereUser(userModel!.uid!);
        CommentHelper().deleteDataWhereUser(userModel!.uid!);
        LikeHelper().deleteDataWhereUser(userModel!.uid!);
        ReportModel report = ReportModel(
            id: reportModel.id,
            uid: reportModel.uid,
            type: reportModel.type,
            reportedUid: reportModel.reportedUid,
            reportedRecipeId: reportModel.reportedRecipeId,
            about: reportModel.about,
            text: reportModel.text,
            date: reportModel.date,
            isSolve: 1);
        ReportHelper().updateAllUserToSQLite(report);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } else {
      ReportModel report = ReportModel(
          id: reportModel.id,
          uid: reportModel.uid,
          type: reportModel.type,
          reportedUid: reportModel.reportedUid,
          reportedRecipeId: reportModel.reportedRecipeId,
          about: reportModel.about,
          text: reportModel.text,
          date: reportModel.date,
          isSolve: 1);
      ReportHelper().updateAllUserToSQLite(report);
      RecipeHelper().deleteDataWhereId(reportModel.reportedRecipeId.toString());
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
    getTitle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
            padding: const EdgeInsets.all(75.0),
            child: reportModel.type == 1
                ? userModel!.name != null
                    ? Text(
                        '${userModel!.name}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : Text(
                        '${userModel!.username}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                : menuRecipeModel!.recipeName != null
                    ? Text(
                        '${menuRecipeModel!.recipeName}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : Text(
                        '${menuRecipeModel!.nameMenu}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
        backgroundColor: Color(0xffffab91),
        elevation: 0,
      ),
      backgroundColor: Color(0xffffab91),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 100.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: FutureBuilder<String>(
                            future: url,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data != null) {
                                  return CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          NetworkImage(snapshot.data!));
                                } else {
                                  return CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg"));
                                }
                              } else
                                return CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg"));
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        color: Colors.white),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Report about:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 35,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(50)),
                                child: FittedBox(
                                  child: Text(
                                    "${reportModel.aboutName}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "คำอธิบายเพิ่มเติม :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 40),
                              child: reportModel.text != null
                                  ? Text(
                                      "${reportModel.text}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    )
                                  : Text(
                                      "No details given",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "รูปภาพเพิ่มเติม :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        urls.length > 0
                            ? buildImage()
                            : Text("No images were found"),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                color: Colors.grey[200],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  "Dismiss report",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                onPressed: () {
                                  onDismiss();
                                },
                              ),
                              SizedBox(
                                width: 70,
                              ),
                              RaisedButton(
                                color: Colors.red[400],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  reportModel.type == 1
                                      ? "Block account"
                                      : "Delete reciepe",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            title: Text(reportModel.typeName! +
                                                " report"),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.5,
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    reportModel.type == 1
                                                        ? Text(
                                                            "Would you approve the report and ban this user?",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : Text(
                                                            "Would you approve the report and delete this recipe?",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                    reportModel.type == 1
                                                        ? userModel!.banTime !=
                                                                null
                                                            ? Text(
                                                                "This user has been banned ${userModel!.banTime} times")
                                                            : Text(
                                                                "This user has never been banned before")
                                                        : Container(),
                                                    SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.05),
                                                    reportModel.type == 1
                                                        ? Text(userModel!
                                                                        .banTime ==
                                                                    null ||
                                                                userModel!
                                                                        .banTime! <
                                                                    3
                                                            ? "Would you like to block this user?"
                                                            : "Would you like to permanently ban this user?")
                                                        : Container()
                                                  ]),
                                            ),
                                            actionsAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            actions: <Widget>[
                                              RaisedButton(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 10),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              RaisedButton(
                                                color: Colors.red,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 10),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Text(
                                                  "Confirm",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  onApprove();
                                                },
                                              ),
                                            ]);
                                      });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
