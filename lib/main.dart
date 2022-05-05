import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hewa/config/palette.dart';
import 'package:hewa/screen/launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hewa/screen/login/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// ส่วนของ Stateless widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
//sssss
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Palette.roseBud,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          })),
      title: 'Hew\'a App',
      initialRoute: '/',
      home: SplashScreen(), // สามารถใช้ home แทนได้
      // routes: {
      //   LoginScreen.routeName: (context) => LoginScreen(),
      // },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    const color = const Color(0xffffab91);
    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            Image.asset(
              'lib/assets/icon/icon-original.png',
              height: 200,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Hew\'a App',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
