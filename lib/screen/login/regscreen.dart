import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'userinfo.dart';
import 'loginscreen.dart';
import 'package:hewa/utilities/user_helper.dart';
import 'package:hewa/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hewa/screen/launcher.dart';
import 'meal.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  Future<Null> readSQLite() async {
    var object = await UserHelper().readlDataFromSQLite();
    print('object length ==> ${object.length}');
    if (object.length != 0) {
      for (var model in object) {
        print(model.username);
      }
    } else {
      print('Found nothing!');
    }
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  signUp() async {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmController.text.trim();
    if (password == confirmPassword && password.length >= 6) {
      var object = await UserHelper().readDataFromSQLiteWhereUsername(username);
      if (object.length == 0) {
        _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((user) async {
          print('Sign up user successful');
          UserModel userModel =
              UserModel(uid: user.user!.uid, username: username);
          UserHelper();
          UserHelper().insertDataToSQLite(userModel);
          readSQLite();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserInformation()));
        }).catchError((error) {
          print(error.message.toString());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error.message.toString()),
          ));
        });
      } else {
        print('username has already been used');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Username has already been used')));
      }
    } else if (password != confirmPassword) {
      print('password doesn\' match');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password does not match'),
      ));
    } else if (password.length <= 6) {
      print('password\' too short');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Your password is too short, ther password should be longer than 6 characters'),
      ));
    }
  }

  Widget buildUser() {
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
            controller: usernameController,
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 35),
                hintText: 'Username',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
          ),
        )
      ],
    );
  }

  Widget buildEmail() {
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
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 35),
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
          ),
        )
      ],
    );
  }

  Widget buildPassword() {
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
            controller: passwordController,
            obscureText: true,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 35),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
          ),
        )
      ],
    );
  }

  Widget buildCFPassword() {
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
            controller: confirmController,
            obscureText: true,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 35),
                hintText: 'Confirm Password',
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

  Widget buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          signUp();
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: Colors.black,
        child: Text(
          'Register',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildLoginBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: '     I already have an account ?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: '  Login',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 250.0,
      child: Image.asset('lib/assets/logo/logoo.png'),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSQLite();
  }

  @override
  Widget build(BuildContext context) {
    final urlImage =
        "https://i.pinimg.com/564x/ee/a7/59/eea7597b2336cec27f04a875887bb2a6.jpg";
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
                // Container(
                //   height: 1400,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //     image: NetworkImage(urlImage),
                //     fit: BoxFit.fill,
                //   )),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        showLogo(),
                        Container(
                            height: 620,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                                padding: const EdgeInsets.only(top: 30.0),
                                margin: const EdgeInsets.only(
                                    left: 25.0, right: 25.0),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Register',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      buildUser(),
                                      SizedBox(height: 20),
                                      buildEmail(),
                                      SizedBox(height: 20),
                                      buildPassword(),
                                      SizedBox(height: 20),
                                      buildCFPassword(),
                                      SizedBox(height: 30),
                                      buildRegisterBtn(),
                                      buildLoginBtn()
                                    ]))),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
