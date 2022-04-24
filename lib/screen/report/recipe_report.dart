import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:dart_ipify/dart_ipify.dart';
import 'package:hewa/screen/login/loginscreen.dart';
import 'package:hewa/models/report_join_model.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/utilities/report_join_helper.dart';
import 'package:hewa/utilities/menuRecipe_helper.dart';

import 'report_detail.dart';

class recipeReport extends StatefulWidget {
  const recipeReport({Key? key}) : super(key: key);

  @override
  _recipeReportState createState() => _recipeReportState();
}

class _recipeReportState extends State<recipeReport> {
  var _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;

  List<ReportJoinModel> recipeReports = [];
  List<MenuRecipeModel> menuRecipeModels = [];
  List<String> urls = [];

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        ModalRoute.withName('/'));
  }

  getReport() async {
    setState(() {
      recipeReports = [];
    });
    var objects = await ReportJoinHelper().getAllRecipeReport();
    for (var object in objects) {
      var recipe = await MenuRecipeHelper()
          .readWhereId(object.reportedRecipeId!.toString());
      if (object.isSolve == null) {
        setState(() {
          recipeReports.add(object);
          menuRecipeModels.add(recipe.first);
        });
        print(recipe.first.menuImage!);
        var ref = FirebaseStorage.instance
            .ref()
            .child('menus')
            .child(recipe.first.menuImage!);
        var image = await ref.getDownloadURL();
        setState(() {
          urls.add(image);
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReport();
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
                  "Recipe Report",
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
                      "${recipeReports.length} report alert",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            recipeReports.length > 0
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
    return ListView.builder(
      itemCount: recipeReports.length,
      itemBuilder: (_, index) {
        return Card(
          child: ListTile(
            title: menuRecipeModels[index].recipeName != null
                ? Text(menuRecipeModels[index].recipeName!)
                : Text(menuRecipeModels[index].nameMenu!),
            subtitle: Text(recipeReports[index].aboutName!),
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
                              reportDetail(recipeReports[index])))
                  .then((value) => getReport());
            },
          ),
        );
      },
    );
  }
}
