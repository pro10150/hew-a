import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hewa/models/reStep_model.dart';
import 'package:page_transition/page_transition.dart';
import 'regscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hewa/screen/launcher.dart';
import 'package:hewa/utilities/db_helper.dart';
import 'package:hewa/utilities/recipe_helper.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isRememberMe = false;
  bool _passwordVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future checkAuth(BuildContext context) async {
    if (_auth.currentUser != null) {
      print('Already signed-in with');
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Launcher()));
      });
    }
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  signIn() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((user) {
      print("signed in ${user.additionalUserInfo!.username}");
      checkAuth(context);
    }).catchError((error) {
      print(error.message);
      var e = error.message;
      scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text(
          e,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    });
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
              hintText: 'email',
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
            obscureText: !_passwordVisible,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 35),
              hintText: 'Password',
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

  Widget buildRememberCb() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.black87,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember Me',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      child: RaisedButton(
        elevation: 2,
        onPressed: () {
          signIn();
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: Colors.black,
        child: Text(
          'Log in',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterScreen()));
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: '      Don\'t have an account ?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: '  Sign Up',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }

  // Widget buildButtonRegister() {
  //   return InkWell(
  //       onTap: () {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => RegisterScreen()));
  //   });
  // }

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
    Future.delayed(const Duration(milliseconds: 600), () {
      checkAuth(context);

      // DBHelper().deleteDB();
      DBHelper().database();
      // DBHelper().initInsert();
      _passwordVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final urlImage =
        "https://i.pinimg.com/564x/ee/a7/59/eea7597b2336cec27f04a875887bb2a6.jpg";
    return Scaffold(
      key: scaffoldKey,
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
                        showLogo(),
                        Container(
                            height: 470,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                                padding: const EdgeInsets.only(top: 40.0),
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
                                        'Login to',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'your account',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 15),
                                      buildEmail(),
                                      SizedBox(height: 20),
                                      buildPassword(),
                                      SizedBox(height: 20),
                                      buildLoginBtn(),
                                      buildSignupBtn()

                                      // buildSignupBtn()
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
