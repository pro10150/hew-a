import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hewa/screen/login/loginscreen.dart';
import 'report_detail.dart';
import 'package:hewa/models/report_join_model.dart';
import 'package:hewa/utilities/report_join_helper.dart';
import 'package:hewa/utilities/menu.helper.dart';
import 'package:hewa/models/menu_model.dart';
import 'package:hewa/models/reportAbout_model.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/utilities/user_helper.dart';
import 'package:hewa/utilities/reportAbout_helper.dart';

class userReport extends StatefulWidget {
  const userReport({Key? key}) : super(key: key);

  @override
  _userReportState createState() => _userReportState();
}

class _userReportState extends State<userReport> {
  var _auth = FirebaseAuth.instance;

  MenuModel? menuModel;
  MenuHelper? menuHelper;

  ReportAboutModel? reportAboutModel;
  ReportAboutHelper? reportAboutHelper;

  ReportJoinModel? reportModel;

  List<MenuModel> userMenu = [];

  List<ReportJoinModel> userReport = [];
  List<UserModel> users = [];
  List<String> urls = [];

  // void readSQLite() {
  //   ReportHelper().readlDataFromSQLite().then((userRe) {
  //     for (var model in userRe) {
  //       userReport.add(model);
  //     }
  //   });
  //   MenuHelper().readlDataFromSQLite().then((userMenus) {
  //     for (var model in userMenus) {
  //       userMenu.add(model);
  //     }
  //   });
  // }

  getReport() async {
    setState(() {
      userReport = [];
      users = [];
      urls = [];
    });
    var objects = await ReportJoinHelper().getAllUserReport();
    print(objects.length);
    for (var object in objects) {
      if (object.isSolve == null) {
        var user =
            await UserHelper().readDataFromSQLiteWhereId(object.reportedUid!);
        setState(() {
          userReport.add(object);
          users.add(user.first);
        });
        if (user.first.image != null) {
          var ref = FirebaseStorage.instance
              .ref()
              .child('upload')
              .child(user.first.image!);
          var image = await ref.getDownloadURL();
          setState(() {
            urls.add(image);
          });
        } else {
          urls.add(
              "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg");
        }
      }
    }
  }

  int count = 0;

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        ModalRoute.withName('/'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // readSQLite();
    getReport();
    // getUser();
  }

  Widget builduserReportBtn(int index) {
    return FutureBuilder<String>(
      // future: url,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            users[index].name != null
                ? Text(
                    users[index].name!,
                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  )
                : Text(
                    users[index].username!,
                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  )
          ];
        } else {
          children = <Widget>[CircularProgressIndicator()];
        }
        return Column(children: children);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "User Report",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () => signOut(context), icon: Icon(Icons.logout)),
          ],
        ),
        backgroundColor: Color(0xffffab91),
        elevation: 4.0,
      ),
      body: Container(
        height: 800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 35,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${userReport.length} report alert",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            userReport.length > 0
                ? Expanded(
                    child: _buildListReport(context),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Text("No report was found")),
          ],
        ),
      ),
      //ข้างล่าง
    );
  }

  Widget _buildListReport(BuildContext context) {
    // return Expanded(
    //   child: userReport.isNotEmpty
    //       ? ListView.builder(
    //       itemCount: userReport.length,
    //       itemBuilder: (context, index) {
    //         return Card(
    //           color: Colors.white,
    //           margin: EdgeInsets.all(3),
    //           child: ListTile(
    //             leading: Icon(
    //               Icons.perm_identity,
    //               size: 40,
    //             ),
    //             title: Text('${userReport[index].reportedUid}'),
    //             subtitle: Text('Follow : 0'),
    //             trailing: IconButton(
    //               onPressed: () {},
    //               icon: Icon(Icons.more_vert),
    //             ),
    //           ),
    //         );
    //       })
    //       : Text(
    //     'Not found',
    //     textAlign: TextAlign.center,
    //     style: TextStyle(
    //         fontSize: 20, fontWeight: FontWeight.w500),
    //   ),
    // );
    return ListView.builder(
      itemCount: userReport.length,
      itemBuilder: (_, index) {
        return Card(
          child: ListTile(
            title: users[index].name != null
                ? Text('${users[index].name}')
                : Text('${users[index].username}'),
            subtitle: Text(userReport[index].aboutName!),
            leading: CircleAvatar(
                radius: 50,
                backgroundImage: urls.length > index
                    ? NetworkImage(urls[index])
                    : NetworkImage(
                        "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg")),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              reportDetail(userReport[index])))
                  .then((value) => getReport());
            },
          ),
        );
      },
    );
  }

  Widget _countReport() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 35,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${index + 1}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
