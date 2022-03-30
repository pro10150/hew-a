import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hewa/config/palette.dart';
import 'package:hewa/screen/home.dart';
import 'package:hewa/screen/fridge.dart';
import 'package:hewa/screen/profile.dart';
import 'package:hewa/screen/search.dart';
import 'package:hewa/screen/add.dart';
import 'package:hewa/screen/report/navbar.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/utilities/user_helper.dart';

class Launcher extends StatefulWidget {
  static const routeName = '/';

  const Launcher({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LauncherState();
  }
}

class _LauncherState extends State<Launcher> {
  int _selectedIndex = 0;
  var _auth = FirebaseAuth.instance;
  final List<Widget> _pageWidget = <Widget>[
    const Home(),
    const Search(),
    const Fridge(),
    const Profile(),
    const Add(),
  ];

  final List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(icon: Icon(MdiIcons.magnify), label: 'Search'),
    BottomNavigationBarItem(
        icon: Icon(MdiIcons.fridgeIndustrial), label: 'Fridge'),
    BottomNavigationBarItem(icon: Icon(MdiIcons.account), label: 'Profile'),
  ];

  getAdmin() async {
    var userModel =
        await UserHelper().readDataFromSQLiteWhereId(_auth.currentUser!.uid);
    if (userModel.first.isAdmin == 1) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ReportLauncher()));
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        elevation: 2.0,
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.add,
            size: 40,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Color(0xFFEC7063), Color(0xFFFFAB91)])),
        ),
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.topToBottom,
                child: Add(),
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
