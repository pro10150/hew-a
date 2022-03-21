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

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hewa/screen/profile/EditProfile.dart';
import 'dart:io';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:hewa/screen/login/round_image.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/';

  const EditProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditProfileState();
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
void deletePreference() {
  var uid = _auth.currentUser!.uid;
  ReAllergyHelper().deleteDataWhereUser(uid);
  UserKitchHelper().deleteDataWhereUser(uid);
  UserMenuHelper().deleteDataWhereUser(uid);
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  UserModel? userModel;
  List<UserModel> user = [];

  Future<String?> getUsername() async {
    print(_auth.currentUser?.uid);

    UserHelper()
        .readDataFromSQLiteWhereId(_auth.currentUser!.uid)
        .then((value) {
      print(value);
      setState(() {
        user = value;
        if (user[0].name != null) {
          nameController.text = user[0].name!;
        }
        usernameController.text = user[0].username!;
      });
    });
  }

  File? _imageFile = null;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile!.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('upload')
        .child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileName});
    firebase_storage.UploadTask uploadTask;
    //late StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    uploadTask = ref.putFile(io.File(_imageFile!.path), metadata);
    UserModel targetUser = user[0];
    if (nameController.value.text != "")
      targetUser.name = nameController.value.text;
    targetUser.username = usernameController.value.text;
    targetUser.image = fileName;
    _auth.currentUser?.updateDisplayName(targetUser.name);
    UserHelper().updateDataToSQLite(targetUser);

    firebase_storage.UploadTask task = await Future.value(uploadTask);
    Future.value(uploadTask)
        .then((value) => {print("Upload file path ${value.ref.fullPath}")})
        .onError((error, stackTrace) =>
            {print("Upload file path error ${error.toString()} ")});
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
                  uploadImageToFirebase(context);
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
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey,
                        child: ClipOval(
                          child: SizedBox(
                              height: 500,
                              width: 500,
                              child: (_imageFile != null)
                                  ? Image.file(_imageFile!, fit: BoxFit.fill)
                                  : Image.network(
                                      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                shape: BoxShape.circle,
                                color: Colors.lightGreen),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.camera,
                                size: 20.0,
                              ),
                              onPressed: () {
                                pickImage();
                              },
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
                          showConfirmation(context);
                          // deletePreference();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             new Mealpre()));
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

  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () => uploadImageToFirebase(context),
              child: Text(
                "Upload Image",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void navigateToProfilePage(BuildContext context) async {
  Future.delayed(const Duration(milliseconds: 500), () {
    Navigator.pop(context);
  });
}

showConfirmation(BuildContext context) {
  Widget okButton = TextButton(
      onPressed: () {
        deletePreference();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => new Mealpre()));
      },
      child: Text("OK"));
  Widget cancelButton = TextButton(
      onPressed: () {},
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.grey[400]),
      ));

  AlertDialog alert = AlertDialog(
    title: Text("Confirmation"),
    content: Text(
        "All your previous preferences, allergies and kitchenwares will be deleted. Do you want to continue?"),
    actions: [cancelButton, okButton],
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
