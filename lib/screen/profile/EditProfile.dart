import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/screen/launcher.dart';
import 'package:hewa/utilities/user_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hewa/screen/profile.dart';
import 'package:hewa/screen/login/meal.dart';
import 'package:hewa/utilities/reAllergy_helper.dart';
import 'package:hewa/utilities/userKitch_helper.dart';
import 'package:hewa/utilities/userMenu_helper.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/';

  const EditProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  UserModel? userModel;
  List<UserModel> user = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getUsername() async {
    print(_auth.currentUser?.uid);

    UserHelper()
        .readDataFromSQLiteWhereId(_auth.currentUser!.uid)
        .then((value) {
      print(value);
      setState(() {
        user = value;
        if (user[0].name != '') {
          nameController.text = user[0].name!;
        }
        usernameController.text = user[0].username!;
      });
    });
  }

  void deletePreference() {
    var uid = _auth.currentUser!.uid;
    ReAllergyHelper().deleteDataWhereUser(uid);
    UserKitchHelper().deleteDataWhereUser(uid);
    UserMenuHelper().deleteDataWhereUser(uid);
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Edit Profile',
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // await Firebase.initializeApp().then((value) async {
                  //   await FirebaseAuth.instance.authStateChanges().listen((event) async{
                  //     event.updateDataToSQLite()
                  //    });
                  // });
                  // setState(() {
                  UserModel targetUser = user[0];
                  targetUser.name = nameController.value.text;
                  targetUser.username = usernameController.value.text;
                  _auth.currentUser?.updateDisplayName(targetUser.name);
                  UserHelper().updateDataToSQLite(targetUser);
                  navigateToProfilePage(context);
                  // UserHelper().updateDataToSQLite();
                  // });
                },
                icon: Icon(Icons.done))
          ],
        ),
        body: Container(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.grey)
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg"))),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                shape: BoxShape.circle,
                                color: Colors.lightGreen),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Name",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Username",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(""),
                    Text(""),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.only(
                            bottom: -1, top: -1, right: 42, left: 42),
                        onPressed: () {
                          deletePreference();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new Mealpre()));
                        },
                        color: Colors.black,
                        child: Text('Update Preference',
                            style: TextStyle(color: Colors.white)))
                  ],
                )),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.only(
                            bottom: -1, top: -1, right: 42, left: 42),
                        onPressed: () {},
                        color: Colors.black,
                        child: Text('Logout',
                            style: TextStyle(color: Colors.white)))
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}

void navigateToProfilePage(BuildContext context) async {
  Future.delayed(const Duration(milliseconds: 500), () {
    Navigator.pop(context);
  });
}
