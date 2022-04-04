import 'package:flutter/material.dart';
import 'package:hewa/screen/report/user_report.dart';
import 'package:hewa/screen/report/recipe_report.dart';

class ReportLauncher extends StatefulWidget {
  static const routeName = '/';
  const ReportLauncher({Key? key}) : super(key: key);

  @override
  _ReportLauncher createState() => _ReportLauncher();
}

class _ReportLauncher extends State<ReportLauncher> {

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const userReport(),
    const recipeReport(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Color(0xffffab91),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "User",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            label: "Recipe",
          ),
        ],
      ),
    );
  }
}
