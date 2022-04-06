import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hewa/screen/login/meal.dart';
import 'package:hewa/models/photo_model.dart';
import 'package:hewa/utilities/photo_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hewa/screen/login/user_image.dart';
import 'dart:io';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:hewa/screen/login/round_image.dart';
import 'package:hewa/config/palette.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/utilities/user_helper.dart';
import '../launcher.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  int number = 0;
  // String imageUrl = '';
  DateTime date = DateTime(2022, 12, 24);
  File? _imageFile = null;
  var nameController = TextEditingController();
  var _auth = FirebaseAuth.instance;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadImageToFirebase() async {
    String fileName = basename(_imageFile!.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('upload')
        .child('/$fileName');
    var object =
        await UserHelper().readDataFromSQLiteWhereId(_auth.currentUser!.uid);
    var userModel = object.first;
    if (nameController.value.text != '') {
      userModel.name = nameController.text.trim();
    }

    userModel.image = fileName;
    UserHelper().updateDataToSQLite(userModel);
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileName});
    firebase_storage.UploadTask uploadTask;
    //late StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    uploadTask = ref.putFile(io.File(_imageFile!.path), metadata);

    firebase_storage.UploadTask task = await Future.value(uploadTask);
    Future.value(uploadTask)
        .then((value) => {print("Upload file path ${value.ref.fullPath}")})
        .onError((error, stackTrace) =>
            {print("Upload file path error ${error.toString()} ")});
  }

/*   Future<File>? imageFile;
  Image? image;
  PhotoHelper? photoHelper;
  List<Photo>? images;
  List<int>? readAsBytesSync;

  @override
  void initState() {
    super.initState();
    images = [];
    photoHelper = PhotoHelper();
    refreshImages();
  }

  refreshImages() {
    photoHelper?.getPhotos().then((imgs) {
      setState(() {
        images?.clear();
        images?.addAll(imgs);
      });
    });
  }
 */
/*   pickImageFromGallery() async {
    ImagePicker picker = ImagePicker();
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery).then((imgFile) {
      String imgString = Utility.base64String(imgFile.readAsBytesSync);
      Photo photo = Photo(id: 0, photoName: imgString);
      photoHelper?.save(photo);
      refreshImages();
    });
  } */

  Widget builcam() {
    return Container(
      width: 250.0,
      height: 250.0,
    );
  }

  Widget buildname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white)),
          height: 50,
          child: TextField(
            controller: nameController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 35),
              hintText: 'Nickname',
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }

  // Widget buildDate() {
  //   return Scaffold(
  //     body: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(dateTime == null ? 'Nothing has benn picked yet' : _dateTime.toString()),
  //         RaisedButton(
  //           child: Text("DD/MM/YY"),
  //             onPressed: () {
  //             showDatePicker(context: context,
  //                 initialDate: DateTime.now(),
  //                 firstDate: DateTime(1990),
  //                 lastDate: DateTime(2222)
  //             ).then((date) {
  //               setState(() {
  //                 _dateTime = date;
  //               });
  //             });
  //             }),
  //       ],
  //     ),
  //   );
  // }

  Widget buildbirthday() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white)),
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 35)),
                  Expanded(
                    child: Text(
                      '${date.year}/${date.month}/${date.day}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: SizedBox(
                        height: 30,
                        width: 5,
                        child: ElevatedButton(
                            child: Text("select",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                context: this.context,
                                initialDate: date,
                                firstDate: DateTime(1990),
                                lastDate: DateTime(2300),
                              );
                              if (newDate == null) return;
                              setState(() {
                                date = newDate;
                              });
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // child: TextField(
          //   keyboardType: TextInputType.emailAddress,
          //   style: TextStyle(color: Colors.black),
          //   decoration: InputDecoration(
          //     border: InputBorder.none,
          //     contentPadding: EdgeInsets.only(left: 35),
          //     hintText: 'DD/MM/YY',
          //     hintStyle: TextStyle(
          //       color: Colors.white,
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        )
      ],
    );
  }

  Widget buildnextBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: 320,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          var rount = new MaterialPageRoute(
              builder: (BuildContext context) => new Mealpre());
          Navigator.of(this.context).push(rount);

          uploadImageToFirebase();
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: Colors.black,
        child: Text(
          'Next',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildskipBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Launcher()));
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'Skip',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.double,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /* final urlImage =
        "https://i.pinimg.com/564x/ee/a7/59/eea7597b2336cec27f04a875887bb2a6.jpg"; */
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Color(0xffffffff),
                      Color(0xffff8a65),
                      Color(0xffe69a83),
                    ],
                    center: Alignment.topRight,
                    radius: 3,
                  ),
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 22),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 70),
                        Stack(
                          children: [
                            Container(
                                height: 700,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Container(
                                    padding: const EdgeInsets.only(top: 210.0),
                                    margin: const EdgeInsets.only(
                                        left: 25.0, right: 25.0),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(children: <Widget>[
                                      SizedBox(height: 45),
                                      Text(
                                        'User Info',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      SizedBox(height: 20),
                                      buildname(),
                                      // SizedBox(height: 20),
                                      // buildbirthday(),
                                      SizedBox(height: 50),
                                      buildnextBtn(),
                                      SizedBox(height: 15),
                                      buildskipBtn(context),
                                      // buildSignupBtn(),
                                    ]))),
                            // SizedBox(
                            //   height: 250,
                            //   width: 350,
                            //   child: Stack(
                            //     fit: StackFit.expand,
                            //     overflow: Overflow.visible,
                            //     children: [
                            // Positioned(
                            //   height: 100,
                            //   width: 100,
                            //   top: -50,
                            //   right: -100,
                            //   child: builcam(),
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 50),
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: SizedBox(
                                        height: 500,
                                        width: 500,
                                        child: (_imageFile != null)
                                            ? Image.file(_imageFile!,
                                                fit: BoxFit.fill)
                                            : FlatButton(
                                                onPressed: () {},
                                                child: IconButton(
                                                  icon: Icon(
                                                    FontAwesomeIcons.user,
                                                    color: Color(0xffe69a83),
                                                    size: 35,
                                                  ),
                                                  onPressed: () {},
                                                ))),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 100,
                                      child: TextButton(
                                        onPressed: () {
                                          pickImage();
                                        },
                                        child: Text(
                                          'select photo',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    )),
                              ],
                            ),

                            // UserImage(
                            //   onFileChanged: (imageUrl) {
                            //     setState(() {
                            //       this.imageUrl = imageUrl;
                            //     });
                            //   },
                            // ),
                          ],
                        ),

                        /* Positioned(
                                    top: 5,
                                    right: -110,
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: FlatButton(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            side: BorderSide(
                                                color: Colors.white24)),
                                        color: Colors.white,
                                        onPressed: () {},
                                        child: Icon(Icons.camera),
                                      ),
                                    ),
                                  ), */
                        // ),
                      ]),
                  // ]),
                ),
                // SizedBox(height: 150),
              )
            ],
          ),
        ),
      ),
    );
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
              onPressed: () => uploadImageToFirebase(),
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
