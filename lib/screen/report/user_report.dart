import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hewa/screen/login/loginscreen.dart';
import 'report_detail.dart';
import 'package:hewa/models/report_model.dart';
import 'package:hewa/utilities/report_helper.dart';

class userReport extends StatefulWidget {
  const userReport({Key? key}) : super(key: key);

  @override
  _userReportState createState() => _userReportState();
}

class _userReportState extends State<userReport> {
  var _auth = FirebaseAuth.instance;

  ReportHelper? reportHelper;
  ReportModel? reportModel;

  List<ReportModel> userReport = [];

  void readSQLite() {
    ReportHelper().readlDataFromSQLite().then((userRe) {
      for (var model in userRe) {
        userReport.add(model);
      }
    });
  }

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
    readSQLite();
  }

  Widget builduserReportBtn(int index) {
    return FutureBuilder<String>(
      // future: url,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Text(
              userReport[index].reportedUid!,
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
                onPressed: () => signOut(context),
                icon: Icon(Icons.logout)),
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
                      "13 report alert",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _buildListReport(context),
            ),
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
      itemCount: 10,
      itemBuilder: (_, index) {
        return Card(
          child: ListTile(
            title: Text("iwanttosleep10hrchallenge"),
            subtitle: Text("somethinpullfromDB"),
            leading: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://pyxis.nymag.com/v1/imgs/f22/cee/18a5c624814d1fee69692841d2f92e89ad-21-homer-bushes-lede.rhorizontal.w700.jpg")),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => reportDetail()));
            },
          ),
        );
      },
    );
  }
}