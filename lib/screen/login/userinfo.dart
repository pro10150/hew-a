import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hewa/screen/login/meal.dart';
import 'package:hewa/models/photo_model.dart';
import 'package:hewa/utilities/photo_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hewa/screen/login/user_image.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  int number = 0;
  String imageUrl = '';

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
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 35),
              hintText: 'DD/MM/YY',
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

  Widget buildnextBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: 320,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          var rount = new MaterialPageRoute(
              builder: (BuildContext context) => new Mealpre());
          Navigator.of(context).push(rount);
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

  Widget buildskipBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ('/'));
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
                        SizedBox(height: 120),
                        Stack(children: [
                          Container(
                              height: 650,
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
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                      // crossAxisAlignment:
                                      // CrossAxisAlignment.start,
                                      children: <Widget>[
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
                                        SizedBox(height: 20),
                                        buildbirthday(),
                                        SizedBox(height: 50),
                                        buildnextBtn(),
                                        SizedBox(height: 15),
                                        buildskipBtn(),
                                        // buildSignupBtn()
                                      ]))),
                          SizedBox(
                            height: 200,
                            width: 350,
                            child: Stack(
                                fit: StackFit.expand,
                                overflow: Overflow.visible,
                                children: [
                                  // Positioned(
                                  //   height: 100,
                                  //   width: 100,
                                  //   top: -50,
                                  //   right: -100,
                                  //   child: builcam(),
                                  // ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      UserImage(
                                        onFileChanged: (imageUrl) {
                                          setState(() {
                                            this.imageUrl = imageUrl;
                                          });
                                        },
                                      ),
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
                                ]),
                          ),
                        ]),
                      ]),
                ),
                // SizedBox(height: 150),
              )
            ],
          ),
        ),
      ),
    );
  }
}
